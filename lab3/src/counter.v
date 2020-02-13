`include "../../lib/EECS151.v"

module counter #(
    parameter N = 4,
    parameter RATE_HZ = 1
) (
    input clk,
    input rst_counter,
    input [N-1:0] rst_counter_val,
    output [N-1:0] counter_output
);

    wire [N-1:0] inter_count1;
    wire [N-1:0] inter_count2;
    
    wire [31:0] count1;
    wire [31:0] count2;
    wire is_sec, reset;
    
    REGISTER_CE #(N) reg1(.clk(clk), .ce(is_sec),
    .q(inter_count1), .d(inter_count2));
    
    
    REGISTER_R #(32) reg2(.clk(clk), .rst(is_sec), .q(count1), .d(count2));
    
    assign inter_count2 = (rst_counter == 1) ? rst_counter_val : inter_count1 + 1;

    assign is_sec = (count1 == 125_000_000 / RATE_HZ - 1);
    assign count2 = count1 + 1;
    
    assign counter_output = inter_count1;
endmodule
