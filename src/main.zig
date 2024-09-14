const std = @import("std");
const token = @import("token/token.zig");
const lexer = @import("lexer/lexer.zig");

pub fn main() !void {
    const l = lexer.Lexer.init("+-");
    std.debug.print("{s}", .{l.input});
}

test "test lexer" {
    const input = "+";
    const result = std.mem.eql(u8, token.lexeme(token.Tag.plus).?, input);
    try std.testing.expect(result);
}
