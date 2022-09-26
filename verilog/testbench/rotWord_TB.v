`timescale 1ns/1ns

module rotWord_TB ();

    reg [0:31] w1_in;
    wire [0:31] w1_out;
    reg [0:31] w1_out_expected;
    reg clk, reset;
    reg [31:0] vectornum, errors; // bookkeeping variables

    reg [0:63] testVectors[3:0];

    rotWord rotWordModule(clk, reset, w1_in, w1_out);

    initial begin
        $readmemb("../rotWordVectors.tv",testVectors);
        clk = 0;
        reset = 0;
        vectornum = 0; errors = 0;

        w1_in = 31'b1010;

        forever #5 clk = ~clk;
    end

    always@(posedge clk)
    begin
        #1; {w1_in[0:31], w1_out_expected[0:31]} = testVectors[vectornum];
    end

    always@(posedge clk)
    begin
        if (w1_out != w1_out_expected) begin
            $display("Error: inputs = %b", w1_in[0:31]);
            $display(" outputs = %b (%b expected)", w1_out, w1_out_expected);
            errors = errors + 1;
        end
        vectornum = vectornum + 1;
        if (testVectors[vectornum] === 64'bx) begin
            $display("%d tests completed with %d errors", vectornum, errors);
            $finish;
        end
    end

    

    // always @(posedge clk) begin
        
    // end
    
endmodule