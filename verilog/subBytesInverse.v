module SubBytesInverse (
    input wire [0:127] state,
    output wire [0:127] new_state
);

    genvar i;

    for (i = 0; i < 16; i = i + 1) begin
        SubWordInverse subWordInverseModule(state[i * 8 : i * 8 + 7], new_state[i * 8 : i * 8 + 7]);
    end
    
endmodule