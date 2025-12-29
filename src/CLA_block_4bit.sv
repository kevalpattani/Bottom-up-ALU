`timescale 1ns / 1ps

module CLA_block_4bit(input logic[3:0]a,b,
                      input logic cin,
                      input logic [3:0]p,g,
                      output logic[3:0]sum_cla,
                      output logic g_nxt,p_nxt);
                     
logic[3:0] cout;                     
                     
assign cout[0] = cin;
assign cout[1] = g[0] | (p[0] & cout[0]);
assign cout[2] = g[1] | (p[1] & g[0]) | (p[0] & p[1] & cout[0]);
assign cout[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[0] & p[1] & p[2] & cout[0]);

assign g_nxt = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[0] & p[1] & p[2] & g[0]) | (p[0] & p[1] & p[2] & p[3] & g[0]);
assign p_nxt = p[0] & p[1] & p[2] & p[3];

assign sum_cla[3:0] = p[3:0] ^ cout[3:0];
                  
endmodule
