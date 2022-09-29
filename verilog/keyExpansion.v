module KeyExpansion (
    input wire clk,
    input wire reset,
    input wire [0:127] key,
    output reg [0:1407] keys,
);
    parameter N = 4;

    // set w0 - w3
    always @(key[0:127]) begin
        keys[0:127] = key[0:127];
    end

    genvar i;

    for (i = 4; i < 44; i = i + 1) begin
        if(i % N == 0) begin
            reg [0:31] w1, w2;
            wire [0:31] w2_rot, w2_sub;

            RotWord rotWordModule(w2[0:31], w2_rot[0:31]);
            SubWord subWordModule1(w2_rot[0:7], w2_sub[0:7]);
            SubWord subWordModule2(w2_rot[8:15], w2_sub[8:15]);
            SubWord subWordModule3(w2_rot[16:23], w2_sub[16:23]);
            SubWord subWordModule4(w2_rot[24:31], w2_sub[24:31]);

            always @(keys[(i - N) * 32 : (i - N) * 32 + 31]) begin
                w1[0:31] = keys[(i - N) * 32 : (i - N) * 32 + 31];
            end

            always @(keys[(i - 1) * 32 : (i - 1) * 32 + 31]) begin
                w2[0:31] = keys[(i - 1) * 32 : (i - 1) * 32 + 31];
            end

            reg [0:31] rcon;
            // rcon lookup table
            always @(w1[0:31]) begin
                case (i/N)
                    1: rcon[0:31] = 32'b00000001000000000000000000000000;
                    2: rcon[0:31] = 32'b00000010000000000000000000000000;
                    3: rcon[0:31] = 32'b00000100000000000000000000000000;
                    4: rcon[0:31] = 32'b00001000000000000000000000000000;
                    5: rcon[0:31] = 32'b00010000000000000000000000000000;
                    6: rcon[0:31] = 32'b00100000000000000000000000000000;
                    7: rcon[0:31] = 32'b01000000000000000000000000000000;
                    8: rcon[0:31] = 32'b10000000000000000000000000000000;
                    9: rcon[0:31] = 32'b00011011000000000000000000000000;
                    10: rcon[0:31] = 32'b00110110000000000000000000000000;
                endcase
            end
                
            wire [0:31] temp;
            assign temp = w1[0:31] ^ w2_sub[0:31] ^ rcon[0:31];

            always @(temp[0:31]) begin
                keys[i * 32 : i * 32 + 31] = temp[0:31];
            end
        end
        else begin
            wire [0:31] w1;
            wire [0:31] w2;

            assign w1[0:31] = keys[(i - N) * 32 : (i - N) * 32 + 31];            
            assign w2[0:31] = keys[(i - 1) * 32 : (i - 1) * 32 + 31];
            
            wire [0:31] temp;
            assign temp = w1[0:31] ^ w2[0:31];

            always @(temp[0:31]) begin
                keys[i * 32 : i * 32 + 31] = temp[0:31];
            end
        end
    end
    
endmodule