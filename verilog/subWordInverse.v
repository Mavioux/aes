module SubWordInverse (
    input wire [0:7] w_in,
    output reg [0:7] w_out
);

    always @(w_in[0:7]) begin
        case(w_in[0:7])
            8'h0 : w_out = 8'h52;
            8'h1 : w_out = 8'h9;
            8'h2 : w_out = 8'h6a;
            8'h3 : w_out = 8'hd5;
            8'h4 : w_out = 8'h30;
            8'h5 : w_out = 8'h36;
            8'h6 : w_out = 8'ha5;
            8'h7 : w_out = 8'h38;
            8'h8 : w_out = 8'hbf;
            8'h9 : w_out = 8'h40;
            8'ha : w_out = 8'ha3;
            8'hb : w_out = 8'h9e;
            8'hc : w_out = 8'h81;
            8'hd : w_out = 8'hf3;
            8'he : w_out = 8'hd7;
            8'hf : w_out = 8'hfb;
            8'h10 : w_out = 8'h7c;
            8'h11 : w_out = 8'he3;
            8'h12 : w_out = 8'h39;
            8'h13 : w_out = 8'h82;
            8'h14 : w_out = 8'h9b;
            8'h15 : w_out = 8'h2f;
            8'h16 : w_out = 8'hff;
            8'h17 : w_out = 8'h87;
            8'h18 : w_out = 8'h34;
            8'h19 : w_out = 8'h8e;
            8'h1a : w_out = 8'h43;
            8'h1b : w_out = 8'h44;
            8'h1c : w_out = 8'hc4;
            8'h1d : w_out = 8'hde;
            8'h1e : w_out = 8'he9;
            8'h1f : w_out = 8'hcb;
            8'h20 : w_out = 8'h54;
            8'h21 : w_out = 8'h7b;
            8'h22 : w_out = 8'h94;
            8'h23 : w_out = 8'h32;
            8'h24 : w_out = 8'ha6;
            8'h25 : w_out = 8'hc2;
            8'h26 : w_out = 8'h23;
            8'h27 : w_out = 8'h3d;
            8'h28 : w_out = 8'hee;
            8'h29 : w_out = 8'h4c;
            8'h2a : w_out = 8'h95;
            8'h2b : w_out = 8'hb;
            8'h2c : w_out = 8'h42;
            8'h2d : w_out = 8'hfa;
            8'h2e : w_out = 8'hc3;
            8'h2f : w_out = 8'h4e;
            8'h30 : w_out = 8'h8;
            8'h31 : w_out = 8'h2e;
            8'h32 : w_out = 8'ha1;
            8'h33 : w_out = 8'h66;
            8'h34 : w_out = 8'h28;
            8'h35 : w_out = 8'hd9;
            8'h36 : w_out = 8'h24;
            8'h37 : w_out = 8'hb2;
            8'h38 : w_out = 8'h76;
            8'h39 : w_out = 8'h5b;
            8'h3a : w_out = 8'ha2;
            8'h3b : w_out = 8'h49;
            8'h3c : w_out = 8'h6d;
            8'h3d : w_out = 8'h8b;
            8'h3e : w_out = 8'hd1;
            8'h3f : w_out = 8'h25;
            8'h40 : w_out = 8'h72;
            8'h41 : w_out = 8'hf8;
            8'h42 : w_out = 8'hf6;
            8'h43 : w_out = 8'h64;
            8'h44 : w_out = 8'h86;
            8'h45 : w_out = 8'h68;
            8'h46 : w_out = 8'h98;
            8'h47 : w_out = 8'h16;
            8'h48 : w_out = 8'hd4;
            8'h49 : w_out = 8'ha4;
            8'h4a : w_out = 8'h5c;
            8'h4b : w_out = 8'hcc;
            8'h4c : w_out = 8'h5d;
            8'h4d : w_out = 8'h65;
            8'h4e : w_out = 8'hb6;
            8'h4f : w_out = 8'h92;
            8'h50 : w_out = 8'h6c;
            8'h51 : w_out = 8'h70;
            8'h52 : w_out = 8'h48;
            8'h53 : w_out = 8'h50;
            8'h54 : w_out = 8'hfd;
            8'h55 : w_out = 8'hed;
            8'h56 : w_out = 8'hb9;
            8'h57 : w_out = 8'hda;
            8'h58 : w_out = 8'h5e;
            8'h59 : w_out = 8'h15;
            8'h5a : w_out = 8'h46;
            8'h5b : w_out = 8'h57;
            8'h5c : w_out = 8'ha7;
            8'h5d : w_out = 8'h8d;
            8'h5e : w_out = 8'h9d;
            8'h5f : w_out = 8'h84;
            8'h60 : w_out = 8'h90;
            8'h61 : w_out = 8'hd8;
            8'h62 : w_out = 8'hab;
            8'h63 : w_out = 8'h0;
            8'h64 : w_out = 8'h8c;
            8'h65 : w_out = 8'hbc;
            8'h66 : w_out = 8'hd3;
            8'h67 : w_out = 8'ha;
            8'h68 : w_out = 8'hf7;
            8'h69 : w_out = 8'he4;
            8'h6a : w_out = 8'h58;
            8'h6b : w_out = 8'h5;
            8'h6c : w_out = 8'hb8;
            8'h6d : w_out = 8'hb3;
            8'h6e : w_out = 8'h45;
            8'h6f : w_out = 8'h6;
            8'h70 : w_out = 8'hd0;
            8'h71 : w_out = 8'h2c;
            8'h72 : w_out = 8'h1e;
            8'h73 : w_out = 8'h8f;
            8'h74 : w_out = 8'hca;
            8'h75 : w_out = 8'h3f;
            8'h76 : w_out = 8'hf;
            8'h77 : w_out = 8'h2;
            8'h78 : w_out = 8'hc1;
            8'h79 : w_out = 8'haf;
            8'h7a : w_out = 8'hbd;
            8'h7b : w_out = 8'h3;
            8'h7c : w_out = 8'h1;
            8'h7d : w_out = 8'h13;
            8'h7e : w_out = 8'h8a;
            8'h7f : w_out = 8'h6b;
            8'h80 : w_out = 8'h3a;
            8'h81 : w_out = 8'h91;
            8'h82 : w_out = 8'h11;
            8'h83 : w_out = 8'h41;
            8'h84 : w_out = 8'h4f;
            8'h85 : w_out = 8'h67;
            8'h86 : w_out = 8'hdc;
            8'h87 : w_out = 8'hea;
            8'h88 : w_out = 8'h97;
            8'h89 : w_out = 8'hf2;
            8'h8a : w_out = 8'hcf;
            8'h8b : w_out = 8'hce;
            8'h8c : w_out = 8'hf0;
            8'h8d : w_out = 8'hb4;
            8'h8e : w_out = 8'he6;
            8'h8f : w_out = 8'h73;
            8'h90 : w_out = 8'h96;
            8'h91 : w_out = 8'hac;
            8'h92 : w_out = 8'h74;
            8'h93 : w_out = 8'h22;
            8'h94 : w_out = 8'he7;
            8'h95 : w_out = 8'had;
            8'h96 : w_out = 8'h35;
            8'h97 : w_out = 8'h85;
            8'h98 : w_out = 8'he2;
            8'h99 : w_out = 8'hf9;
            8'h9a : w_out = 8'h37;
            8'h9b : w_out = 8'he8;
            8'h9c : w_out = 8'h1c;
            8'h9d : w_out = 8'h75;
            8'h9e : w_out = 8'hdf;
            8'h9f : w_out = 8'h6e;
            8'ha0 : w_out = 8'h47;
            8'ha1 : w_out = 8'hf1;
            8'ha2 : w_out = 8'h1a;
            8'ha3 : w_out = 8'h71;
            8'ha4 : w_out = 8'h1d;
            8'ha5 : w_out = 8'h29;
            8'ha6 : w_out = 8'hc5;
            8'ha7 : w_out = 8'h89;
            8'ha8 : w_out = 8'h6f;
            8'ha9 : w_out = 8'hb7;
            8'haa : w_out = 8'h62;
            8'hab : w_out = 8'he;
            8'hac : w_out = 8'haa;
            8'had : w_out = 8'h18;
            8'hae : w_out = 8'hbe;
            8'haf : w_out = 8'h1b;
            8'hb0 : w_out = 8'hfc;
            8'hb1 : w_out = 8'h56;
            8'hb2 : w_out = 8'h3e;
            8'hb3 : w_out = 8'h4b;
            8'hb4 : w_out = 8'hc6;
            8'hb5 : w_out = 8'hd2;
            8'hb6 : w_out = 8'h79;
            8'hb7 : w_out = 8'h20;
            8'hb8 : w_out = 8'h9a;
            8'hb9 : w_out = 8'hdb;
            8'hba : w_out = 8'hc0;
            8'hbb : w_out = 8'hfe;
            8'hbc : w_out = 8'h78;
            8'hbd : w_out = 8'hcd;
            8'hbe : w_out = 8'h5a;
            8'hbf : w_out = 8'hf4;
            8'hc0 : w_out = 8'h1f;
            8'hc1 : w_out = 8'hdd;
            8'hc2 : w_out = 8'ha8;
            8'hc3 : w_out = 8'h33;
            8'hc4 : w_out = 8'h88;
            8'hc5 : w_out = 8'h7;
            8'hc6 : w_out = 8'hc7;
            8'hc7 : w_out = 8'h31;
            8'hc8 : w_out = 8'hb1;
            8'hc9 : w_out = 8'h12;
            8'hca : w_out = 8'h10;
            8'hcb : w_out = 8'h59;
            8'hcc : w_out = 8'h27;
            8'hcd : w_out = 8'h80;
            8'hce : w_out = 8'hec;
            8'hcf : w_out = 8'h5f;
            8'hd0 : w_out = 8'h60;
            8'hd1 : w_out = 8'h51;
            8'hd2 : w_out = 8'h7f;
            8'hd3 : w_out = 8'ha9;
            8'hd4 : w_out = 8'h19;
            8'hd5 : w_out = 8'hb5;
            8'hd6 : w_out = 8'h4a;
            8'hd7 : w_out = 8'hd;
            8'hd8 : w_out = 8'h2d;
            8'hd9 : w_out = 8'he5;
            8'hda : w_out = 8'h7a;
            8'hdb : w_out = 8'h9f;
            8'hdc : w_out = 8'h93;
            8'hdd : w_out = 8'hc9;
            8'hde : w_out = 8'h9c;
            8'hdf : w_out = 8'hef;
            8'he0 : w_out = 8'ha0;
            8'he1 : w_out = 8'he0;
            8'he2 : w_out = 8'h3b;
            8'he3 : w_out = 8'h4d;
            8'he4 : w_out = 8'hae;
            8'he5 : w_out = 8'h2a;
            8'he6 : w_out = 8'hf5;
            8'he7 : w_out = 8'hb0;
            8'he8 : w_out = 8'hc8;
            8'he9 : w_out = 8'heb;
            8'hea : w_out = 8'hbb;
            8'heb : w_out = 8'h3c;
            8'hec : w_out = 8'h83;
            8'hed : w_out = 8'h53;
            8'hee : w_out = 8'h99;
            8'hef : w_out = 8'h61;
            8'hf0 : w_out = 8'h17;
            8'hf1 : w_out = 8'h2b;
            8'hf2 : w_out = 8'h4;
            8'hf3 : w_out = 8'h7e;
            8'hf4 : w_out = 8'hba;
            8'hf5 : w_out = 8'h77;
            8'hf6 : w_out = 8'hd6;
            8'hf7 : w_out = 8'h26;
            8'hf8 : w_out = 8'he1;
            8'hf9 : w_out = 8'h69;
            8'hfa : w_out = 8'h14;
            8'hfb : w_out = 8'h63;
            8'hfc : w_out = 8'h55;
            8'hfd : w_out = 8'h21;
            8'hfe : w_out = 8'hc;
            8'hff : w_out = 8'h7d;
        endcase
    end
    
endmodule