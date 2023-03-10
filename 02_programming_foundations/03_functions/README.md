# Functions

## Summary
1. [Template](#template)
2. [Pass by Value](#pass-by-value)
3. [Recursion](#recursion)

## Template
```zig
fn add(n1: i32, n2: i32) i32 {
    return n1 + n2;
}
```
- `fn add(n1: i32, n2: i32) i32 {}`
    - `fn` - keyword to define a function
    - `add` - name of the function, used to call it
    - `(n1: i32, n2: i32)` - parameters that will be received by the function
        - `n1: i32`
            - `n1` - parameter name
            - `i32` - parameter type
    - `) i32 {}` - type of the `returned` value

## Pass by Value
From [Pass-by-value Parameters](https://ziglang.org/documentation/master/#Pass-by-value-Parameters):
- _"Primitive types such as Integers and Floats passed as parameters are copied [...] Copying a primitive type is **essentially free** and typically involves nothing more than setting a register.[...]"_
- _"[...]Structs, unions, and arrays can sometimes be more efficiently passed as a reference, since a copy could be arbitrarily expensive depending on the size. [...] Zig may choose to copy and pass by value, or pass by reference [...] by the fact that parameters are immutable. [...]"_
```zig
const Point = struct {
    x: f64,
    y: f64,
    fn abs(self: Point) f64 {
        return math.sqrt((self.x * self.x) + (self.y * self.y));
    }
};
var p = Point{
    .x = 2,
    .y = 2,
};
print("\tAbs(Point 2, 2) = {}\n", .{p.abs()});
```

## Recursion
Read more about at [Recursion Status(from 0.3 update)](https://ziglang.org/download/0.3.0/release-notes.html#recursion)
```zig
fn fib(n: u64) u64 {
    if (n < 2) {
        return n;
    }
    return fib(n - 1) + fib(n - 2);
}
```
