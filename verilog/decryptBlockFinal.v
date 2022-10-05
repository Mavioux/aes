module DecryptBlockFinal (
    input wire [0:127] previous_state,
    input wire [0:127] key,
    output reg [0:127] output_state
);
    wire [0:127] addRound_state, subBytes_state, shiftRows_state, mixColumns_state, next_state;

    MixColumnsInverse MixColumnsModule(previous_state, mixColumns_state);
    ShiftRowsInverse shiftRowsModule(mixColumns_state, shiftRows_state);
    SubBytesInverse subBytesModule(shiftRows_state, subBytes_state);
    AddRoundKey addRoundKeyModule(subBytes_state, key, next_state);

    genvar i, j;
    for (i = 0; i < 4; i = i + 1) begin
        for (j = 0; j < 4; j = j + 1) begin
            always @(next_state[0:127]) begin
                output_state[32 * i + 8 * j: 32 * i + 8 * j + 7] = next_state[32 * j + 8 * i: 32 * j + 8 * i + 7];
            end    
        end
    end
    
endmodule