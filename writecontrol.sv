module writecontrol #(parameter ptr_width=3)
                     (  input w_clk,wrst_n,w_en,
                        input [ptr_width-1:0] g_rptr_sync,
                        output reg [ptr_width-1:0] b_wptr,g_wptr,
                        output reg full
    );
    
    reg [ptr_width:0] b_wptr_next;
    reg [ptr_width:0] g_wptr_next;
    
    wire wfull;
    
    assign b_wptr_next = b_wptr + (w_en & !full);
    assign g_wptr_next = (b_wptr>>1)^b_wptr_next;
    
    always@(posedge w_clk or negedge !wrst_n) begin
        if(!wrst_n)begin
            b_wptr<=0;
            g_wptr<=0;
        end
        else begin
            b_wptr<=b_wptr_next;
            g_wptr<=g_wptr_next;
        end
    end
    
    always@(posedge w_clk or negedge wrst_n) begin
        if(!wrst_n) full<=0;
        else full<=wfull;
    end    
    
    assign wfull=(g_wptr_next=={~g_rptr_sync[ptr_width:ptr_width-1],g_rptr_sync[ptr_width-2:0]})?1'b1:1'b0;
endmodule
