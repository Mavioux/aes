module RotWord (
    input wire [0:31] w_in,
    output reg [0:31] w_out
);
    always  @ (w_in[0:31]) begin
        w_out[0:7] <= w_in[8:15];
        w_out[8:15] <= w_in[16:23];
        w_out[16:23] <= w_in[24:31];
        w_out[24:31] <= w_in[0:7];
    end

    
    
    
endmodule