const std = @import("std");
const lexer = @import("lexer");

pub fn main() !void {
    const l = lexer.Lexer.init("+-");
    std.debug.print("{s}", .{l.input});
}
