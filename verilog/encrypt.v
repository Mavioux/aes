module Encrypt (
    input wire clk,
    input wire reset, 
    input wire [0:127] plaintext,
    input wire [0:127] key,
    output reg [0:127] ciphertext
);

// 128 * 11 length of all 128-bit keys to be used
wire [0:1407] keys;

KeyExpansion keyExpansionModule(clk, reset, key, keys);
    
endmodule