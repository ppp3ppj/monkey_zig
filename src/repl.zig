const std = @import("std");
const lexer = @import("lexer");
const token = @import("token");

pub fn main() !void {
    var reader = std.io.getStdIn().reader();
    var buffer: [1024]u8 = undefined;

    while(try reader.readUntilDelimiterOrEof(&buffer, '\n')) |line| {
        var lex = lexer.Lexer.init(line);
        while(lex.has_tokens()) {
            const tk = lex.next_token();
            std.debug.print("{}\n", .{tk});
        }
    }
}
