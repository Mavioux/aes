# AES in C++ and Verilog

This repository contains an AES-128 implementation in C++ and Verilog.

## C++

Cpp folder contains all c++ files and testbenches. Usage is shown below.

For Encryption:

    AES_SIZE aes_size = AES_128;
    AES aes(aes_size);
    int plaintext[] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff };
    int key[] = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f };
    int ciphertext[16];
    aes.Encrypt(plaintext, key, ciphertext);

For Decryption:

    AES_SIZE aes_size = AES_128;
    AES aes(aes_size);
    int ciphertext_dec[16] = {0x69, 0xc4, 0xe0, 0xd8, 0x6a, 0x7b, 0x04, 0x30, 0xd8, 0xcd, 0xb7, 0x80, 0x70, 0xb4, 0xc5, 0x5a};
    int plaintext_dec[16];
    aes.Decrypt(ciphertext_dec, key, plaintext_dec);

## Verilog

Verilog folder contains all verilog files, testbenches and testvectors.

The AES module has the following inputs:

    input wire clk,
    input wire reset, // synchronous reset high
    input wire encrypt, // set 1 for at least on clock cycle to begin encryption process 
    input wire decrypt, // set 1 for at least on clock cycle to begin decryption process  
    input wire [0:127] plaintext_in,
    inout wire [0:127] ciphertext_out,
    input wire [0:127] key,
    output wire [0:127] ciphertext_in,
    output wire [0:127] plaintext_out 

Clk is the clock of the implementation.

Reset stops the encryption or the decryption process when the next positive clock edge is detected.

Encrypt or Decrypt changes between encryption or decryption modes. When none is high, no mode is selected. When both are high a reset is triggered.

Key is shared between both modules.

Plaintext_in and Ciphertext_out are the input and output of encryption respectively.

Ciphertext_in and Plaintext_out are the input and output of decryption respectively.

### Testbenches

The module has been tested, there are 3 main testbenches, one for encryption, one for decryption and one for testing the main AES module.

# Acknowledgments

This project would not have been possible without the help of the amazing people below:

- Natasha
- Aggelos
- Lila
- Nontas
- Vaggeliw
- Dimitris

