# Ruby Brainfuck Interpreter

For ruby ver. 2.7.0

## What is this?

This is a [brainfuck](https://esolangs.org/wiki/Brainfuck) interpreter written
in ruby.

## Why?

It's sounds like a cool challenge to implement a interpreter for a esoteric
language in another language

## Is this any good?

No. The interpreter can "interpret" small programs (maybe big ones) and input is
not implemented (yet). It is not optimized at all (and will never be).

## How I use this?

You can feed the ruby file a brainfuck file so it can interpret, I left in 2
examples, you can execute then as:
```
$ ruby interpreter.rb hello_world.bf
```
or...
```
$ ruby interpreter.rb bug_catching_hello_world.rb
```
Try some brainfuck programs yourself! (Input command not implemented)
