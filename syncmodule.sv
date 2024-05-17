//module syncmodule #(parameter ptr_width=6)
//                   (input clk, rst_n,
//                    input [ptr_width:0]d_in,
//                    output reg [ptr_width:0]d_out);
    
//    reg [ptr_width:0]q1;        //Connection between the First and Second Stage
//    always@(posedge clk)begin
//        if(!rst_n)begin
//           q1<=0;
//           d_out<=0; 
//        end
//        else begin
//            q1<=d_in;           //First Stage Sync
//            d_out<=q1;          //Second Stage Sync
//        end
//    end        
//endmodule

module syncmodule #(parameter WIDTH=3) (input clk, rst_n, [WIDTH:0] d_in, output reg [WIDTH:0] d_out);
  reg [WIDTH:0] q1;
  always@(posedge clk) begin
    if(!rst_n) begin
      q1 <= 0;
      d_out <= 0;
    end
    else begin
      q1 <= d_in;
      d_out <= q1;
    end
  end
endmodule