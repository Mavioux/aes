module Decrypt (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire [0:127] ciphertext,
    input wire [0:127] key,
    output wire [0:127] plaintext
);

    reg [0:127] key_expansion_input;
    reg [0:127] previous_state;
    wire [0:127] next_state;
    wire [0:127] next_state_start;
    wire [0:1407] keys;
    reg [0:127] key_input;
    reg [0:127] key_input_final;
    reg [0:3] stage_num;
    reg [0:127] key1;
    reg [0:127] key2;
    reg [0:127] key_final;
    reg [0:127] previous_state_final;
    reg [0:127] previous_state_from_ciphertext;
    reg [0:127] previous_state_start;

    KeyExpansionDecrypt keyExpansionModule(clk, reset, key_expansion_input, keys);
    DecryptBlock decryptBlockModule(previous_state, key_input, next_state);
    DecryptBlockStart decryptBlockStartModule(previous_state_start, key1, key2, next_state_start);
    DecryptBlockFinal decryptBlockFinalModule(previous_state_final, key_input_final, plaintext);

    genvar i, j;
        
    for (i = 0; i < 4; i = i + 1) begin
        for (j = 0; j < 4; j = j + 1) begin
            always @(posedge clk) begin
                if(enable == 1'b1 ) begin
                    previous_state_start[32 * i + 8 * j: 32 * i + 8 * j + 7] = ciphertext[32 * j + 8 * i: 32 * j + 8 * i + 7];
                end
            end    
        end
    end
            

    always @(posedge clk) begin        
        if(enable == 1'b0) begin            
            case (stage_num[0:3])
                4'd0: begin
                        key1[0:127] <= keys[0 * 128 : 0 * 128 + 127];
                        key2[0:127] <= keys[1 * 128 : 1 * 128 + 127];
                        stage_num <= stage_num + 1; 
                    end
                4'd1: begin
                        previous_state <= next_state_start;
                        key_input[0:127] <= keys[2 * 128 : 2 * 128 + 127];
                        stage_num <= stage_num + 1; 
                    end
                4'd2: begin
                        previous_state <= next_state;
                        key_input[0:127] <= keys[3 * 128 : 3 * 128 + 127];
                        stage_num <= stage_num + 1; 
                    end
                4'd3: begin
                        previous_state <= next_state;
                        key_input[0:127] <= keys[4 * 128 : 4 * 128 + 127];
                        stage_num <= stage_num + 1; 
                    end
                4'd4: begin
                        previous_state <= next_state;
                        key_input[0:127] <= keys[5 * 128 : 5 * 128 + 127];
                        stage_num <= stage_num + 1; 
                    end
                4'd5: begin
                        previous_state <= next_state;
                        key_input[0:127] <= keys[6 * 128 : 6 * 128 + 127];
                        stage_num <= stage_num + 1; 
                    end
                4'd6: begin
                        previous_state <= next_state;
                        key_input[0:127] <= keys[7 * 128 : 7 * 128 + 127];
                        stage_num <= stage_num + 1; 
                    end
                4'd7: begin
                        previous_state <= next_state;
                        key_input[0:127] <= keys[8 * 128 : 8 * 128 + 127];
                        stage_num <= stage_num + 1; 
                    end
                4'd8: begin
                        previous_state <= next_state;
                        key_input[0:127] <= keys[9 * 128 : 9 * 128 + 127];
                        stage_num <= stage_num + 1; 
                    end
                4'd9: begin
                        previous_state_final <= next_state;
                        key_input_final[0:127] <= keys[10 * 128 : 10 * 128 + 127];
                        stage_num <= stage_num + 1; 
                    end
            endcase       
        end
        else begin
            key_expansion_input = key[0:127];
            stage_num <= 4'd0;
        end

        if (reset == 1'b1) begin
            stage_num <= 4'd11;
        end   
    end
    
endmodule