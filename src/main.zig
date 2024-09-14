const std = @import("std");
const token = @import("token/token.zig");

pub fn main() !void {
}

test "test lexer" {
    const input = "+";
    const result = std.mem.eql(u8, token.lexeme(token.Tag.plus).?, input);
    try std.testing.expect(result);
}
