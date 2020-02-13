`timescale 1ns/1ns
module full_adder (
    input a,
    input b,
    input carry_in,
    output sum,
    output carry_out
);
    // TODO: Your code (from lab 2)
        wire abar, bbar, t1, t2;
    wire out;
    wire cbar, dbar, t3, t4;
    
    not invA (abar, a);
    not invB (bbar, b);
    and and1 (t1, a, bbar);
    and and2 (t2, b, abar);
    or or1 (out, t1, t2);
    
    not invC (cbar, out);
    not invD (dbar, carry_in);
    and and3 (t3, out, dbar);
    and and4 (t4, carry_in, cbar);
    or or2 (sum, t3, t4);
    
    wire out1, out2, out3, out4;
    and a1 (out1, a, b);
    and a2 (out2, a, carry_in);
    and a3 (out3, b, carry_in);
    or o1 (out4, out1, out2);
    or o2 (carry_out, out3, out4);

endmodule
