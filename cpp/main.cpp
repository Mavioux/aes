///////////////////////////////////////////////////////////////////
//                                                               //
//                                                               //
//                               ,--.                            //
//   ,--,--,--. ,--,--.,--.  ,--.`--' ,---. ,--.,--.,--.  ,--.   //
//   |        |' ,-.  | \  `'  / ,--.| .-. ||  ||  | \  `'  /    //
//   |  |  |  |\ '-'  |  \    /  |  |' '-' ''  ''  ' /  /.  \    //
//   `--`--`--' `--`--'   `--'   `--' `---'  `----' '--'  '--'   //
//                                                               //
//                                                               //
//                                                               //
///////////////////////////////////////////////////////////////////

#include "aes.hpp"

#include <stdio.h>
#include <iostream>
#include <bitset>

int main(){
    AES_SIZE aes_size = AES_128;

    int plaintext[] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff };
    int key[] = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f }; 


    AES aes(aes_size);
    int ciphertext[16];
    aes.Encrypt(plaintext, key, ciphertext);


    for(int i = 0; i < 16; i++) {
        printf("%x ", ciphertext[i]);
    }

    printf("\n");

    int ciphertext_dec[16] = {0x69, 0xc4, 0xe0, 0xd8, 0x6a, 0x7b, 0x04, 0x30, 0xd8, 0xcd, 0xb7, 0x80, 0x70, 0xb4, 0xc5, 0x5a};
    int plaintext_dec[16];
    aes.Decrypt(ciphertext_dec, key, plaintext_dec);

    for(int i = 0; i < 16; i++) {
        printf("%x ", plaintext_dec[i]);
    }
}