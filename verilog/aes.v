module aes (
    inout wire [0:127] plaintext,
    input wire [0:127] key,
    inout wire [0:127] ciphertext
    input wire sel; // select 0 for encryption, 1 for decryption
);

encrypt encryptModule(plaintext, key, ciphertext)



    
endmodule