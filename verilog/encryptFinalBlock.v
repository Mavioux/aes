module EncryptFinalBlock (
    input wire [0:127] previous_state,
    input wire [0:127] key1,
    input wire [0:127] key2,
    output wire [0:127] next_state
);
    wire [0:127] addRound_state, subBytes_state, shiftRows_state;

    AddRoundKey addRoundKeyModule1(previous_state, key1, addRound_state);
    SubBytes subBytesModule(addRound_state, subBytes_state);
    ShiftRows shiftRowsModule(subBytes_state, shiftRows_state);
    AddRoundKey AddRoundKeyModule2(shiftRows_state, key2, next_state);
    
endmodule