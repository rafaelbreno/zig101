// constant - value known at compile time
// stored at global constant data section.
const foo = "value_one";

// var declared at the top level is
// stored at global data section.
var bar = "value_two";

const Baz = struct {
    // var declared in struct is
    // stored at global data section.
    var field = "value_three";
};

fn getLen(s: []type) !u32 {
    // variables declared inside functions
    // are stored in the function's stack frame.
    var qux = "value_four";
    _ = qux;

    // Once a function returns, any Pointers to variables
    // inside of it will become invalid references.
    return s.len;
}

pub fn main() !void {
    // constant - value known at compile time
    // stored at global constant data section.
    const fred = "value_four";
    _ = fred;
    // constant -
    _ = "foo";
}
