const std = @import("std");

pub fn main() !void {
    const print = std.debug.print;

    print("Hello, {s}!\n", .{"world"});
}
