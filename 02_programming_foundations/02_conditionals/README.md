# Conditionals

## Summary
1. [If](#if)
2. [If Else](#if-else)
3. [Switch](#switch)

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

## Switch
```zig
print("Switch based on Value:\n", .{});
var list = [_]i32{ 1, 2, 3, 10, 100, 1000 };
for (list) |value| {
    switch (value) {
        1, 2, 3 => {
            print("\tValue caught is between 1 and 3: {d}\n", .{value});
        },
        10...99 => {
            print("\tValue caught is between 10 and 99: {d}\n", .{value});
        },
        100...999 => {
            print("\tValue caught is between 100 and 999: {d}\n", .{value});
        },
        else => {
            print("\tValue doesn't have a case: {d}\n", .{value});
        },
    }
}

print("\nSwitch based on Enum:\n", .{});
const Status = enum {
    NotStarted,
    InDevelopment,
    Completed,
    Canceled,
};

var myStatus = Status.InDevelopment;

switch (myStatus) {
    Status.InDevelopment => {
        print("\tInDevelopment\n", .{});
    },
    Status.NotStarted => {
        print("\tNotStarted\n", .{});
    },
    Status.Completed => {
        print("\tCompleted\n", .{});
    },
    Status.Canceled => {
        print("\tCanceled\n", .{});
    },
}
```
