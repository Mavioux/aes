#include "../aes.hpp"
#include <cassert>
#include "stdio.h"

int plaintexts[10][16] = {
    { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff },
    {},
    {},
    {},
    {},
    {},
    {},
    {},
    {},
    {}
};

int keys[10][16] = {
    { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f },
    {},
    {},
    {},
    {},
    {},
    {},
    {},
    {},
    {}
};

int ciphertexts[10][16] = {
    { 0x69, 0xc4, 0xe0, 0xd8, 0x6a, 0x7b, 0x4, 0x30, 0xd8, 0xcd, 0xb7, 0x80, 0x70, 0xb4, 0xc5, 0x5a },
    {},
    {},
    {},
    {},
    {},
    {},
    {},
    {},
    {}
};

int main() {
    int result_ciphertexts[10][16];
    int result_plaintexts[10][16];

    AES_SIZE aes_size = AES_128;
    AES aes(aes_size);

    for(int i = 0; i < 1; i++) {
        aes.Encrypt(plaintexts[i], keys[i], result_ciphertexts[i]);

        for(int j = 0; j < 16; j++) {
            assert(result_ciphertexts[i][j] == ciphertexts[i][j]);
        }

        aes.Decrypt(ciphertexts[i], keys[i], result_plaintexts[i]);
        
        for(int j = 0; j < 16; j++) {
            assert(result_plaintexts[i][j] == plaintexts[i][j]);
        }
    }
    printf("All tests passed!\n");
    return 0;
}