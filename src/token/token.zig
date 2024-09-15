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
    function,
    let,
};
