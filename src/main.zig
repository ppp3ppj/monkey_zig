const std = @import("std");
const lexer = @import("lexer");
const token = @import("token");

pub fn main() !void {

    var lex = lexer.Lexer.init("let five = 5;");
    const tokens = [_]token.Token{
        .let,
        .{.ident = "five"},
        .assign,
        .{.int = "5"},
        .semicolon,

        .eof,
    };

    for (tokens) |t| {
        const tok = lex.next_token();
        std.debug.print("{s} at token: {s}", .{tok, t});
    }
}
