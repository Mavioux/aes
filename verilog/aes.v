module aes (
    input wire clk,
    input wire reset, // reset high
    input wire sel; // select 0 for encryption, 1 for decryption    
    inout wire [0:127] plaintext,
    input wire [0:127] key,
    inout wire [0:127] ciphertext
);

encrypt encryptModule(clk, reset, plaintext, key, ciphertext)



    
endmodule