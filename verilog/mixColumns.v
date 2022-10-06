module MixColumns (
    input wire [0:127] state,
    output wire [0:127] new_state
);

    wire [0:31] row;

    genvar i;

    for (i = 0; i < 4; i = i + 1) begin
        wire [0:31] row;
        wire [0:31] output_row;
        genvar j;
        for (j = 0; j < 4; j = j + 1) begin
            assign row[j * 8 : j * 8 + 7] = state[32 * j + 8 * i: 32 * j + 8 * i + 7];
        end

        MixColumn mixColumnModule(row, output_row);

        for (j = 0; j < 4; j = j + 1) begin
            assign new_state[32 * j + 8 * i: 32 * j + 8 * i + 7] = output_row[j * 8 : j * 8 + 7];
        end
    end

    

endmodule