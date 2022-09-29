module SubBytes (
    input wire [0:127] state;
    output reg [0:127] new_state;
);


    integer i;

    for (i = 0; i < 16; i = i + 1) begin
        SubWord(state[i * 8 + i * 8 + 7], new_state[i * 8 + i * 8 + 7]);
    end
    
endmodule