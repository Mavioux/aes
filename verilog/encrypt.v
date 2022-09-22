module encrypt (
    input wire [0:127] plaintext,
    input wire [0:127] key,
    output wire [0:127] ciphertext
);

// 128 * 11 length of all 128-bit keys to be used
wire [0:1407] keys;

keyExpansion keyExpansionModule(key, keys);
    
endmodule