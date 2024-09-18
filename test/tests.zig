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
        \\let ten = 10;
        \\let add = fn(x, y) {
        \\  x + y;
        \\};
        \\let result = add(five, ten);
    ;

    var lex = lexer.Lexer.init(input);
    const tokens = [_]token.Token{
        .let,
        .{.indent = "five"},
        .assign,
        .{.int = "5"},
        .semicolon,
        .let,
        .{.indent = "ten"},
        .assign,
        .{.int = "10"},
        .semicolon,
        .let,
        .{.indent = "add"},
        .assign,
        .function,
        .lparen,
        .{.indent = "x"},
        .comma,
        .{.indent = "y"},
        .rparen,
        .lsquirly,
        .{.indent = "x"},
        .plus,
        .{.indent = "y"},
        .semicolon,
        .rsquirly,
        .semicolon,
        .let,
        .{.indent = "result"},
        .assign,
        .{.int = "add"},
        .lparen,
        .{.indent = "five"},
        .comma,
        .{.indent = "ten"},
        .rparen,
        .semicolon,

        .eof,
    };

    for (tokens) |t| {
        const tok = lex.next_token();

        try expectEqualDeep(t, tok);
    }
}
