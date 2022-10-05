///////////////////////////////////////////////////////////////////
//                                                               //
//                                                               //
//                            ,--.                               //
//   ,--,--,--. ,--,--.,--.  ,--.`--' ,---. ,--.,--.,--.  ,--.   //
//   |        |' ,-.  | \  `'  / ,--.| .-. ||  ||  | \  `'  /    //
//   |  |  |  |\ '-'  |  \    /  |  |' '-' ''  ''  ' /  /.  \    //
//   `--`--`--' `--`--'   `--'   `--' `---'  `----' '--'  '--'   //
//                                                               //
//                                                               //
//                                                               //
///////////////////////////////////////////////////////////////////

module AES (
    input wire clk,
    input wire reset, // reset high
    input wire encrypt, // set 1 for at least on clock cycle to begin encryption or reset encryption process 
    input wire decrypt, // set 1 for at least on clock cycle to begin decryption or reset decryption process  
    input wire [0:127] plaintext_in,
    inout wire [0:127] ciphertext_out,
    input wire [0:127] key,
    output wire [0:127] ciphertext_in,
    output wire [0:127] plaintext_out   
);

    reg fault_reset;
    wire encrypt_reset, decrypt_reset;
    // wire [0:127] ciphertext_out, plaintext_out;
    // reg ciphertext_enable, plaintext_enable;

    Encrypt encryptModule(clk, encrypt_reset, encrypt, plaintext_in, key, ciphertext_out);
    Decrypt decryptModule(clk, decrypt_reset, decrypt, ciphertext_in, key, plaintext_out);

    always @(encrypt or decrypt) begin
        if(encrypt == 1'b1 && decrypt == 1'b1) begin
            fault_reset = 1'b1;
        end
        else begin
            fault_reset = 1'b0;
        end
    end

    assign encrypt_reset = fault_reset || reset || decrypt;
    assign decrypt_reset = fault_reset || reset || encrypt;

    // always @(posedge clk) begin
    //     if(encrypt != decrypt) begin
    //         if(encrypt == 1'b0) begin
    //             ciphertext_enable = 1'b0;
    //             plaintext_enable = 1'b1;
    //         end
    //         else if(decrypt == 1'b0) begin
    //             ciphertext_enable = 1'b1;
    //             plaintext_enable = 1'b0;
    //         end
    //     end
    // end

    // assign plaintext = plaintext_enable ? 128'bz : plaintext_out;
    // assign ciphertext = ciphertext_enable ? 128'bz : ciphertext_out;



    
endmodule