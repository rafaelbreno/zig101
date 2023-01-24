const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    print("\nWhile (counter < 5)\n", .{});

    var counter: u8 = 0;
    while (counter < 5) {
        print("counter: {d}\n", .{counter});
        counter += 1;
    }

    print("\nWhile true\n", .{});

    counter = 0;

    while (true) {
        if (counter == 5) {
            break;
        }
        print("counter: {d}\n", .{counter});
        counter += 1;
    }
}
