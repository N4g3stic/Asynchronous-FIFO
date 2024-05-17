`timescale 1ns / 1ps
module AsyncFIFO();
    parameter WIDTH = 8;
    parameter FIFO_DEPTH = 32;
    bit [WIDTH-1:0]FIFO_MEM[FIFO_DEPTH-1:0];
endmodule
