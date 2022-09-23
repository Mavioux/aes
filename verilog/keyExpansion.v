module KeyExpansion (
    input wire clk,
    input wire reset,
    input wire [0:128] key,
    output reg [0:1407] keys
);
    parameter N = 4;

    // set w0 - w3
    assign keys[0:127] = key[0:127];


    integer i;

    for (i = 4; i < 44; i = i + 1) begin
        if(i % 4) begin
            wire [0:31] w1;
            w1[0:31] = w[(i - N) * 32 : (i - N) * 32 + 31];
            wire [0:31] w2;
            w2[0:31] = w[(i - 1) * 32 : (i - 1) * 32 + 31];
            
            RotWord rotWordModule(clk, reset, w2[0:31], w2[0:31]);
            SubWord subWordModule(clk, reset, w2[0:31], w2[0:31]);
        end
        else begin
            
        end
    end
    
endmodule