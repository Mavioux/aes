`timescale 1ns/1ns

module Decrypt_TB ();

    reg [0:127] ciphertext;
    reg [0:127] key;
    wire [0:127] plaintext;
    reg [0:127] plaintext_expected;
    reg clk, reset, enable;
    reg [31:0] vectornum, errors; // bookkeeping variables

    reg [0:383] testVectors[6:0];

    Decrypt decryptModule(clk, reset, enable, ciphertext, key, plaintext);

    initial begin
        $readmemh("./verilog/testbench/testVectors/encryptVectors.tv",testVectors);
        clk <= 0;
        reset <= 0;
        enable <= 1;
        vectornum <= 0; errors <= 0;

        forever #5 clk = ~clk;        
    end

    always begin
        #15 enable <= 0;
        #120 enable <= 1;
    end

    always @(enable) begin
        if(enable == 1'b1) begin
            if (plaintext[0:127] != plaintext_expected[0:127]) begin
                $display("Error: ciphertext = %H\key = %H", ciphertext[0:127], key[0:127]);
                $display(" outputs = %H (%H expected)", plaintext[0:127], plaintext_expected[0:127]);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testVectors[vectornum] === 64'bx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
            end

            #1; {plaintext_expected[0:127], key[0:127], ciphertext[0:127]} = testVectors[vectornum];
        end
    end

    

    // always @(posedge clk) begin
        
    // end
    
endmodule