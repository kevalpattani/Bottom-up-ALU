`timescale 1ns / 1ps

module CLA (input logic [31:0]a,b,
            input logic carry_cin,
            output logic [31:0]sum_cla,
            output logic carry_cla);
 
logic [31:0] p,g; 
logic [7:0] g_nxt,p_nxt;
logic [8:0] c_new;

assign p = a ^ b;
assign g = a & b;  
           
CLA_C_process carry_p(.cin(carry_cin),.g_nxt(g_nxt),.p_nxt(p_nxt),.c_new(c_new));

CLA_block_4bit first(.a(a[3:0]),.b(b[3:0]),.cin(c_new[0]),.p(p[3:0]),.g(g[3:0]),.sum_cla(sum_cla[3:0]),.g_nxt(g_nxt[0]),.p_nxt(p_nxt[0]));
CLA_block_4bit second(.a(a[7:4]),.b(b[7:4]),.cin(c_new[1]),.p(p[7:4]),.g(g[7:4]),.sum_cla(sum_cla[7:4]),.g_nxt(g_nxt[1]),.p_nxt(p_nxt[1]));
CLA_block_4bit third(.a(a[11:8]),.b(b[11:8]),.cin(c_new[2]),.p(p[11:8]),.g(g[11:8]),.sum_cla(sum_cla[11:8]),.g_nxt(g_nxt[2]),.p_nxt(p_nxt[2]));
CLA_block_4bit fourth(.a(a[15:12]),.b(b[15:12]),.cin(c_new[3]),.p(p[15:12]),.g(g[15:12]),.sum_cla(sum_cla[15:12]),.g_nxt(g_nxt[3]),.p_nxt(p_nxt[3]));
CLA_block_4bit fifth(.a(a[19:16]),.b(b[19:16]),.cin(c_new[4]),.p(p[19:16]),.g(g[19:16]),.sum_cla(sum_cla[19:16]),.g_nxt(g_nxt[4]),.p_nxt(p_nxt[4]));
CLA_block_4bit sixth(.a(a[23:20]),.b(b[23:20]),.cin(c_new[5]),.p(p[23:20]),.g(g[23:20]),.sum_cla(sum_cla[23:20]),.g_nxt(g_nxt[5]),.p_nxt(p_nxt[5]));
CLA_block_4bit seventh(.a(a[27:24]),.b(b[27:24]),.cin(c_new[6]),.p(p[27:24]),.g(g[27:24]),.sum_cla(sum_cla[27:24]),.g_nxt(g_nxt[6]),.p_nxt(p_nxt[6]));
CLA_block_4bit eighth(.a(a[31:28]),.b(b[31:28]),.cin(c_new[7]),.p(p[31:28]),.g(g[31:28]),.sum_cla(sum_cla[31:28]),.g_nxt(g_nxt[7]),.p_nxt(p_nxt[7]));       
           
assign carry_cla = c_new[8];           
           
endmodule
