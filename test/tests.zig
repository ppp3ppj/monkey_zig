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

        \\!-/*5;
        \\5 < 10 > 5;

        \\if (5 < 10) {
        \\  return true;
        \\} else {
        \\  return false;
        \\}
    ;
    var lex = lexer.Lexer.init(input);
    const tokens = [_]token.Token{
        .let,
        .{ .ident = "five" },
        .assign,
        .{ .int = "5" },
        .semicolon,
        .let,
        .{ .ident = "ten" },
        .assign,
        .{ .int = "10" },
        .semicolon,
        .let,
        .{ .ident = "add" },
        .assign,
        .function,
        .lparen,
        .{ .ident = "x" },
        .comma,
        .{ .ident = "y" },
        .rparen,
        .lsquirly,
        .{ .ident = "x" },
        .plus,
        .{ .ident = "y" },
        .semicolon,
        .rsquirly,
        .semicolon,
        .let,
        .{ .ident = "result" },
        .assign,
        .{ .ident = "add" },
        .lparen,
        .{ .ident = "five" },
        .comma,
        .{ .ident = "ten" },
        .rparen,
        .semicolon,

        .bang,
        .minus,
        .slash,
        .asterisk,
        .{.int = "5"},
        .semicolon,

        .{.int = "5"},
        .less_than,
        .{.int = "10"},
        .greater_than,
        .{.int = "5"},
        .semicolon,

        .if_token,
        .lparen,
        .{.int = "5"},
        .less_than,
        .{.int = "10"},
        .rparen,
        .lsquirly,
        .return_token,
        .true_token,
        .semicolon,
        .rsquirly,
        .else_token,
        .lsquirly,
        .return_token,
        .false_token,
        .semicolon,
        .rsquirly,

        .eof,
    };

    for (tokens) |t| {
        const tok = lex.next_token();

        try expectEqualDeep(t, tok);
    }
}
