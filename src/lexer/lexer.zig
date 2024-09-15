const std = @import("std");
const token = @import("token");

pub const Lexer = struct {
    const Self = @This();
    input: []const u8,
    position: usize = 0,
    read_position: usize = 0,
    ch: u8 = 0,

    pub fn init(input: []const u8) Self {
        var lex = Self{
            .input = input,
        };

        lex.read_char();
        return lex;
    }

    pub fn read_char(self: *Self) void {
        if(self.read_position >= self.input.len) {
            self.ch = 0;
        } else {
            self.ch = self.input[self.read_position];
        }
        self.position = self.read_position;
        self.read_position += 1;
    }

    pub fn next_token(self: *Self) token.Token {
        const tok: token.Token = switch(self.ch) {
            '{' => .lsquirly,
            '}' => .rsquirly,
            '(' => .lparen,
            ')' => .rparen,
            ',' => .comma,
            ';' => .semicolon,
            '+' => .plus,
            0 => .eof,
            else => .illegal,
        };

        self.read_char();
        return tok;
    }
};
