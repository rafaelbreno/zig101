const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    var alloc = std.heap.GeneralPurposeAllocator(.{}){};
    alloc.setRequestedMemoryLimit(5);
    var array = std.ArrayList(u8).init(alloc.allocator());
    defer _ = alloc.deinit();
    defer array.deinit();

    print("Before Appending:\n", .{});

    print("\t    val: {any}\n", .{array.items});
    print("\t    cap: {d}\n", .{array.capacity});
    //const ptr = &array;
    print("\taddress: {*}\n", .{&(array.items)});
    print("\taddress: {*}\n", .{&(array)});

    var i: u8 = 0;
    while (i < 100) {
        try array.append(i);
        i += 1;
    }

    print("After Appending:\n", .{});
    print("\t    val: {any}\n", .{array.items});
    print("\t    cap: {d}\n", .{array.capacity});
    print("\taddress: {*}\n", .{&(array.items)});
    print("\taddress: {*}\n", .{&(array)});
}
