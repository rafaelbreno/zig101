const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    print("----------example 1----------\n\n", .{});
    try example1();
    print("\n\n----------example 2----------\n\n", .{});
    try example2();
}

fn example1() !void {
    var alloc = std.heap.GeneralPurposeAllocator(.{}){};
    var array = std.ArrayList(u8).init(alloc.allocator());
    defer _ = alloc.deinit();
    defer array.deinit();

    print("Before Appending:\n", .{});

    print("\t    val: {any}\n", .{array.items});
    print("\t    cap: {d}\n", .{array.capacity});
    //const ptr = &array;
    print("\taddress: {*}\n", .{&(array.items)});

    var i: u8 = 0;
    while (i < 10) {
        try array.append(i);
        i += 1;
    }

    print("After Appending:\n", .{});
    print("\t    val: {any}\n", .{array.items});
    print("\t    cap: {d}\n", .{array.capacity});
    print("\taddress: {*}\n", .{&(array.items)});
}

fn example2() !void {
    // creating
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var alloc = gpa.allocator();

    var hello = try alloc.dupe(u8, "hello world");
    print("before free:\n", .{});
    {
        print("\t  value: {any}\n", .{hello});
        print("\taddress: {*}\n", .{&hello});
    }

    alloc.free(hello);
    print("after free:\n", .{});
    {
        print("\taddress: {*}\n", .{&hello});
    }

    const init_queue = [5]usize{ 0, 1, 2, 3, 4 };
    var queue = try std.ArrayList(usize).initCapacity(alloc, init_queue.len);
    print("before appending:\n", .{});
    {
        print("\t  value: {any}\n", .{queue.items});
        print("\taddress: {*}\n", .{&(queue.items)});
    }
    try queue.appendSlice(&init_queue);
    print("after appending:\n", .{});
    {
        print("\t  value: {any}\n", .{queue.items});
        print("\taddress: {*}\n", .{&(queue.items)});
    }
    for (queue.items) |*value| {
        value.* += 1;
        try queue.append(value.*);
    }

    print("after iterating:\n", .{});
    {
        print("\t  value: {any}\n", .{queue.items});
        print("\taddress: {*}\n", .{&(queue.items)});
    }
}
