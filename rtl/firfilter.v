
`timescale 1ns/1ps

module firfilter (
    input clk,
    input rst,
    input [7:0] x,
    output [15:0] dataout
);

wire [7:0] d1, d2, d3, d4, d5;
wire [15:0] m1, m2, m3, m4, m5, m6;

// FIR coefficients
parameter h0 = 3;
parameter h1 = 4;
parameter h2 = 5;
parameter h3 = 4;
parameter h4 = 3;
parameter h5 = 3;

// Delay registers
dff dff1(clk, rst, x,  d1);
dff dff2(clk, rst, d1, d2);
dff dff3(clk, rst, d2, d3);
dff dff4(clk, rst, d3, d4);
dff dff5(clk, rst, d4, d5);

// Constant multiplications
assign m1 = h0 * x;
assign m2 = h1 * d1;
assign m3 = h2 * d2;
assign m4 = h3 * d3;
assign m5 = h4 * d4;
assign m6 = h5 * d5;

// FIR output
assign dataout = m1 + m2 + m3 + m4 + m5 + m6;

endmodule
