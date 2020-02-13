`timescale 1ns/1ns
`include "../../lib/EECS151.v"
`define CLOCK_FREQ 125_000_000

module z1top_rate_counter (
    input CLK_125MHZ_FPGA,
    input [3:0] BUTTONS,
    input [1:0] SWITCHES,
    output [5:0] LEDS
);
    assign LEDS[5:4] = 2'b11;
    localparam integer B_SAMPLE_CNT_MAX = 0.0005 * `CLOCK_FREQ;
    // The button is considered 'pressed' after 100ms of continuous pressing
    localparam integer B_PULSE_CNT_MAX = 0.100 / 0.0005;

    // TODO: Your code to implement a 4-bit counter of rate 1 Hz (counting up)
    // or a parameterized rate counter. You can reuse the code in previous exercises
    // Use the buttons to provide control signals to your counter (refer to the spec)
    // You might want to use additional registers to keep track of the current state
    // of your counter
    wire [3:0] buttons;
    
    button_parser #(
        .WIDTH(4),
        .SAMPLE_CNT_MAX(B_SAMPLE_CNT_MAX),
        .PULSE_CNT_MAX(B_PULSE_CNT_MAX)
    ) bp (
        .clk(CLK_125MHZ_FPGA),
        .in(BUTTONS),
        .out(buttons)
    );
    reg [5:0] led_ori = 5'b00000;

    // Some initial code has been provided for you
    wire [3:0] led_counter_val;
    wire [3:0] led_counter_update;
    wire is_one_sec;
     /*
    reg [31:0] freq1 = 32'd125000000;
    reg [31:0] freq2 = 32'd60000000;
    reg [31:0] freq3 = 32'd30;
    */
    
    wire [31:0] freq;
    wire [31:0] count1;
    wire [31:0] count2;
    wire [31:0] freq1;
    
    assign freq1 = (buttons[0] == 1) ? freq + 32'd30000000 :
                          (buttons[1] == 1) ? freq - 32'd30000000 :
                          (buttons[3] == 1) ? 32'd125000000 :
                          freq;
    REGISTER #(32) regfreq(.clk(CLK_125MHZ_FPGA), .q(freq), .d(freq1));
    
    wire is;
    wire [0:0] is_one_begin;
    assign is = (buttons[3] == 1);
    assign is_one_sec = (count1 == freq) && (is_one_begin);
    
    wire [0:0] is_one_stop;
    assign is_one_begin = is_one_stop + 1;
    REGISTER_CE reg_stop (.clk(CLK_125MHZ_FPGA), .q(is_one_stop), .d(is_one_begin), .ce(buttons[2]));
    
    // This register will be updated when is_one_sec is True
    REGISTER_R_CE #(4) led_counter_reg (
    .clk(CLK_125MHZ_FPGA), .ce(is_one_sec), .rst(is),
    .d(led_counter_update), .q(led_counter_val));

    assign LEDS[3:0] = led_counter_val;
    assign led_counter_update = led_counter_val + 1;

    // is_one_sec is True every second (= how many cycles?)
    // You may use another register of keep track of the time
    // TODO: Correct the following assignment when you write your cod
     
    assign count2 = count1 + 1;
    
    wire is_one_reset;
    assign is_one_reset = is_one_sec || (BUTTONS && 4'b1111);
    REGISTER_R_CE #(32) count_add (.clk(CLK_125MHZ_FPGA), 
    .rst(is_one_reset), .d(count2), .q(count1), .ce(is_one_begin));
    
    
    // TODO: Instantiate a REIGISTER module for your second register/counter
    // You also need to think of how many bits are required for your register
    
endmodule
