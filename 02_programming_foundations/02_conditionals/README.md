# Conditionals

## Summary
1. [If](#if)

## If
Example at: [if.zig](./if.zig)
There're three _types_ supported by `if` statements:
- `bool` 
    - Boolean(_true_ or _false_)
- `?T` 
    - [_Optionals_](https://ziglang.org/documentation/master/#Optionals)
    - We'll see more about it later.
- `anyerror!T` 
    - [_Error Union Type_](https://ziglang.org/documentation/master/#Error-Union-Type)
    - We'll see more about it later.

```zig
print("If - Boolean\n", .{});
if (true) {
    print("Entered in this case\n", .{});
}

var opt: ?i32 = null;

print("\nIf - Optionals - Null\n", .{});
if (opt) |_| {
    print("Won't print it\n", .{});
}

var opt2: ?i32 = 1234;

print("\nIf - Optionals - With Value\n", .{});
if (opt2) |v| {
    print("Caught the value: {d}\n", .{v});
}
```

## If Else
Example at: [if_else.zig](./if_else.zig)
```zig
const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    print("If Else - Boolean\n", .{});
    if (true) {
        print("Entered in this case\n", .{});
    } else {
        print("Caught in else\n", .{});
    }

    var opt: ?i32 = null;

    print("\nIf Else - Optionals - Null\n", .{});
    if (opt) |_| {
        print("Won't print it\n", .{});
    } else {
        print("Value is null\n", .{});
    }

    var opt2: ?i32 = 1234;

    print("\nIf Else - Optionals - With Value\n", .{});
    if (opt2) |v| {
        print("Caught the value: {d}\n", .{v});
    } else {
        print("Won't print it\n", .{});
    }
}
```
