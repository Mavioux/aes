module keyExpansion (
    input wire [0:128] key,
    output wire [0:1407] keys
);

// set w0 - w3
assign keys[0:127] = key[0:127];
    
endmodule