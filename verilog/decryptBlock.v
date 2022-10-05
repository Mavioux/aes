module DecryptBlock (
    input wire [0:127] previous_state,
    input wire [0:127] key,
    output wire [0:127] next_state
);
    wire [0:127] addRound_state, subBytes_state, shiftRows_state, mixColumns_state;    
    
    MixColumnsInverse MixColumnsModule(previous_state, mixColumns_state);
    ShiftRowsInverse shiftRowsModule(mixColumns_state, shiftRows_state);
    SubBytesInverse subBytesModule(shiftRows_state, subBytes_state);
    AddRoundKey addRoundKeyModule(subBytes_state, key, next_state);
    
endmodule