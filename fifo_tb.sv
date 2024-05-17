module fifo_tb;

  parameter DATA_WIDTH = 8;

  wire [DATA_WIDTH-1:0] data_out;
  wire full;
  wire empty;
  reg [DATA_WIDTH-1:0] data_in;
  reg w_en, wclk, wrst_n;
  reg r_en, rclk, rrst_n;

  // Queue to push data_in
  reg [DATA_WIDTH-1:0] wdata_q[$], wdata;

  topmodule as_fifo (wclk, wrst_n,rclk, rrst_n,w_en,r_en,data_in,data_out,full,empty);

  always #15ns wclk = ~wclk;
  always #35ns rclk = ~rclk;
  
  initial begin
    wclk = 1'b0; wrst_n = 1'b0;
    w_en = 1'b0;
    data_in = 0;
    
    @(posedge wclk);
    wrst_n = 1'b1;
    @(posedge wclk);
    wrst_n = 1'b0;
    

    repeat(2) begin
      for (int i=0; i<30; i++) begin
        @(posedge wclk iff !full);
        w_en = (i%2 == 0)? 1'b1 : 1'b0;
        if (w_en) begin
          data_in = $urandom;
          wdata_q.push_back(data_in);
          $display("Data in = %0h,%0t",wdata_q[$],$time);
        end
      end
      #50;
    end
  end

  initial begin
    rclk = 1'b0; rrst_n = 1'b0;
    r_en = 1'b0;

    repeat(2)@(posedge rclk);
    rrst_n = 1'b1;    
    @(posedge rclk);
    rrst_n = 1'b0;
    
    repeat(2) begin    
    $display("Reached here at %0t",$time);
      for (int i=0; i<30; i++) begin
        @(posedge rclk iff !empty);
        r_en = (i%2 == 0)? 1'b1 : 1'b0;
        $display("Read Enable : %0b",r_en);
        if (r_en) begin
          wdata = wdata_q.pop_front();
          $display("Data Out : %0h",data_out);
          if(data_out !== wdata) $error("Time = %0t: Comparison Failed: expected wr_data = %h, rd_data = %h", $time, wdata, data_out);
          else $display("Time = %0t: Comparison Passed: wr_data = %h and rd_data = %h",$time, wdata, data_out);
        end
      end
      #50;
    end

    $finish;
  end
  
  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule

