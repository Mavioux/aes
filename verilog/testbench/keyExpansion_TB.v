`timescale 1ns/1ns

module keyExpansion_TB ();
    reg [0:127] key;
    wire [0:1407] keys;
    reg [0:1407] keys_expected;
    reg clk, reset;
    reg [31:0] vectornum, errors; // bookkeeping variables

    reg [0:63] testVectors[1:0];

    KeyExpansion keyExpansionModule(clk, reset, key, keys);

    initial begin
        // $readmemh("../verilog/testbench/testvectors/keyExpansionVectors.tv",testVectors);
        clk = 0;
        reset = 0;
        vectornum = 0; errors = 0;

        forever #5 clk = ~clk;
    end

    always@(posedge clk)
    begin
        // #1; {key[0:127], keys_expected[0:1407]} = testVectors[vectornum];
        key[0:127] = 128'h0;
    end

    // always@(posedge clk)
    // begin
        // if (keys != keys_expected) begin
        //     $display("Error: inputs = %b", key[0:127]);
        //     $display(" outputs = %b (%b expected)", keys, keys_expected);
        //     errors = errors + 1;
        // end
        // vectornum = vectornum + 1;
        // if (testVectors[vectornum] === 1536'bx) begin
        //     $display("%d tests completed with %d errors", vectornum, errors);
        //     $finish;
        // end
    // end
    
endmodule