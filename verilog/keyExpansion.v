module KeyExpansion (
    input wire clk,
    input wire reset,
    input wire [0:127] key,
    output reg [0:1407] keys
);
    parameter N = 4;

    // set w0 - w3
    always @(key[0:127]) begin
        keys[0:127] = key[0:127];
    end


    genvar i;

    for (i = 4; i < 44; i = i + 1) begin
        if(i % N) begin
            wire [0:31] w1;
            assign w1[0:31] = keys[(i - N) * 32 : (i - N) * 32 + 31];
            wire [0:31] w2, w2_rot, w2_sub;
            assign w2[0:31] = keys[(i - 1) * 32 : (i - 1) * 32 + 31];
            
            rotWord rotWordModule(w2[0:31], w2_rot[0:31]);
            subWord subWordModule(w2_rot[0:31], w2_sub[0:31]);

            reg [0:31] rcon;
            // rcon lookup table
            always @(i) begin
                case (i/N)
                    0: rcon[0:31] = 32'b00000001000000000000000000000000;
                    1: rcon[0:31] = 32'b00000010000000000000000000000000;
                    2: rcon[0:31] = 32'b00000100000000000000000000000000;
                    3: rcon[0:31] = 32'b00001000000000000000000000000000;
                    4: rcon[0:31] = 32'b00010000000000000000000000000000;
                    5: rcon[0:31] = 32'b00100000000000000000000000000000;
                    6: rcon[0:31] = 32'b01000000000000000000000000000000;
                    7: rcon[0:31] = 32'b10000000000000000000000000000000;
                    8: rcon[0:31] = 32'b00011011000000000000000000000000;
                    9: rcon[0:31] = 32'b00110110000000000000000000000000;
                endcase
            end
                
            wire [0:31] temp = w1[0:31] ^ w2_sub[0:31] ^ rcon[0:31];

            always @(temp[0:31]) begin
                keys[i * 32 : i * 32 + 31] = temp[0:31];
            end
        end
        else begin
            wire [0:31] w1;
            assign w1[0:31] = keys[(i - N) * 32 : (i - N) * 32 + 31];
            wire [0:31] w2, w2_rot, w2_sub;
            assign w2[0:31] = keys[(i - 1) * 32 : (i - 1) * 32 + 31];

            reg [0:31] rcon;
            // rcon lookup table
            always @(i) begin
                case (i/N)
                    0: rcon[0:31] = 32'b00000001000000000000000000000000;
                    1: rcon[0:31] = 32'b00000010000000000000000000000000;
                    2: rcon[0:31] = 32'b00000100000000000000000000000000;
                    3: rcon[0:31] = 32'b00001000000000000000000000000000;
                    4: rcon[0:31] = 32'b00010000000000000000000000000000;
                    5: rcon[0:31] = 32'b00100000000000000000000000000000;
                    6: rcon[0:31] = 32'b01000000000000000000000000000000;
                    7: rcon[0:31] = 32'b10000000000000000000000000000000;
                    8: rcon[0:31] = 32'b00011011000000000000000000000000;
                    9: rcon[0:31] = 32'b00110110000000000000000000000000;
                endcase
            end
            wire [0:31] temp = w1[0:31] ^ w2[0:31] ^ rcon[0:31];

            always @(temp[0:31]) begin
                keys[i * 32 : i * 32 + 31] = temp[0:31];
            end
        end
    end
    
endmodule