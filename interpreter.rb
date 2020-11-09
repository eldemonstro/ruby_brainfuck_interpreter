# We are using a creating a new class to use as an memory array so we can use 0
# as default for an array
class MemoryArray < Array
  def [](index)
     self.at(index) ? self.at(index) : 0
  end
end

input_file_path = ARGV.join
input_file = File.read(input_file_path)
input = input_file.split('')

# First we remove everything that is not a brainfuck command, this is to make we
# "think less" about where our program is

input.filter! { |char| char =~ /[><+-.,\[\]]/ }

# mem_pointer points to what position in the memory cell we are now
mem_pointer = 0
# A memory array for memory cells
mem_cells = MemoryArray.new
# A stack memory array so we can know where to go to with jumps
stack = MemoryArray.new
# needle points to where in the program we are now
needle = 0

# Now we can start interpreting, looking at our input (which should be an array
# of commands, in order) we can interpret each command as follows:
#
# Command | Description
# >       | Move the pointer to the right
# <       | Move the pointer to the left
# +       | Increment the memory cell at the pointer
# -       | Decrement the memory cell at the pointer
# .       | Output the character signified by the cell at the pointer
# ,       | Input a character and store it in the cell at the pointer
# [       | Jump past the matching ] if the cell at the pointer is 0
# ]       | Jump back to the matching [ if the cell at the pointer is nonzero

# We are going to go through a loop until the program ends
# Since arrays start at zero "input.length" returns the last position of the
# input plus one so it includes the position zero, making that position the one
# after the last, we can interpret as the program ending
while(needle != input.length)
  # We are going across our program, the needle will go across too
  case input[needle]
  when '>' # Move pointer to the right
    mem_pointer += 1
    needle += 1
  when '<' # Move pointer to the left
    mem_pointer -= 1
    needle += 1
  when '+' # Increment the memory cell at the pointer
    mem_cells[mem_pointer] += 1
    needle += 1
  when '-' # Decrement the memory cell at the pointer
    mem_cells[mem_pointer] -= 1
    needle += 1
  when '.' # Output the character signified by the cell at the pointer
    print mem_cells[mem_pointer].chr
    needle += 1
  when ',' # Input a character and store it in the cell at the pointer
    mem_cells[mem_pointer] = gets.strip.to_i
    needle += 1
  when '[' # Jump past the matching ] if the cell at the pointer is 0
    stack.push(needle) # If we have to return here we know where this is

    # Things will get complicated from here (oh no), if the cell is 0 we need to
    # go to the matching ], but the matching ] maybe is not the next ], so we
    # can have a problem, but let's solve that
    if mem_cells[mem_pointer] == 0
      fake_needle = needle
      open_loops = 1
      while(open_loops > 0)
        raise if fake_needle == input.length
        fake_needle += 1
        open_loops += 1 if input[fake_needle] == '['
        open_loops -= 1 if input[fake_needle] == ']'
      end
      needle = fake_needle
    else
      needle += 1
    end
  when ']' # Jump back to the matching [ if the cell at the pointer is nonzero
    # Things are easer here, if the pointer is nonzero we pop our stack (that is
    # the position of the matching [) and jump to where we need
    if mem_cells[mem_pointer] != 0
      needle = stack.pop
    else
      needle += 1
      stack.pop # We are not going back anymore so we just pop out of existence
    end
  else
    raise
  end
end


