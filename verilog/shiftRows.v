module ShiftRows (
    input wire [0:127] state,
    output wire [0:127] new_state
);

    assign new_state[0 * 8: 0 * 8 + 7] = state[0 * 8: 0 * 8 + 7];
    assign new_state[1 * 8: 1 * 8 + 7] = state[1 * 8: 1 * 8 + 7];
    assign new_state[2 * 8: 2 * 8 + 7] = state[2 * 8: 2 * 8 + 7];
    assign new_state[3 * 8: 3 * 8 + 7] = state[3 * 8: 3 * 8 + 7];
    assign new_state[4 * 8: 4 * 8 + 7] = state[5 * 8: 5 * 8 + 7];
    assign new_state[5 * 8: 5 * 8 + 7] = state[6 * 8: 6 * 8 + 7];
    assign new_state[6 * 8: 6 * 8 + 7] = state[7 * 8: 7 * 8 + 7];
    assign new_state[7 * 8: 7 * 8 + 7] = state[4 * 8: 4 * 8 + 7];
    assign new_state[8 * 8: 8 * 8 + 7] = state[10 * 8: 10 * 8 + 7];
    assign new_state[9 * 8: 9 * 8 + 7] = state[11 * 8: 11 * 8 + 7];
    assign new_state[10 * 8: 10 * 8 + 7] = state[8 * 8: 8 * 8 + 7];
    assign new_state[11 * 8: 11 * 8 + 7] = state[9 * 8: 9 * 8 + 7];
    assign new_state[12 * 8: 12 * 8 + 7] = state[15 * 8: 15 * 8 + 7];
    assign new_state[13 * 8: 13 * 8 + 7] = state[12 * 8: 12 * 8 + 7];
    assign new_state[14 * 8: 14 * 8 + 7] = state[13 * 8: 13 * 8 + 7];
    assign new_state[15 * 8: 15 * 8 + 7] = state[14 * 8: 14 * 8 + 7];

endmodule