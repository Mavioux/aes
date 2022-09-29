module EncryptBlock (
    input wire [0:127] previous_state,
    input wire [0:127] key,
    output reg [0:127] next_state
);
    wire [0:127] addRound_state, subBytes_state, shiftRows_state;

    AddRoundKey addRoundKeyModule(previous_state, key, addRound_state);
    SubBytes subBytesModule(addRound_state, subBytes_state);
    ShiftRows shiftRowsModule(subBytes_state, shiftRows_state);
    MixColumns MixColumnsModule(shiftRows_state, next_state);
    
endmodule