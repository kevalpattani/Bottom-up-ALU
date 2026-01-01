`timescale 1ns / 1ps

module main_alu(input logic[31:0] a,
                input logic[31:0] b,
                input logic[3:0] opcode,
                input logic[5:0] shift,
                output logic [63:0] out,
                output logic carry);
                
localparam ADD = 0;
localparam SUB = 1;
localparam MUL = 2;
localparam DIV = 3;
localparam FLS = 4; // Funnel Left Shift
localparam FRS = 5; // Funnel Right Shift
localparam RLS = 6; // Rotate Right Shift
localparam RRS = 7; // Rotate Left Shift

logic [31:0] sum_add;
logic [31:0] sum_sub;
logic carry_out_add;
logic carry_out_sub;
logic carry_out_div;
logic [63:0] output_m;
logic [63:0] output_d;
logic [63:0] output_fs;
logic [63:0] output_rs;
logic side_f;
logic side_r;

CLA add(.a(a),.b(b),.carry_cin(1'b0),.sum_cla(sum_add),.carry_cla(carry_out_add));

CLA sub(.a(a),.b(~b),.carry_cin(1'b1),.sum_cla(sum_sub),.carry_cla(carry_out_sub));

booth_algo multi(.a(a),.b(b),.c(output_m));

non_restoring_div div(.a(a),.b(b),.out(output_d),.sign_check(carry_out_div));

funnel_shift fShift(.a(a),.b(b),.side(side_f),.shift(shift),.out(output_fs));

rotate_shift rShift(.a(a),.b(b),.side(side_r),.shift(shift),.out(output_rs));

always_comb
begin
    case(opcode)
        ADD: begin
            out = {31'b0,carry_out_add,sum_add};
            carry = carry_out_add;
        end
        SUB: begin
            out = {31'b0,carry_out_sub,sum_sub};
            carry = carry_out_sub; 
        end
        MUL: begin
            out = output_m;
            carry = 1'b0;
        end
        DIV: begin
            out = output_d; // [63:32] is quotient, [31:0] is remainder.   
            carry = carry_out_div; // carry is sign notation, if the result of the division is negative carry will be 1 if its positive it will be 0
        end
        FLS: begin
            out = output_fs;
            side_f = 1'b1;
            carry = 1'b0;
        end
        FRS: begin
            out = output_fs;
            side_f = 1'b0;
            carry = 1'b0;
        end
        RLS: begin
            out = output_rs;
            side_r = 1'b0;
            carry = 1'b0;
        end
        RRS: begin
            out = output_rs;
            side_r = 1'b0;
            carry = 1'b0;
        end
    endcase           
end

endmodule
