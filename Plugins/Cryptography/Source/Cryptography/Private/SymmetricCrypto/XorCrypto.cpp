#include "SymmetricCrypto/XorCrypto.h"
#include "CryptographyPrivatePCH.h"

THIRD_PARTY_INCLUDES_START
#include "osrng.h"
THIRD_PARTY_INCLUDES_END

// Encryption
FXorEncryption::FXorEncryption(const FSymmetricCryptoKey & InCryptoKey)
{
	check(InCryptoKey.IsValid())
	_Key = InCryptoKey.GetKey();
	const TArray<uint8>& InIV = InCryptoKey.GetIV();
	for (int32 i = 0; i < _Key.Num(); ++i)
	{
		_Key[i] ^= InIV[i % InIV.Num()];
	}
}

bool FXorEncryption::EncryptData(const TArray<uint8>& InData, TArray<uint8>& OutData)
{
	OutData = InData;
	for (int32 i = 0; i < OutData.Num(); ++i)
	{
		OutData[i] ^= _Key[i % _Key.Num()];
	}
	return true;
}

// Decryption
FXorDecryption::FXorDecryption(const FSymmetricCryptoKey & InCryptoKey)
{
	check(InCryptoKey.IsValid())
	_Key = InCryptoKey.GetKey();
	const TArray<uint8>& InIV = InCryptoKey.GetIV();
	for (int32 i = 0; i < _Key.Num(); ++i)
	{
		_Key[i] ^= InIV[i % InIV.Num()];
	}
}

bool FXorDecryption::DecryptData(const TArray<uint8>& InData, TArray<uint8>& OutData)
{
	OutData = InData;
	for (int32 i = 0; i < OutData.Num(); ++i)
	{
		OutData[i] ^= _Key[i % _Key.Num()];
	}
	return true;
}

namespace XorCrypto
{
	FSymmetricCryptoKey CreateCryptoKey(int32 InExpectKeySizeByte)
	{
		InExpectKeySizeByte = FMath::Max(InExpectKeySizeByte, 4);
		const int32 AlignedSize = Align(InExpectKeySizeByte, 4);
		TArray<uint8> Key, IV;
		Key.SetNumUninitialized(AlignedSize);
		IV.SetNumUninitialized(AlignedSize);
		CryptoPP::AutoSeededRandomPool Rng;
		Rng.GenerateBlock(Key.GetData(), Key.Num());
		Rng.GenerateBlock(IV.GetData(), IV.Num());
		return FSymmetricCryptoKey(Key, IV);
	}
}
