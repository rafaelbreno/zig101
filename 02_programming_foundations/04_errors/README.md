# Errors

## Summary
1. [Type](#type)
2. [Template](#template)
    - [Enum like](#enum-like)
    - [Inline Declaration](#inline-declaration)
3. [Coerce](#coerce)
4. [anyerror](#anyerror)
5. [Returning Error](#returning-error)
6. [Error Handling](#error-handling)
    - [catch](#catch)
    - [try](#try)

## Type
The `error` type is _currently_ like a hard coded `enum(u16)`, there're proposals to make it flexible to set an _unsigned integer_ depending on the amount of declared errors.
When declaring the _errors_, _errors_ with the same name will have the same value, meaning, you can [_coerce_](#Coerce) them.

## Template

### Enum like
```zig
const AuthError = error{
    NotAuthorized,
    NotAdmin,
};
```
- `const AuthError = error{}`
    - `const` - constant declaration
    - `AuthError` - name of the constant
    - `error{}` - constant type `error`
- `NotAuthorized`
    - The error name.

### Inline Declaration
```zig
// You can declare an error using:
const NotString = error.NotString;
```

## Coerce
Two declared _errors_ with the same _identifier/name_ WILL have the same value:
```zig
const AuthError = error{
    NotAuthorized,
    NotAdmin,
};

const RoleError = error{
    NotAdmin,
};

pub fn main() !void {
    if (AuthError.NotAdmin == RoleError.NotAdmin) {
        print("AuthError.NotAdmin have the same value as RoleError.NotAdmin\n", .{});
    }
}
```

## anyerror
`anyerror` is a global error set, a _superset_ of all error, and a _subset_ of none, meaning:
```
AuthError = {NotAuthorized, NotAdmin}
RoleError = {NotAdmin}

anyerror = {AuthError, RoleError}
```

## Returning Error
```zig
fn addTwo(v: anytype) !u64 {
    if (@TypeOf(v) == u64) {
        return v + 2;
    }
    return error.NotU64;
}
```
The returning type `!u64` means that `addTwo` returns a _unsigned 64 bits integer_ or an _error_.

## Error Handling
### catch
`catch` allows you to define a default value if the returned value is an `error`:
```zig
var v = addTwo("a value") catch 1234;
// v value will be "1234" because addTwo expects an integer type.
```

### try
`try` will return immediately if the received value is an `error`.
```zig
fn addTwo(v: anytype) !u64 {
    if (@TypeOf(v) == u64) {
        return v + 2;
    }
    return error.NotU64;
}

fn addThree(v: anytype) !u64 {
    // if addTwo return an error, it will return immediately.
    const n = try addTwo(v);
    return n + 1;
}
```
