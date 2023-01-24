# Programming Foundations

## Summary
1. [Loops](#loops)
    - [For Loop](#for-loop)
        - [Foreach Value](#foreach-value)
        - [Foreach Value and Position](#foreach-value-and-position)
        - [Foreach Position](#foreach-position)
        - [Foreach Slice](#foreach-slice)
        - [For Reference](#for-reference)
    - [While](#while)
        - [While Condition](#while-condition)
        - [While True](#while-true)
## Loops
You can run the examples on: [for_loop.zig](./for_loop.zig)

### For Loop

#### Foreach Value
- Iterate through the items:
```zig
print("For Loop - Iterate values\n", .{});

for (items) |value| {
    print("Value {d}\n", .{value});
}
```

#### Foreach Value and Position
```zig
print("For Loop - Iterate position and values\n", .{});

for (items) |value, i| {
    print("{d} - Value {d}\n", .{ i, value });
}
```

#### Foreach Position
```zig
print("For Loop - Iterate position\n", .{});

for (items) |_, i| {
    print("Position {d}\n", .{i});
}
```

#### Foreach Slice
You can slice an array using the `[first..last]` syntax, being in math notation: `[first; last)`
```zig
print("\nForeach - Sliced Array\n", .{});

// [2; 5)
for (items[2..5]) |value, i| {
    print("{d} - Value {d}\n", .{ i, value });
}
```

#### For Reference
```zig
print("\nFor Reference\n", .{});

// [2; 5)
for (items) |value| {
    print("Before: {d}\n", .{value});
}

// Multiplying each item by 2
for (items) |*value| {
    // We'll learn more about references later.
    value.* *= 2;
}
print("\n", .{});
for (items) |value| {
    print("After: {d}\n", .{value});
}
```

### While
To write something like this:
```go
// NOT ZIG
for var i int = i; i < 5; i++ {
    // do something
}
```
You will use `while`

#### While Condition
```zig
print("\nWhile (counter < 5)\n", .{});

var counter: u8 = 0;
while (counter < 5) {
    print("counter: {d}\n", .{counter});
    counter += 1;
}
```
#### While True
```zig
print("\nWhile true\n", .{});

counter = 0;

while (true) {
    if (counter == 5) {
        break;
    }
    print("counter: {d}\n", .{counter});
    counter += 1;
}
```
