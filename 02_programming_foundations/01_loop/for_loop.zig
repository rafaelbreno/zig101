const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    var items = [_]u32{ 123, 23, 3, 456, 56, 7 };

    print("Foreach - Iterate values\n", .{});

    for (items) |value| {
        print("Value {d}\n", .{value});
    }

    print("\nForeach- Iterate position and values\n", .{});

    for (items) |value, i| {
        print("{d} - Value {d}\n", .{ i, value });
    }

    print("\nForeach - Iterate position\n", .{});

    for (items) |_, i| {
        print("Position {d}\n", .{i});
    }

    print("\nForeach - Sliced Array\n", .{});

    // [2; 5)
    for (items[2..5]) |value, i| {
        print("{d} - Value {d}\n", .{ i, value });
    }

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
}
