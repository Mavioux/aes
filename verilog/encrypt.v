module Encrypt (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire [0:127] plaintext,
    input wire [0:127] key,
    output reg [0:127] ciphertext
);

    // 128 * 11 length of all 128-bit keys to be used
    reg [0:127] key_input;
    reg [0:128] previous_state;
    reg [0:128] next_state;
    wire [0:1407] keys_wire;
    reg [0:1407] keys;
    reg [0:3] stage_num;

    KeyExpansion keyExpansionModule(clk, reset, key_input, keys_wire);
    EncryptBlock encryptBlockModule(previous_state, key_input, next_state);

    always @(posedge clk) begin
        if(enable == 1'b1 ) begin
            integer i, j;

            for (i = 0; i < 4; i = i + 1) begin
                for (j = 0; j < 4; j = j + 1) begin
                    next_state[32 * i + 8 * j: 32 * i + 8 * j + 7] <= plaintext[32 * j + 4 * i: 32 * j + 4 * i + 7];
                end
            end
            stage_num <= 4'd0;
        end
        else begin
            previous_state <= next_state;
            case (stage_num[0:3])
                4'd0: key_input[0:127] <= keys[0 * 128 : 0 * 128 + 127];
                4'd1: key_input[0:127] <= keys[1 * 128 : 1 * 128 + 127];
                4'd2: key_input[0:127] <= keys[2 * 128 : 2 * 128 + 127];
                4'd3: key_input[0:127] <= keys[3 * 128 : 3 * 128 + 127];
                4'd4: key_input[0:127] <= keys[4 * 128 : 4 * 128 + 127];
                4'd5: key_input[0:127] <= keys[5 * 128 : 5 * 128 + 127];
                4'd6: key_input[0:127] <= keys[6 * 128 : 6 * 128 + 127];
                4'd7: key_input[0:127] <= keys[7 * 128 : 7 * 128 + 127];
                4'd8: key_input[0:127] <= keys[8 * 128 : 8 * 128 + 127];
                4'd9: key_input[0:127] <= keys[9 * 128 : 9 * 128 + 127];
                4'd10: key_input[0:127] <= keys[10 * 128 : 10 * 128 + 127];
            endcase
            stage_num <= stage_num + 1;            
        end
    end

    always @(keys_wire[0:1407]) begin
        for (k = 0; k < 11; k = k + 1) begin
            for (i = 0; i < 4; i = i + 1) begin
                for (j = 0; j < 4; j = j + 1) begin
                    keys[128 * k + (32 * i + 8 * j) : 128 * k + (32 * i + 8 * j + 7)] <= keys_wire[128 * k + (32 * j + 4 * i) : 128 * k + (32 * j + 4 * i + 7)];
                end
            end
        end
    end
    
endmodule