//`timescale 1ns / 1ps
//module fifo_mem #(parameter depth=8,width=8,ptr_width=3)
//                (input w_clk, r_clk,        //Read and Write Clock
//                input w_en, r_en,           //Read and Write Enable
//                input [ptr_width-1:0]b_wptr,[ptr_width-1:0]b_rptr,       //Read and Write Pointer
//                input full, empty,           //Full and Empty Signals 
//                input [width-1:0]data_in,   //Input Data to FIFO
//                output reg [width-1:0]data_out  //Output Data from FIFO    
//);    

//    reg [width-1:0]FIFO_MEM[0:depth-1];         //Declaring the FIFO
    
//    always@(posedge w_clk) begin            //Block to write data to FIFO
//        if(w_en && !full) begin
//            FIFO_MEM[b_wptr[ptr_width-1:0]]<=data_in;
//        end
//    end
    
//   always@(posedge r_clk) begin            //Block to read data from FIFO
//        if(r_en && !empty) begin
//            data_out<=FIFO_MEM[b_rptr[ptr_width-1:0]];
//        end
//    end 

////    assign data_out = FIFO_MEM[];       //Data will be read from FIFO whenever rb_ptr changes   
//endmodule


module fifo_mem #(parameter DEPTH=8, DATA_WIDTH=8, PTR_WIDTH=3) (
  input wclk, w_en, rclk, r_en,
  input [PTR_WIDTH:0] b_wptr, b_rptr,
  input [DATA_WIDTH-1:0] data_in,
  input full, empty,
  output reg [DATA_WIDTH-1:0] data_out
);
  reg [DATA_WIDTH-1:0] fifo[0:DEPTH-1];
  
  always@(posedge wclk) begin
    if(w_en & !full) begin
      fifo[b_wptr[PTR_WIDTH-1:0]] <= data_in;
    end
  end
//  always@(posedge rclk) begin
//    if(r_en & !empty) begin
//      data_out <= fifo[b_rptr[PTR_WIDTH-1:0]];
//    end
//  end
  assign data_out = fifo[b_rptr[PTR_WIDTH-1:0]];
endmodule