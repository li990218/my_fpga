`include "../../lib/EECS151.v"

module structural_adder #(
    parameter N = 3
) (
    input [N-1:0] a,
    input [N-1:0] b,
    input clk,
    output [N:0] sum
);
    // TODO: Your code (from lab 2). You need to parameterize i
    wire [N:0] carry_in;
    wire [N-1:0] out;
    assign carry_in[0] = 1'b0;
    genvar i;
    generate
    for (i = 0; i < N ; i = i + 1) begin: label
    full_adder full (.a(a[i]), .b(b[i]), .carry_in(carry_in[i]), 
    .sum(out[i]), .carry_out(carry_in[i+1]));
    end
    endgenerate
    
    wire [N:0] sum_inter;
    assign sum_inter = {carry_in[N], out};
    REGISTER #(N+1) reg1(.clk(clk), .d(sum_inter), .q(sum));
    
endmodule
