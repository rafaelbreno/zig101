const std = @import("std");
const print = std.debug.print;
const Allocator = std.mem.Allocator;

pub fn main() !void {
    // declaring a variable with 100 bytes (u8), with no value (undefined).
    // undefined - means the value could be anything, even something that is nonsense according to the type.
    var buffer: [100]u8 = undefined;

    // Assigning the buffer(100 bytes) to a Fixed Buffer Allocator
    //  - Fixed - a static amount of bytes.
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    // Instantiating the Allocator.
    //  Allocator - Memory manager
    const allocator = fba.allocator();
    // getting the concatenation result
    const result = try concat(allocator, "foo", "bar");
    // comparando o tamanho
    // string = []char = []byte = []u8
    if (std.mem.eql(u8, "foobar", result)) {
        print("Both are equal", .{});
    } else {
        print("Different values", .{});
    }
}

// concat - appending values from B into A.
// A <- B
fn concat(allocator: Allocator, a: []const u8, b: []const u8) ![]u8 {
    // result -
    // Allocates an array of `n` items of type `T` and sets all the
    // items to `undefined`. Depending on the Allocator
    // implementation, it may be required to call `free` once the
    // memory is no longer needed, to avoid a resource leak. If the
    // `Allocator` implementation is unknown, then correct code will
    // call `free` when done.
    // Basically creating a memory section of type u8 with a length of (a.len + b.len)
    // result = [null,null,null,null,...]
    const result = try allocator.alloc(u8, a.len + b.len);
    // copying the value of A into result
    // result <- A
    // result = [a1, a2, a3, ..., aN, null,...]
    std.mem.copy(u8, result, a);
    // copying the value of B into result from the last item of A
    // result = [a1, a2, a3, ..., aN, b1, b2, b3, bN]
    std.mem.copy(u8, result[a.len..], b);
    return result;
    // char = 1 byte = 1 u8
    //  u8 - unsigned integer 8 bits - > 0
    //  u16 - unsigned integer 16 bits - > 0
    //  i8 - signed integer 8 bits
    //  i16 - signed integer 16 bits
}
