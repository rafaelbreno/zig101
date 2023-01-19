# Introduction

## Summary
1. [What is Zig101](#what-is-zig101)
2. [What is Zig](#what-is-zig)
    - [A Simple Language](#a-simple-language)
    - [Comptime](#comptime)
    - [Maintain it with Zig](#maintain-it-with-zig)
3. [Environment Setup](#environment-setup)
    - [Linux](#linux)
        - [ASDF](#asdf)
4. [Hello World](#hello-world)
    - [Code](#code)
    - [Running it](#running-it)
    - [Explanation](#explanation)

## What is Zig101
Zig101 is my documented journey studying the [Zig Language](https://ziglang.org/) as if I was explaining to someone.

## What is Zig
_"Zig is a general-purpose programming language and toolchain for maintaining robust, optimal and reusable software."_

### A Simple Language
_"Focus on debugging your application rather than debugging your programming language knowledge."_
- _"No hidden [control flow](https://en.wikipedia.org/wiki/Control_flow)."_
- _"No hidden [memory allocations](https://en.wikipedia.org/wiki/Manual_memory_management)."_ 
    - You will handle it manually
- _"No [preprocessor](https://en.wikipedia.org/wiki/Preprocessor), no [macros](https://en.wikipedia.org/wiki/Macro_(computer_science))."_

### Comptime
A fresh approach to metaprogramming based on compile-time code execution and lazy evaluation.
- _"Call any function at compile-time."_
- _"Manipulate types as values without [runtime overhead](https://en.wikipedia.org/wiki/Overhead_(computing))."_
- _"Comptime emulates the target architecture."_

### Maintain it with Zig
Incrementally improve your C/C++/Zig codebase.

- _"Use Zig as a zero-dependency, drop-in C/C++ compiler that supports cross-compilation out-of-the-box."_
- _"Leverage `zig build` to create a consistent development environment across all platforms."_
- _"Add a Zig compilation unit to C/C++ projects; cross-language LTO is enabled by default."_

## Environment Setup

### Linux

#### ASDF
- > $ asdf plugin-add zig https://github.com/cheetah/asdf-zig.git
    - Add the plugin into ASDF
- > $ asdf install zig latest
    - Install Zig's latest version
- > $ asdf global zig latest
    - Link Zig's latest version to the whole OS

## Hello World
Let's write a simple _"Hello World"_ program and try to understand what's happening there:

### Code

```zig
const std = @import("std");

pub fn main() !void {
    const print = std.debug.print;

    print("Hello, {s}!\n", .{"world"});
}
```

### Running it
- Create a file e.g `hello_world.zig`
- Paste the code above inside of it, and then:
- > $ zig run hello_world.zig
- The output should be:
    - _Hello, world!_

### Explanation

- `const std = @import("std");`
    - `const` keyword declares a _constant_.
    - `std` is the name of the constant
    - `@import("std")` 
        - `@` is the prefixer for ALL [_builtin_ functions](https://ziglang.org/documentation/master/#Builtin-Functions).
        - `@import` imports a library.
        - `@import("std")` imports the standard library.
- `pub fn main() !void`
    - `pub` defines a _public_ _something_
    - `fn` defines a function
    - `main()` the name of the function
        - For programs, the `main()` will bootstrap the application.
    - `!void` is a _[Error Union Type](https://ziglang.org/documentation/master/#Error-Union-Type)_
- `const print = std.debug.print;`
    - `const` keyword declares a _constant_.
    - `print` is the name of the constant
    - `std.debug.print;` is the value of it.
- `print("Hello, {s}!\n", .{"world"});`
    - `print()` call the function
    - `"Hello, {s}!\n"` - the value to be printed
        - `{s}` - value to be injected
        - `.{}` - defines a _[tuple](https://en.wikipedia.org/wiki/Tuple)_
