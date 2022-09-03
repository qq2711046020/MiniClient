// Fill out your copyright notice in the Description page of Project Settings.


#include "ChaCha20.h"

THIRD_PARTY_INCLUDES_START
#include "osrng.h"
THIRD_PARTY_INCLUDES_END

FSymmetricCryptoKey GenChaCha20key()
{
#define CHACHA_KEYSIZE 32
#define CHACHA_IVSIZE 8	
	TArray<uint8> Key, IV;
	Key.SetNumUninitialized(CHACHA_KEYSIZE);
	IV.SetNumUninitialized(CHACHA_IVSIZE);
	CryptoPP::AutoSeededRandomPool Rng;
	Rng.GenerateBlock(Key.GetData(), Key.Num());
	Rng.GenerateBlock(IV.GetData(), IV.Num());
	return FSymmetricCryptoKey(Key, IV);
}
