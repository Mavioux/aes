///////////////////////////////////////////////////////////////////
//                                                               //
//                                                               //
//                            ,--.                               //
//   ,--,--,--. ,--,--.,--.  ,--.`--' ,---. ,--.,--.,--.  ,--.   //
//   |        |' ,-.  | \  `'  / ,--.| .-. ||  ||  | \  `'  /    //
//   |  |  |  |\ '-'  |  \    /  |  |' '-' ''  ''  ' /  /.  \    //
//   `--`--`--' `--`--'   `--'   `--' `---'  `----' '--'  '--'   //
//                                                               //
//                                                               //
//                                                               //
///////////////////////////////////////////////////////////////////

#include "aes.hpp"

AES::AES(AES_SIZE aes_size) {
    switch (aes_size)
    {
    case AES_128:
        this->key_len = 16;
        this->number_of_rounds = 10;
        break;
    
    default:
        // or throw exception
        this->key_len = 16;
        this->number_of_rounds = 10;
        break;
    }     
}

void AES::Encrypt(int plaintext[], int key[], int ciphertext[]) {
    int state[16];
    int temp_keys[11][16];
    int keys[11][16];

    KeyExpansion(key, temp_keys); 

    for(uint8_t i = 0; i < 4; i++){
        for(uint8_t j = 0; j < 4; j++){
            state[4 * i + j] = plaintext[4 * j + i];
        } 
    }

    for(uint8_t k = 0; k < 11; k++) {
        for(uint8_t i = 0; i < 4; i++){
            for(uint8_t j = 0; j < 4; j++){
                keys[k][4 * i + j] = temp_keys[k][4 * j + i];
            } 
        }
    }
    AddRoundKey(state, keys[0]);
    for(uint8_t i = 1; i < this->number_of_rounds; i++) {
        SubBytes(state);
        ShiftRows(state);
        MixColumnsLUT(state);
        AddRoundKey(state, keys[i]);
    }
    SubBytes(state);
    ShiftRows(state);
    AddRoundKey(state, keys[10]);
    
    for(uint8_t i = 0; i < 4; i++){
        for(uint8_t j = 0; j < 4; j++){
            ciphertext[4 * i + j] = state[4 * j + i];
        } 
    }
}

void AES::Decrypt(int ciphertext[16], int key[16], int plaintext[16]) {
    int state[16];
    int temp_keys[11][16];
    int keys[11][16];

    KeyExpansion(key, temp_keys); 

    for(uint8_t i = 0; i < 4; i++){
        for(uint8_t j = 0; j < 4; j++){
            state[4 * i + j] = ciphertext[4 * j + i];
        } 
    }

    for(uint8_t k = 0; k < 11; k++) {
        for(uint8_t i = 0; i < 4; i++){
            for(uint8_t j = 0; j < 4; j++){
                keys[10-k][4 * i + j] = temp_keys[k][4 * j + i];
            } 
        }
    }

    AddRoundKey(state, keys[0]);
    ShiftRowsInverse(state);
    SubBytesInverse(state);
    for(uint8_t i = 1; i < this->number_of_rounds; i++) {
        AddRoundKey(state, keys[i]);
        MixColumnsLUTInverse(state);
        ShiftRowsInverse(state);
        SubBytesInverse(state);
    }
    AddRoundKey(state, keys[10]);

    for(uint8_t i = 0; i < 4; i++){
        for(uint8_t j = 0; j < 4; j++){
            plaintext[4 * i + j] = state[4 * j + i];
        } 
    }
}

void AES::KeyExpansion(int key[16], int keys[11][16]) {
    int N = 4;

    // w0-w3 set to initial key
    int w[44][4];
    memcpy(&w[0], &key[0], 4 * sizeof(int));
    memcpy(&w[1], &key[4], 4 * sizeof(int));
    memcpy(&w[2], &key[8], 4 * sizeof(int));
    memcpy(&w[3], &key[12], 4 * sizeof(int));

    for(uint8_t j = 0; j < 4; j++) {
        memcpy(&keys[0][j * 4], &w[j][0], 4 * sizeof(int));
    }   

    //w4-w43
    for(int i = 4; i < 44; i++) {
        if(i % N == 0) {
            int w1[4];
            memcpy(w1, &w[i - N], 4 * sizeof(int));
            int w2[4];
            memcpy(w2, &w[i - 1], 4 * sizeof(int));
            RotWord(w2);
            SubWord(w2);

            for(uint8_t j = 0; j < 4; j++) {
                w[i][j] = w1[j] ^ w2[j] ^ RCON[i/N-1][j];
            }
        }
        else {
            int w1[4];
            memcpy(w1, &w[i - N], 4 * sizeof(int));
            int w2[4];
            memcpy(w2, &w[i - 1], 4 * sizeof(int));

            for(uint8_t j = 0; j < 4; j++) {
                w[i][j] = w1[j] ^ w2[j];
            }
        }

        memcpy(&keys[i/4][(i % 4) * 4], &w[i][0], 4 * sizeof(int));  
    }
}

void AES::RotWord(int w[4]) {
    int temp = w[0];
    w[0] = w[1];
    w[1] = w[2];
    w[2] = w[3];  
    w[3] = temp;         
}

void AES::SubWord(int w[4]) {
    for(uint8_t i = 0; i < 4; i++) {
        w[i] = sbox[w[i] / 16][w[i] % 16];
    }
}

