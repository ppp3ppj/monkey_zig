const std = @import("std");
const token = @import("token");
//const token = @import("../token/token.zig");

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

    pub fn has_tokens(self: *Self) bool {
        return self.ch != 0;
    }

    pub fn read_char(self: *Self) void {
        if (self.read_position >= self.input.len) {
            self.ch = 0;
        } else {
            self.ch = self.input[self.read_position];
        }
        self.position = self.read_position;
        self.read_position += 1;
    }

    fn peek_char(self: *Self) u8 {
        if (self.read_position >= self.input.len) {
            return 0;
        } else {
            return self.input[self.read_position];
        }
    }

    pub fn next_token(self: *Self) token.Token {
        self.skip_whitespace();

        const tok: token.Token = switch (self.ch) {
            '=' => blk: {
                if (self.peek_char() == '=') {
                    self.read_char();
                    break :blk .equal;
                } else {
                    break :blk .assign;
                }
            },
            '{' => .lsquirly,
            '}' => .rsquirly,
            '(' => .lparen,
            ')' => .rparen,
            ',' => .comma,
            ';' => .semicolon,
            '+' => .plus,
            '-' => .minus,
            '!' => blk: {
                if (self.peek_char() == '=') {
                    self.read_char();
                    break :blk .not_equal;
                } else {
                    break :blk .bang;
                }
            },
            '/' => .slash,
            '*' => .asterisk,
            '<' => .less_than,
            '>' => .greater_than,
            0 => .eof,
            'a'...'z', 'A'...'Z', '_' => {
                const ident = self.read_identifier();
                if (token.Token.keyword(ident)) |t| {
                    return t;
                }
                return .{ .ident = ident };
            },
            '0'...'9' => {
                const int = self.read_int();
                return .{ .int = int };
            },
            else => .illegal,
        };

        self.read_char();
        return tok;
    }

    fn isInt(ch: u8) bool {
        return std.ascii.isDigit(ch);
    }
    fn read_int(self: *Self) []const u8 {
        const position = self.position;

        while (isInt(self.ch)) {
            self.read_char();
        }

        return self.input[position..self.position];
    }

    fn skip_whitespace(self: *Self) void {
        while (std.ascii.isWhitespace(self.ch)) {
            self.read_char();
        }
    }

    fn isLetter(ch: u8) bool {
        return std.ascii.isAlphabetic(ch) or ch == '_';
    }

    fn read_identifier(self: *Self) []const u8 {
        const position = self.position;

        while (isLetter(self.ch)) {
            self.read_char();
        }

        return self.input[position..self.position];
    }
};
