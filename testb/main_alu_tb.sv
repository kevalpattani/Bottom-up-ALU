`timescale 1ns / 1ps

module main_alu_tb;
reg[31:0] a,b;
reg[2:0]  opcode;
reg[5:0]  shift;
wire[63:0] out;
wire carry;

main_alu DUT (.a(a),.b(b),.opcode(opcode),.shift(shift),.out(out),.carry(carry));

initial
begin
    a = 0;
    b = 0;
    opcode = 0;
    shift = 0;

        #10 opcode = 3'b000; 
            a = 32'd23;
            b = 32'd12;
            shift = 0;

        #10 opcode = 3'b000; 
            a = 32'hFFFFFFFF;
            b = 32'd1;

        #10 opcode = 3'b001;
            a = 32'd50;
            b = 32'd20;

        #10 opcode = 3'b001;
            a = 32'd10;
            b = 32'd25;

        #10 opcode = 3'b010; 
            a = 32'd7;
            b = 32'd6;

        #10 opcode = 3'b010; 
            a = 32'd1000;

        #10 opcode = 3'b011; 
            a = 32'd100;
            b = 32'd10;

        #10 opcode = 3'b011;
            a = 32'd103;
            b = 32'd10;

        #10 opcode = 3'b100; 
            a = 32'hAAAA_AAAA;
            b = 32'h5555_5555;
            shift = 6'd4;

        #10 opcode = 3'b101; 
            a = 32'hAAAA_AAAA;
            b = 32'h5555_5555;
            shift = 6'd4;

        #10 opcode = 3'b110;
            a = 32'h1234_5678;
            b = 32'h8765_4321;
            shift = 6'd8;

        #10 opcode = 3'b111;
            a = 32'h1234_5678;
            b = 32'h8765_4321;
            shift = 6'd8;

        #20 $finish;
    end

endmodule
