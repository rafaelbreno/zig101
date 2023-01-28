# Memory

## Summary
1. [Introduction](#introduction)
    - [Memory](#memory)
        - [Memory Management](#memory-management)
        - [Memory Allocation](#memory-allocation)
            - [Address](#address)
            - [Heap vs Stack](#heap-vs-stack)
                - [Heap](#heap)
                - [Stack](#stack)
            - [Static vs Dynamic](#static-vs-dynamic)
                - [Static](#static)
                - [Dynamic](#dynamic)
        - [Data Buffer](#data-buffer)
2. [Allocators](#allocators)
    - [Use Cases](#use-cases)
    - [Where are the bytes](#where-are-the-bytes)
    - [Lifetime and Ownership](#lifetime-and-ownership)
        - [Lifetime](#lifetime)
        - [Ownership](#ownership)
    - [Writing an Allocator](#writing-an-allocator)
9. [Refererences](#references)

## Introduction

### Memory
_"In computing, memory is a device or system that is used to store information for immediate use in a computer [...]"_ (from [Wikipedia](https://en.wikipedia.org/wiki/Computer_memory))

### Memory Management
_"Memory management is a form of resource management applied to computer memory. The essential requirement of memory management is to provide ways to dynamically allocate portions of memory to programs at their request, and free it for reuse when no longer needed.[...]"_ (from [Wikipedia](https://en.wikipedia.org/wiki/Memory_management))

### Memory Allocation
_"Memory requests are satisfied by allocating portions from a large pool of memory called the **heap** or free store. [...]"_ 

#### Address
- The address go from `0` until the maximum amount of the machine, represented as a _base 16_ `0x00000000`:
    - `0x` - means _base 16_
    - Low address: `0x00000000`
    - High address: `0xFFFFFFFF`

#### Heap vs Stack

##### Heap
Heap is a pile of _free memory space_ for use during a program runtime, it's allocated during the runtime written by the developer.
- Located at `low address` section
- Is allocated explicitly by programmers and it won’t be deallocated until it is explicitly freed.

##### Stack
Stack Memory Allocation:
- The allocation and deallocation for stack memory is automatically done..
- _"[...]The size of memory to be allocated is known to the compiler and whenever a function is called, its variables get memory allocated on the stack. And whenever the function call is over, the memory for the variables is de-allocated.[...]"_ (from [GeekForGeeks](https://www.geeksforgeeks.org/stack-vs-heap-memory-allocation/))
- Located at `high address` section

#### Static vs Dynamic

##### Static
- Compile-time

##### Dynamic
- Run-time

#### Data Buffer
_"[...]a **data buffer** (or just buffer) is a region of a memory used to temporarily store data while it is being moved from one place to another. [...]"_
```zig
// buffer.zig
const std = @import("std");
const print = std.debug.print;
const Allocator = std.mem.Allocator;

pub fn main() !void {
    // declaring a variable with 100 bytes (u8), with no value (undefined).
    // undefined - means the value could be anything, even something that is nonsense according to the type.
    var buffer: [100]u8 = undefined;

    // Assigning the buffer(100 bytes) to a Fixed Buffer Allocator
    //  - Fixed - a static amount of bytes.
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    // Instantiating the Allocator.
    //  Allocator - Memory manager
    const allocator = fba.allocator();
    // getting the concatenation result
    const result = try concat(allocator, "foo", "bar");
    // comparando o tamanho
    // string = []char = []byte = []u8
    if (std.mem.eql(u8, "foobar", result)) {
        print("Both are equal", .{});
    } else {
        print("Different values", .{});
    }
}

// concat - appending values from B into A.
// A <- B
fn concat(allocator: Allocator, a: []const u8, b: []const u8) ![]u8 {
    // result -
    // Allocates an array of `n` items of type `T` and sets all the
    // items to `undefined`. Depending on the Allocator
    // implementation, it may be required to call `free` once the
    // memory is no longer needed, to avoid a resource leak. If the
    // `Allocator` implementation is unknown, then correct code will
    // call `free` when done.
    // Basically creating a memory section of type u8 with a length of (a.len + b.len)
    // result = [null,null,null,null,...]
    const result = try allocator.alloc(u8, a.len + b.len);
    // copying the value of A into result
    // result <- A
    // result = [a1, a2, a3, ..., aN, null,...]
    std.mem.copy(u8, result, a);
    // copying the value of B into result from the last item of A
    // result = [a1, a2, a3, ..., aN, b1, b2, b3, bN]
    std.mem.copy(u8, result[a.len..], b);
    return result;
    // char = 1 byte = 1 u8
    //  u8 - unsigned integer 8 bits - > 0
    //  u16 - unsigned integer 16 bits - > 0
    //  i8 - signed integer 8 bits
    //  i16 - signed integer 16 bits
}
```
[buffer.zig](./buffer.zig)

## Allocators

### Use Cases
1. _General Purpose:_
    - Use `GeneralPurposeAllocator` from `std.heap.GeneralPurposeAllocator`
2. _Library:_
    - Use `Allocator`(an interface) from `std.mem.Allocator`
    - Allows the developer
3. _Linking `libc`:_
    - Use `c_allocator` from `std.heap.c_allocator`
    - Allows you to use a Zig's allocator when Interoping with C.
4. _Comptime size:_
    - Can be used:
        - `FixedBufferAllocator` from `std.heap.FixedBufferAllocator`
        - `ThreadSafeFixedBufferAllocator` from `std.heap.ThreadSafeFixedBufferAllocator` for thread safety.
5. _Infinite Loop:_
    - e.g: game dev, webserver, CLI, etc.(any non cyclical pattern)
    - Use `ArenaAllocator` from `std.heap.ArenaAllocator`
6. _Test:_
    - Use `allocator` from `std.testing.allocator`
7. _Failing Tests:_
    - Use `FailingAllocator` from `std.testing.FailingAllocator`

If none of the cases match your use case, you can write [your own allocator](#writing-an-allocator)

### Where are the bytes
```zig
// constant - value known at compile time
// stored at global constant data section.
const foo = "value_one";

// var declared at the top level is
// stored at global data section.
var bar = "value_two";

const Baz = struct {
    // var declared in struct is
    // stored at global data section.
    var field = "value_three";
};

fn getLen(s: []type) !u32 {
    // variables declared inside functions
    // are stored in the function's stack frame.
    var qux = "value_four";
    _ = qux;

    // Once a function returns, any Pointers to variables
    // inside of it will become invalid references.
    return s.len;
}

pub fn main() !void {
    // constant - value known at compile time
    // stored at global constant data section.
    const fred = "value_four";
    _ = fred;
}
```

### Lifetime and Ownership

#### Lifetime
Is the period of a variable has a valid memory.
[**(WIP)**Example: lifetime.zig](./lifetime.zig)

#### Ownership

### Writing an Allocator

## Refererences
- [Illinois Edu](https://courses.engr.illinois.edu/cs225/fa2022/resources/stack-heap/)
- [Memory Management(Wikipedia)](https://en.wikipedia.org/wiki/Memory_management)
- [Data Buffer](https://en.wikipedia.org/wiki/Data_buffer)
