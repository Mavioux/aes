`timescale 1ns/1ns

module mixColumns_TB ();

    reg [0:127] state;
    wire [0:127] new_state;
    reg [0:127] new_state_expected;
    reg clk, reset;
    reg [31:0] vectornum, errors; // bookkeeping variables

    reg [0:63] testVectors[3:0];

    MixColumns mixColumnsModule(state, new_state);

    initial begin
        // $readmemb("../rotWordVectors.tv",testVectors);
        clk = 0;
        reset = 0;
        vectornum = 0; errors = 0;

        state = 31'b1010;

        forever #5 clk = ~clk;
    end

    always@(posedge clk)
    begin
        // #1; {w1_in[0:31], w1_out_expected[0:31]} = testVectors[vectornum];
        state[0:7] = 8'hdb;
        state[8:15] = 8'hf2;
        state[16:23] = 8'h01;
        state[24:31] = 8'hc6;
        state[32:39] = 8'h13;
        state[40:47] = 8'h0a;
        state[48:55] = 8'h01;
        state[56:63] = 8'hc6;
        state[64:71] = 8'h53;
        state[72:79] = 8'h22;
        state[80:87] = 8'h01;
        state[88:95] = 8'hc6;
        state[96:103] = 8'h45;
        state[104:111] = 8'h5c;
        state[112:119] = 8'h01;
        state[120:127] = 8'hc6;
        
    end

    // always@(posedge clk)
    // begin
    //     if (w1_out != w1_out_expected) begin
    //         $display("Error: inputs = %b", w1_in[0:31]);
    //         $display(" outputs = %b (%b expected)", w1_out, w1_out_expected);
    //         errors = errors + 1;
    //     end
    //     vectornum = vectornum + 1;
    //     if (testVectors[vectornum] === 64'bx) begin
    //         $display("%d tests completed with %d errors", vectornum, errors);
    //         $finish;
    //     end
    // end

    

    // always @(posedge clk) begin
        
    // end
    
endmodule