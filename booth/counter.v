module contador(input wire clk, reset, output wire q0, q1, q2);
// clk , reset , enable , d , q 

wire q0_neg, q1_neg, q2_neg;
assign q0_neg = -q0;
assign q1_neg = -q1;
assign q2_neg = -q2;

ffdc ff0 (clk, reset, ,q0_neg ,q0);
ffdc ff1 (q0_neg, reset, ,q1_neg,q1);
ffdc ff2 (q1_neg, reset, ,q2_neg, q2);
endmodule
