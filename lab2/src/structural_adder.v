module structural_adder (
    input [2:0] a,
    input [2:0] b,
    output [3:0] sum
);
    // TODO: Insert your RTL here
    // Remove the assign statement once you write your own RTL
    wire carry1;
    assign carry1 = 1'b0;
    wire carry2, carry3;
    full_adder full1(a[0], b[0], carry1, sum[0], carry2);
    full_adder full2(a[1], b[1], carry2, sum[1], carry3);
    full_adder full3(a[2], b[2], carry3, sum[2], sum[3]);

endmodule
