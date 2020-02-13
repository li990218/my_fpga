`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/29 12:20:03
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
    reg [3:0] bottoms;
    reg [1:0] switches;
    wire [5:0] result;
    
    initial begin
        bottoms = 4'b0000;
        switches = 2'b01;
        #50 bottoms = 4'b0011;
        #50 switches = 2'b00;
        #50 switches = 2'b10;
        #50 switches = 2'b11;
        #50 bottoms = 4'b1111;
    end
    
    z1top_adder z1top(.BUTTONS(bottoms), .SWITCHES(switches), .LEDS(result));
       
       
endmodule
