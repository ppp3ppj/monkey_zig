const std = @import("std");
const lexer = @import("lexer");
const token = @import("token");
const expectEqualDeep = std.testing.expectEqualDeep;
test "Lexer" {
    const input = "=+(){},;";
    var lex = lexer.Lexer.init(input);

    const tokens = [_]token.Token{
        .assign,
        .plus,
        .lparen,
        .rparen,
        .lsquirly,
        .rsquirly,
        .comma,
        .semicolon,
        .eof,
    };

    for (tokens) |c_token| {
        const tok = lex.next_token();

        try expectEqualDeep(c_token, tok);
    }

    // uncomment to print out Token.Tag fields
    // std.log.warn("Token.Tag fields:", .{});
    // inline for (std.meta.fields(Token.Tag)) |f| {
    //     std.log.warn("{s}", .{f.name});
    // }
}

test "Lexer - Full" {
    const input =
        \\let five = 5;
    ;

    var lex = lexer.Lexer.init(input);
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

        try expectEqualDeep(t, tok);
    }
}
