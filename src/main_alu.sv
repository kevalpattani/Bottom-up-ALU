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
logic [63:0] output_m_d;

CLA add(.a(a),.b(b),.carry_cin(1'b0),.sum_cla(sum),.carry_cla(carry_out));

CLA sub(.a(a),.b(~b),.carry_cin(1'b1),.sum_cla(sum),.carry_cla(carry_out));

booth_algo multi(.a(a),.b(b),.c(output_m_d));

non_restoring_div div(.a(a),.b(b),.out(output_m_d),.sign_check(carry_out));

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
            out = output_m_d;
            carry = 1'b0;
        end
        DIV: begin
            out = output_m_d; // [63:32] is quotient, [31:0] is remainder.   
            carry = carry_out; // carry is sign notation, if the result of the division is negative carry will be 1 if its positive it will be 0
        end
    endcase           
end

endmodule
