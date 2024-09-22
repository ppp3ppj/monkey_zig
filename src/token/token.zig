const std = @import("std");

pub const Token = union(enum) {
    ident: []const u8,
    int: []const u8,

    illegal,
    eof,
    comma,
    semicolon,
    lparen,
    rparen,
    lsquirly,
    rsquirly,

    equal,
    not_equal,

    assign,
    plus,
    minus,
    bang,
    dash,
    asterisk,
    slash,

    less_than,
    greater_than,

    let,
    function,
    if_token,
    else_token,
    true_token,
    false_token,
    return_token,

    pub fn keyword(ident: []const u8) ?Token {
        const map = std.StaticStringMap(Token).initComptime(.{
            .{ "let", .let },
            .{ "fn", .function },
            .{ "if", .if_token },
            .{ "else", .else_token },
            .{ "true", .true_token },
            .{ "false", .false_token },
            .{ "return", .return_token },
        });

        return map.get(ident);
    }
};
