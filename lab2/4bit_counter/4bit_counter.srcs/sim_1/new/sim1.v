`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/29 14:38:51
// Design Name: 
// Module Name: sim1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sim1(
    );
    reg clk;
    reg [3:0] buttons;
    wire [5:0] leds;
    
    initial begin
        clk = 1'b1;
        buttons = 4'b0001;
        #3 buttons = 4'b0000;
    end
    
    always begin
        #4 clk = ~clk;
    end
    
    z1top_counter z1top(clk, buttons, leds);
    
endmodule
