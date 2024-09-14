const std = @import("std");

pub const Token = struct {
    Type: Tag,
    Literal: [:0]const u8,
};

pub const Tag = enum { illegal, eof, ident, int, assign, plus, comma, semicolon, lparen, rparen, lbrace, rbrace, function, let };

pub fn lexeme(tag: Tag) ?[]const u8 {
    return switch(tag) {
        .illegal => "ILLEGAL",
        .eof => "EOF",
        .ident => "IDENT",
        .int => "INT",
        .assign => "=",
        .plus => "+",
        .comma => ",",
        .semicolon => ";",
        .lparen => "(",
        .rparen => ")",
        .lbrace => "{",
        .rbrace => "}",
        .function => "FUNCTION",
        .let => "LET",
    };
}
