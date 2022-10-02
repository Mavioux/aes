module EncryptFinalBlock (
    input wire [0:127] previous_state,
    input wire [0:127] key1,
    input wire [0:127] key2,
    output reg [0:127] ciphertext
);
    wire [0:127] addRound_state, subBytes_state, shiftRows_state, next_state;

    AddRoundKey addRoundKeyModule1(previous_state, key1, addRound_state);
    SubBytes subBytesModule(addRound_state, subBytes_state);
    ShiftRows shiftRowsModule(subBytes_state, shiftRows_state);
    AddRoundKey AddRoundKeyModule2(shiftRows_state, key2, next_state);

    genvar i, j;
    for (i = 0; i < 4; i = i + 1) begin
        for (j = 0; j < 4; j = j + 1) begin
            always @(next_state[0:127]) begin
                ciphertext[32 * i + 8 * j: 32 * i + 8 * j + 7] = next_state[32 * j + 8 * i: 32 * j + 8 * i + 7];
            end    
        end
    end
    
endmodule