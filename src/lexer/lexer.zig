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
            '=' => .assign,
            '{' => .lsquirly,
            '}' => .rsquirly,
            '(' => .lparen,
            ')' => .rparen,
            ',' => .comma,
            ';' => .semicolon,
            '+' => .plus,
            0 => .eof,
            'a'...'z', 'A'...'Z', '_' => {
                const ident = self.read_identifier();

                return .{.ident = ident};
            },
            else => .illegal,
        };

        self.read_char();
        return tok;
    }

    fn isLetter(ch: u8) bool {
        return std.ascii.isAlphabetic(ch) or ch == '_';
    }

    fn read_identifier(self: *Self) []const u8 {
        const position = self.position;

        while(isLetter(self.ch)) {
            self.read_char();
        }

        return self.input[position..self.position];
    }
};
