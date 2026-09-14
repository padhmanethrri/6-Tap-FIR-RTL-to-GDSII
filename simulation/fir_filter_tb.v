`timescale 1ns/1ps

module fir_filter_tb;

reg clk;
reg rst;
reg [7:0] x;
wire [15:0] dataout;

// Instantiate FIR filter
firfilter uut (
    .clk(clk),
    .rst(rst),
    .x(x),
    .dataout(dataout)
);

// Observe internal delay registers
wire [7:0] d1 = uut.d1;
wire [7:0] d2 = uut.d2;
wire [7:0] d3 = uut.d3;
wire [7:0] d4 = uut.d4;
wire [7:0] d5 = uut.d5;

initial begin
    // Generate waveform
    $dumpfile("fir_filter.vcd");
    $dumpvars(0, fir_filter_tb);

    // Initial values
    clk = 0;
    rst = 1;
    x = 0;

    // Release reset
    #50 rst = 0;

    // Input samples
    #50 x = 10;
    #50 x = 10;
    #50 x = 20;
    #50 x = 20;
    #50 x = 30;
    #50 x = 30;
    #50 x = 40;
    #50 x = 40;
    #50 x = 50;
    #50 x = 50;
    #50 x = 60;
    #50 x = 60;
    #50 x = 70;
    #50 x = 70;
    #50 x = 80;
    #50 x = 80;
    #50 x = 90;
    #50 x = 90;
    #50 x = 100;
    #50 x = 100;

    #100 $finish;
end

// 20 MHz clock: 50 ns period
always #25 clk = ~clk;

// Display FIR values at every positive clock edge
always @(posedge clk) begin
    $display("Time=%0t ns | x=%3d | d1=%3d | d2=%3d | d3=%3d | d4=%3d | d5=%3d | dataout=%5d",
             $time, x, d1, d2, d3, d4, d5, dataout);
end

endmodule
