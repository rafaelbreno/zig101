const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
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
}
