const std = @import("std");
const math = std.math;
const print = std.debug.print;

fn add(n1: i32, n2: i32) i32 {
    return n1 + n2;
}

fn fib(n: u64) u64 {
    if (n < 2) {
        return n;
    }
    return fib(n - 1) + fib(n - 2);
}

const Point = struct {
    x: f64,
    y: f64,
    fn abs(self: Point) f64 {
        return math.sqrt((self.x * self.x) + (self.y * self.y));
    }
};

pub fn main() !void {
    print("Function Add(n1, n2)\n", .{});
    {
        print("\tadd(1,2) = {d}\n", .{add(1, 2)});
        print("\tadd(32,-64) = {d}\n", .{add(32, -64)});
    }

    print("\nFunction VectorAbs(p: Point)\n", .{});
    var p = Point{
        .x = 2,
        .y = 2,
    };
    {
        print("\tAbs{{Point 2, 2}} = {d:.3}\n", .{p.abs()});
    }

    print("\nFunction fib(b: u64)\n", .{});
    {
        print("\tfib(2): {d}\n", .{fib(2)});
        print("\tfib(3): {d}\n", .{fib(3)});
        print("\tfib(4): {d}\n", .{fib(4)});
        print("\tfib(5): {d}\n", .{fib(5)});
    }
}
