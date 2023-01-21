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
