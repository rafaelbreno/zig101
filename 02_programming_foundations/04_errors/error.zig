const std = @import("std");
const print = std.debug.print;

const AuthError = error{
    NotAuthorized,
    NotAdmin,
};

const RoleError = error{
    NotAdmin,
};

const NotString = error.NotString;

fn addTwo(v: anytype) !u64 {
    if (@TypeOf(v) == u64) {
        return v + 2;
    }
    return error.NotU64;
}

fn addThree(v: anytype) !u64 {
    // if addTwo return an error, it will return immediately.
    const n = try addTwo(v);
    return n + 1;
}

pub fn main() !void {
    if (AuthError.NotAdmin == RoleError.NotAdmin) {
        print("AuthError.NotAdmin have the same value as RoleError.NotAdmin\n", .{});
    }

    if (addTwo(@as(u64, 2))) |value| {
        print("2 plus 2 = {d}\n", .{value});
    } else |err| {
        print("Caught error: {}\n", .{err});
    }

    if (addTwo("string")) |value| {
        print("2 plus 2 = {d}\n", .{value});
    } else |err| {
        print("Caught error: {}\n", .{err});
    }
}
