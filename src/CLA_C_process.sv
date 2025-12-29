`timescale 1ns / 1ps

module CLA_C_process(input logic cin,
                     input logic[7:0] g_nxt,p_nxt,
                     output logic[8:0] c_new);
                      
assign c_new[0] = cin;

assign c_new[1] = g_nxt[0] | 
                  (p_nxt[0] & cin);
                  
assign c_new[2] = g_nxt[1] | 
                  (p_nxt[1] & g_nxt[0]) | 
                  (p_nxt[0] & p_nxt[1] & cin);

assign c_new[3] = g_nxt[2] | 
                  (p_nxt[2] & g_nxt[1]) | 
                  (p_nxt[2] & p_nxt[1] & g_nxt[0]) | 
                  (p_nxt[0] & p_nxt[1] & p_nxt[2] & cin);

assign c_new[4] = g_nxt[3] | 
                  (p_nxt[3] & g_nxt[2]) | 
                  (p_nxt[3] & p_nxt[2] & g_nxt[1]) | 
                  (p_nxt[3] & p_nxt[2] & p_nxt[1] & g_nxt[0]) | 
                  (p_nxt[3] & p_nxt[2] & p_nxt[1] & p_nxt[0] & cin);

assign c_new[5] = g_nxt[4] | 
                  (p_nxt[4] & g_nxt[3]) | 
                  (p_nxt[4] & p_nxt[3] & g_nxt[2]) | 
                  (p_nxt[4] & p_nxt[3] & p_nxt[2] & g_nxt[1]) | 
                  (p_nxt[4] & p_nxt[3] & p_nxt[2] & p_nxt[1] & g_nxt[0]) | 
                  (p_nxt[4] & p_nxt[3] & p_nxt[2] & p_nxt[1] & p_nxt[0] & cin);

assign c_new[6] = g_nxt[5] | 
                  (p_nxt[5] & g_nxt[4]) | 
                  (p_nxt[5] & p_nxt[4] & g_nxt[3]) | 
                  (p_nxt[5] & p_nxt[4] & p_nxt[3] & g_nxt[2]) | 
                  (p_nxt[5] & p_nxt[4] & p_nxt[3] & p_nxt[2] & g_nxt[1]) | 
                  (p_nxt[5] & p_nxt[4] & p_nxt[3] & p_nxt[2] & p_nxt[1] & g_nxt[0]) | 
                  (p_nxt[5] & p_nxt[4] & p_nxt[3] & p_nxt[2] & p_nxt[1] & p_nxt[0] & cin);

assign c_new[7] = g_nxt[6] | 
                  (p_nxt[6] & g_nxt[5]) | 
                  (p_nxt[6] & p_nxt[5] & g_nxt[4]) | 
                  (p_nxt[6] & p_nxt[5] & p_nxt[4] & g_nxt[3]) | 
                  (p_nxt[6] & p_nxt[5] & p_nxt[4] & p_nxt[3] & g_nxt[2]) | 
                  (p_nxt[6] & p_nxt[5] & p_nxt[4] & p_nxt[3] & p_nxt[2] & g_nxt[1]) | 
                  (p_nxt[6] & p_nxt[5] & p_nxt[4] & p_nxt[3] & p_nxt[2] & p_nxt[1] & g_nxt[0]) | 
                  (p_nxt[6] & p_nxt[5] & p_nxt[4] & p_nxt[3] & p_nxt[2] & p_nxt[1] & p_nxt[0] & cin);
                  
assign c_new[8] = g_nxt[7] | 
                  (p_nxt[7] & g_nxt[6]) | 
                  (p_nxt[7] & p_nxt[6] & g_nxt[5]) | 
                  (p_nxt[7] & p_nxt[6] & p_nxt[5] & g_nxt[4]) | 
                  (p_nxt[7] & p_nxt[6] & p_nxt[5] & p_nxt[4] & g_nxt[3]) | 
                  (p_nxt[7] & p_nxt[6] & p_nxt[5] & p_nxt[4] & p_nxt[3] & g_nxt[2]) | 
                  (p_nxt[7] & p_nxt[6] & p_nxt[5] & p_nxt[4] & p_nxt[3] & p_nxt[2] & g_nxt[1]) | 
                  (p_nxt[7] & p_nxt[6] & p_nxt[5] & p_nxt[4] & p_nxt[3] & p_nxt[2] & p_nxt[1] & g_nxt[0]) |
                  (p_nxt[7] & p_nxt[6] & p_nxt[5] & p_nxt[4] & p_nxt[3] & p_nxt[2] & p_nxt[1] & p_nxt[0] & cin);
                   
endmodule
