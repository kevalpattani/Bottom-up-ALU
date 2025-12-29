`timescale 1ns / 1ps

module main_alu(input logic[31:0] a,
                input logic[31:0] b,
                input logic[3:0] opcode,
                output logic [63:0] out,
                output logic carry);
                
localparam ADD = 0;
localparam SUB = 1;
localparam MUL = 2;
localparam DIV = 3;
localparam RSH = 4;
localparam LSH = 5;
localparam BOR = 6;
localparam BAN = 7;

logic [31:0] sum;
logic carry_out;
logic [63:0] mul;

CLA add(.a(a),.b(b),.carry_cin(1'b0),.sum_cla(sum),.carry_cla(carry_out));

CLA sub(.a(a),.b(~b),.carry_cin(1'b1),.sum_cla(sum),.carry_cla(carry_out));

booth_algo(.a(a),.b(b),.c(mul));

always_comb
begin
    case(opcode)
        ADD: begin
            out = {31'b0,carry_out,sum};
            carry = carry_out;
        end
        SUB: begin
            out = {31'b0,carry_out,sum};
            carry = carry_out; 
        end
        MUL: begin
            out = mul;
            carry = 1'b0;
        end
    endcase           
end

endmodule
