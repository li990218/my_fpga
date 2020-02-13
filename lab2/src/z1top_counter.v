`timescale 1ns / 1ns
`include "../../lib/EECS151.v"

module z1top_counter (
    input clk,
    input [3:0] BUTTONS,
    input [1:0] SWITCHES,
    output [3:0] LEDS
);
    reg [5:0] led_ori = 5'b00000;

    // Some initial code has been provided for you
    wire [3:0] led_counter_val;
    wire [3:0] led_counter_update;
    wire is_one_sec;
     
    reg [31:0] freq1 = 32'd12;
    reg [31:0] freq2 = 32'd6;
    reg [31:0] freq3 = 32'd30;
    
    wire [31:0] freq;
    wire [31:0] count1;
    wire [31:0] count2;
    
    assign freq = (BUTTONS[0] == 1) ? freq2 :
                          (BUTTONS[1] == 1) ? freq3 :
                          (BUTTONS[3] == 1) ? freq1 :
                          freq;
    
    wire is;
    assign is = (BUTTONS[3] == 1);
    assign is_one_sec = (count1 == freq) && (is_one_begin);
    
    wire [0:0] is_one_stop;
    wire [0:0] is_one_begin;
    assign is_one_begin = is_one_stop + 1;
    REGISTER_CE reg_stop (.clk(clk), .q(is_one_stop), .d(is_one_begin), .ce(BUTTONS[2]));
    
    // This register will be updated when is_one_sec is True
    REGISTER_R_CE #(4) led_counter_reg (
    .clk(clk), .ce(is_one_sec), .rst(is),
    .d(led_counter_update), .q(led_counter_val));

    assign LEDS[3:0] = led_counter_val;
    assign led_counter_update = led_counter_val + 1;

    // is_one_sec is True every second (= how many cycles?)
    // You may use another register of keep track of the time
    // TODO: Correct the following assignment when you write your cod
     
    assign count2 = count1 + 1;
    
    wire is_one_reset;
    assign is_one_reset = is_one_sec || (BUTTONS && 4'b1111);
    REGISTER_R_CE #(32) count_add (.clk(clk), 
    .rst(is_one_reset), .d(count2), .q(count1), .ce(is_one_begin));
    
    assign is = BUTTONS[3];
    
    // TODO: Instantiate a REIGISTER module for your second register/counter
    // You also need to think of how many bits are required for your register

endmodule
