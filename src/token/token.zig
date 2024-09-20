const std = @import("std");

pub const Token = union(enum) {
    ident: []const u8,
    int: []const u8,

    illegal,
    eof,
    assign,
    plus,
    comma,
    semicolon,
    lparen,
    rparen,
    lsquirly,
    rsquirly,

    equal,

    let,
    function,
    if_token,
    return_token,

    pub fn keyword(ident: []const u8) ?Token {
        const map = std.StaticStringMap(Token).initComptime(.{
        .{ "let", .let },
        .{ "fn", .function },
        .{ "if", .if_token },
        .{ "return", .return_token },
        });

        return map.get(ident);
    }
};
