module readcontrol#(parameter ptr_width=3)
                   (input r_clk, rrst_n, r_en,
                    input [ptr_width-1:0]g_wptr_sync,
                    output reg [ptr_width-1:0]b_rptr,g_rptr,
                    output reg empty
);
    reg [ptr_width-1:0]b_rptr_next;
    reg [ptr_width-1:0]g_rptr_next;
    
    assign b_rptr_next = b_rptr + (r_en & !empty);  //incrementing the Binary Ptr
    assign g_rptr_next = (b_rptr >> 1)^b_rptr_next; //incrementing the Gray Ptr
    assign rempty = (g_wptr_sync[ptr_width-1:0] == g_rptr_next[ptr_width-1:0])?1'b1:1'b0;

    always@(posedge r_clk or negedge rrst_n) begin
        if(!rrst_n)begin        //Reset all ptrs if reset flag is low
            b_rptr <= 0;
            g_rptr <= 0;    
         
        end
        else begin
            b_rptr <= b_rptr_next;
            g_rptr <= g_rptr_next;
        end
    end
    
    always@(posedge r_clk or negedge rrst_n)begin
        if(!rrst_n) empty <= 1;
        else empty <= rempty;    //Updating the empty flag
    end
endmodule
