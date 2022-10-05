module DecryptBlockStart (
    input wire [0:127] previous_state,
    input wire [0:127] key1,
    input wire [0:127] key2,
    output wire [0:127] next_state
);
    wire [0:127] addRound_state, subBytes_state, shiftRows_state;

    AddRoundKey addRoundKeyModule1(previous_state, key1, addRound_state);
    ShiftRowsInverse shiftRowsModule(addRound_state, shiftRows_state);
    SubBytesInverse subBytesModule(shiftRows_state, subBytes_state);    
    AddRoundKey AddRoundKeyModule2(subBytes_state, key2, next_state);
    
endmodule