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
