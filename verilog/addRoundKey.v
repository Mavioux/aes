module AddRoundKey (
    input wire [0:127] state,
    input wire [0:127] key,
    output reg [0:127] new_state
);

    always @(state[0:127] or key[0:127]) begin
        new_state[0:127] = state[0:127] ^ key[0:127];
    end
    
endmodule