void AES::AddRoundKey(int state[], int key[]) {
    int temp[16];
    for(uint8_t i = 0; i < 16; i++) {
        temp[i] = state[i] ^ key[i];
    }
    memcpy(state, temp, 16 * sizeof(int));
}

void AES::SubBytes(int state[16]) {
    for(uint8_t i = 0; i < 16; i++) {
        state[i] = sbox[state[i] / 16][state[i] % 16];
    }
}

void AES::ShiftRows(int state[]) {
    int temp[16];
    for(uint8_t i = 0; i < 4; i++) {
        temp[i] = state[i];
    }
    temp[4] = state[5];
    temp[5] = state[6];
    temp[6] = state[7];
    temp[7] = state[4];
    temp[8] = state[10];
    temp[9] = state[11];
    temp[10] = state[8];
    temp[11] = state[9];
    temp[12] = state[15];
    temp[13] = state[12];
    temp[14] = state[13];
    temp[15] = state[14];

    memcpy(state, temp, 16 * sizeof(int));
}

void AES::SubBytesInverse(int state[]) {
    for(uint8_t i = 0; i < 16; i++) {
        state[i] = inv_sbox[state[i] / 16][state[i] % 16];
    }
}

void AES::ShiftRowsInverse(int state[]) {
    int temp[16];
    for(uint8_t i = 0; i < 4; i++) {
        temp[i] = state[i];
    }
    temp[4] = state[7];
    temp[5] = state[4];
    temp[6] = state[5];
    temp[7] = state[6];
    temp[8] = state[10];
    temp[9] = state[11];
    temp[10] = state[8];
    temp[11] = state[9];
    temp[12] = state[13];
    temp[13] = state[14];
    temp[14] = state[15];
    temp[15] = state[12];

    memcpy(state, temp, 16 * sizeof(int));
}

void AES::MixColumns(int state[]) {
    int row[4];
    for(uint8_t i = 0; i < 4; i++) {
        for(uint8_t j = 0; j < 4; j++) {
            row[j] = state[4 * j + i];
        }
        MixColumn(row);
        for(uint8_t j = 0; j < 4; j++) {
            if(row[j] > 255) {
                row[j] -= 256; 
            }
            state[4 * j + i] = row[j];
        }
    }
}

void AES::MixColumn(int r[]) {
    int a[4];
    int b[4];
    int c;
    int h;

    for (c = 0; c < 4; c++) {
        a[c] = r[c];
        /* h is 0xff if the high bit of r[c] is set, 0 otherwise */
        h = (r[c] >> 7) & 1; /* arithmetic right shift, thus shifting in either zeros or ones */
        b[c] = r[c] << 1; /* implicitly removes high bit because b[c] is an 8-bit char, so we xor by 0x1b and not 0x11b in the next line */
        b[c] ^= h * 0x1B; /* Rijndael's Galois field */
    }
    r[0] = b[0] ^ a[3] ^ a[2] ^ b[1] ^ a[1]; /* 2 * a0 + a3 + a2 + 3 * a1 */
    r[1] = b[1] ^ a[0] ^ a[3] ^ b[2] ^ a[2]; /* 2 * a1 + a0 + a3 + 3 * a2 */
    r[2] = b[2] ^ a[1] ^ a[0] ^ b[3] ^ a[3]; /* 2 * a2 + a1 + a0 + 3 * a3 */
    r[3] = b[3] ^ a[2] ^ a[1] ^ b[0] ^ a[0]; /* 2 * a3 + a2 + a1 + 3 * a0 */
}

void AES::MixColumnsLUT(int state[]) {
    int row[4];
    for(uint8_t i = 0; i < 4; i++) {
        for(uint8_t j = 0; j < 4; j++) {
            row[j] = state[4 * j + i];
        }
        MixColumnLUT(row, i);
        for(uint8_t j = 0; j < 4; j++) {
            if(row[j] > 255) {
                row[j] -= 256; 
            }
            state[4 * j + i] = row[j];
        }
    }
}

void AES::MixColumnLUT(int r[], int i) {
    int row[4];
    memcpy(row, r, 4 * sizeof(int));
    for(uint8_t j = 0; j < 4; j++) {
        int result = 0;
        for(uint8_t k = 0; k < 4; k++) {
            int multiplier = galois_mul[(j * 4 + k)];
            int temp; 
            if(multiplier == 1){
                temp = row[k];
            }
            else {
                temp = Galois_Mul_LUT[multiplier - 1][row[k]];
            }                    
            result ^= temp;
        }
        r[j] = result;
    }
}

void AES::MixColumnsLUTInverse(int state[]) {
    int row[4];
    for(uint8_t i = 0; i < 4; i++) {
        for(uint8_t j = 0; j < 4; j++) {
            row[j] = state[4 * j + i];
        }
        MixColumnLUTInverse(row, i);
        for(uint8_t j = 0; j < 4; j++) {
            if(row[j] > 255) {
                row[j] -= 256; 
            }
            state[4 * j + i] = row[j];
        }
    }
}

void AES::MixColumnLUTInverse(int r[], int i) {
    int row[4];
    memcpy(row, r, 4 * sizeof(int));
    for(uint8_t j = 0; j < 4; j++) {
        int result = 0;
        for(uint8_t k = 0; k < 4; k++) {
            int multiplier = galois_mul_inv[(j * 4 + k)];
            int temp; 
            if(multiplier == 1){
                temp = row[k];
            }
            else {
                temp = Galois_Mul_LUT[multiplier - 1][row[k]];
            }                    
            result ^= temp;
        }
        r[j] = result;
    }
}    

// TODO Implement hashmap in SubBytes step