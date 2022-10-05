`timescale 1ns/1ns

module AES_TB ();

    wire [0:127] plaintext_in;
    wire [0:127] ciphertext_out;
    wire [0:127] key;
    wire [0:127] plaintext_out;
    wire [0:127] ciphertext_in;    
    wire [0:127] ciphertext_expected;
    wire [0:127] plaintext_expected;

    reg [0:127] plaintext_in_reg;
    reg [0:127] ciphertext_out_reg;
    reg [0:127] key_reg;
    reg [0:127] plaintext_out_reg;
    reg [0:127] ciphertext_in_reg; 
    reg [0:127] ciphertext_expected_reg;
    reg [0:127] plaintext_expected_reg;
    reg clk, reset, encrypt, decrypt;
    reg [31:0] vectornum, errors; // bookkeeping variables

    reg [0:639] testVectors[4:0];

    AES AES_Module(clk, reset, encrypt, decrypt, plaintext_in, ciphertext_out, key, ciphertext_in, plaintext_out);

    initial begin
        $readmemh("./verilog/testbench/testVectors/aesVectors.tv",testVectors);
        clk <= 0;
        reset <= 0;
        encrypt <= 1;
        decrypt <= 1;
        vectornum <= 0; errors <= 0;

        forever #5 clk = ~clk;        
    end

    always begin
        // start encryption at 20 ns
        #20 decrypt <= 0;
        #10 encrypt <= 0;

        // start next encryption after 120 ns
        #120 encrypt <= 1;
        #10 encrypt <= 0;

        // stop encryption after 30 ns
        #30 decrypt <= 1;
        encrypt <= 1;

        // give 12 clocks to check that no output is changed from encryption
        #120 decrypt <= 1;
        encrypt <= 0;
        #10 decrypt <= 0;

        // next encryption after 120 ns
        #120 decrypt <= 1;
        #10 decrypt <= 0;

        // stop encryption after 30 ns
        #30 decrypt <= 1;
        encrypt <= 1;

        // give 12 clocks to check that no output is changed from encryption
        // reach 630 ns

        // New encryption
        #120 decrypt <= 0;
        encrypt <= 1;
        #10 encrypt <= 0;

        // Kill it with reset
        #50 reset <= 1;
        #10 reset <= 0;

        // New decryption
        #120 encrypt <= 0;
        decrypt <= 1;
        #10 decrypt <= 0;

        // Kill it with reset
        #50 reset <= 1;
    end

    always @(encrypt or decrypt) begin
        if(encrypt == 1'b1 && decrypt == 1'b0) begin
            if (ciphertext_out[0:127] != ciphertext_expected[0:127]) begin
                $display("Error: plaintext = %H\key = %H", plaintext_in[0:127], key[0:127]);
                $display(" outputs = %H (%H expected)", ciphertext_out[0:127], ciphertext_expected[0:127]);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testVectors[vectornum] === 64'bx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
            end

            #1; {plaintext_in_reg[0:127], key_reg[0:127], ciphertext_expected_reg[0:127], ciphertext_in_reg[0:127], plaintext_expected_reg[0:127]} = testVectors[vectornum];
        end

        if(encrypt == 1'b0 && decrypt == 1'b1) begin
            if (plaintext_out[0:127] != plaintext_expected[0:127]) begin
                $display("Error: ciphertext = %H\key = %H", ciphertext_in[0:127], key[0:127]);
                $display(" outputs = %H (%H expected)", plaintext_out[0:127], plaintext_expected[0:127]);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testVectors[vectornum] === 64'bx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
            end

            #1; {plaintext_in_reg[0:127], key_reg[0:127], ciphertext_expected_reg[0:127], ciphertext_in_reg[0:127], plaintext_expected_reg[0:127]} = testVectors[vectornum];
        end
    end

    assign plaintext_in = plaintext_in_reg;
    assign key = key_reg;
    assign ciphertext_expected = ciphertext_expected_reg;
    assign ciphertext_in = ciphertext_in_reg;
    assign plaintext_expected = plaintext_expected_reg;
    
endmodule