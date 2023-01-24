const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
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
}
