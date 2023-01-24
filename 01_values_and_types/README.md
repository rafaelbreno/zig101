# Values and Types

## Summary
1. [Primitive Types](#primitive-types)
    - [Integer](#integer)
    - [Float](#float)
    - [Boolean](#boolean)
    - [Zero Bit Types](#zero-bit-types)
    - [void](#void)
    - [anyopaque](#anyopaque)
    - [noreturn](#noreturn)
    - [anyerror](#anyerror)
2. [Primitive Values](#primitive-values)
3. [Data Structures](#data-structures)
    - [Array](#array)
    - [Slice](#slice)
    - [Array vs Slice](#array-vs-alice)
    - [Vector](#vector)
    - [Struct](#struct)
        - [Struct Template](#struct-template)
        - [Packed Struct](#packed-struct)
        - [Struct Methods](#struct-methods)
    - [Enum](#enum)
        - [Enum Template](#enum-template)
        - [Typed Enum](#typed-enum)
        - [Enum Methods](#enum-methods)
    - [Union](#union)

## Primitive Types
_"[...][primitive data types](https://en.wikipedia.org/wiki/Primitive_data_type) are a set of basic data types from which all other data types are constructed.[...]"_

### Integer
- Signed:
    - `i8`, `i16`, `i32`, `i64`, `i128`
- Unsigned:
    - `u8`, `u16`, `u32`, `u64`, `u128`
### Float
- `f16`, `f32`, `f80`, `f128`

### Boolean
- `bool` - can be either `true` or `false`

### Zero Bit Types
Those are types that the _size of_ it is 0, some examples are:
    - `void`
    - Integers `i0` and `u0`
    - _Arrays_ and _Vectors_  with length equal zero
    - _Enum_ with 1 tag
    - Struct with all fields being zero bit types.
    - _Union_ with only 1 field

#### void
Functions that return `void` can be ignored(the assigned value).

### anyopaque
`anyopaque` have the same behavior as `void`, but the size of it is _unknown_, not zero.

### noreturn
Is the type of:
- `break`
- `continue`
- `return`
- `unreachable`
- `while (true) {}`

### anyerror
_"`anyerror` refers to the global error set. This is the error set that contains all errors in the entire compilation unit. It is a superset of all other error sets and a subset of none of them."_

## Primitive Values
- `true` and `false` 
    - `bool` values
- `null`
    - This value is used for [Optionals](TODO: ADD LINK)(We'll see more about it later.)
    - `const optionalInteger: ?i32 = 1234;`
        - You can define an `Optional` by adding the prefix `?` to the type(in this case `i32`), so the variable can be one of the two: `i32` or `null`
- `undefined`
    - Used to declare an uninitialized variables
    - `var x: i16 = undefined`

## Data Structures

### Array
- A data structure that contains a number of values
```zig
const hello: [_]u8{'h', 'e', 'l', 'l', 'o'};
const hello_2 = "hello";
// both hello and hello_2 are the same type and value.
```

### Slice
- A data structure that contains a number of values
```zig
var hello: [_]u8{'h', 'e', 'l', 'l', 'o'};
// both hello and hello_2 are the same type and value.
```

### Array vs Slice
- The difference between an `array` and a `slice` is that:
    - `array`' length is part of the type and known at compile-time.
    - `slice`' length is known at run-time.
### Vector
- Is a group of: `Booleans`, `Integers`, `Floats` or `Pointers`
- Is operated on in parallel using [SIMD(Single instruction, Multiple Data)](https://en.wikipedia.org/wiki/Single_instruction,_multiple_data) instructions.
- Created using the builtin function `@Vector`:
```zig
// @Vector(length, type)
// The length being a `comptime_int`(integer known at compilation-time)
const vector = @Vector(4, i32){1,2,3,4}
```
- Supports the same operations as their underlying base types:
    - Arithmetic: `+`, `-`, `*`, `/`, _..._
    - Bitwise: `>>`, `<<`, `&`, `|`, `~`, _..._
    - Comparison: `>`, `>=`, `<`, `<=`, _..._

### Struct
_"[...] composite data type declaration that defines a physically grouped list of variables under one name [...]"_

#### Struct Template
```zig
const Foo = struct {
    field_1: i32,
    field_2: []u8,
};
```
- `const Foo = struct {}`
    - `const` - keyword to declare a constant
    - `Foo` - the name of the constant
    - `= struct` - set the "type" to a struct
- `field_name: T,`
    - `field_name` - is the name of the field
    - `T` - is the type

#### Packed Struct
The `struct` declaration above on [Struct Template](#struct-template) won't have a great arrange, to have it you just need to add the `packed` keywork
```zig
const Foo = packed struct {
    field_1: i32,
    field_2: []u8,
};
```

#### Struct Instance
```zig
const Foo = packed struct {
    field_1: i32,
    field_2: []u8,
};

// can also be:
// var FooInstance = Foo { 
const FooInstance = Foo {
    .field_1 = 1234,
    .field_2 = "Hello, World",
}
```
- `const FooInstance = Foo {}`
    - `const` - keyword to declare a constant
    - `FooInstance` - the name of the constant
    - `= Foo` - set the "type" to a declared struct

#### Struct Methods
```zig
const Foo = packed struct {
    field_1: i32,
    field_2: []u8,

    pub fn init(field_1: i32, field_2: []u8) Foo {
        return Foo {
            .field_1 = field_1,
            .field_2 = field_2,
        };
    }
};

var fooInstance = Foo.init(1234, "Hello, World!");
// returns a:
// Foo {
//     .field_1 = 1234,
//     .field_2 = "Hello, World!",
// }
```

### Enum
Is a named constant.

#### Enum Template
```zig
const Status = enum {
    NotStarted,
    InDevelopment,
    Completed,
    Canceled,
};
```

#### Typed Enum
```zig
const TypedEnum = enum(u8) {
    NotStarted = 1,
    InDevelopment = 2,
    Completed = 3,
    Canceled = 4,
}
```

#### Enum Methods
```zig
const Status = enum {
    NotStarted,
    InDevelopment,
    Completed,
    Canceled,

    pub fn isCompleted(self: Status) bool {
        return self == Status.Completed;
    }
};
```

### Union
