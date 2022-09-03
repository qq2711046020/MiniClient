#include "Cryptography.h"
#include "CryptographyPrivatePCH.h"

THIRD_PARTY_INCLUDES_START
#include "aes.h"
#include "blowfish.h"
#include "twofish.h"
THIRD_PARTY_INCLUDES_END

#include "AsymmetricCrypto/RsaCrypto.h"
#include "SymmetricCrypto/CtrCrypto.h"
#include "SymmetricCrypto/XorCrypto.h"
#include "SymmetricCrypto/ChaCha20.h"

DEFINE_LOG_CATEGORY(Cryptography)
IMPLEMENT_MODULE(FCryptography, Cryptography)

FAsymmetricKeyPair FCryptography::CreateAsymmetricKeyPair(EAsymmetricCrypto InCrypto, int32 InExpectKeySizeByte)
{
	switch (InCrypto)
	{
		case EAsymmetricCrypto::RSA:
		    return RsaCrypto::CreateKeyPair(InExpectKeySizeByte);
		case EAsymmetricCrypto::Invalid:
		default:
			return FAsymmetricKeyPair();
	}
}

TSharedPtr<FAsymmetricEncryption> FCryptography::CreateEncryption(EAsymmetricCrypto InCrypto, const FAsymmetricPublicKey & InPublicKey)
{
	check(InPublicKey.IsValid())
	switch (InCrypto)
	{
		case EAsymmetricCrypto::RSA:
		    return MakeShared<FRsaEncryption>(InPublicKey);
		case EAsymmetricCrypto::Invalid:
		default:
			return TSharedPtr<FAsymmetricEncryption>();
	}
}

TSharedPtr<FAsymmetricDecryption> FCryptography::CreateDecryption(EAsymmetricCrypto InCrypto, const FAsymmetricPrivateKey & InPrivateKey)
{
	check(InPrivateKey.IsValid())
	switch (InCrypto)
	{
		case EAsymmetricCrypto::RSA:
		    return MakeShared<FRsaDecryption>(InPrivateKey);
		case EAsymmetricCrypto::Invalid:
		default:
			return TSharedPtr<FAsymmetricDecryption>();
	}
}

FSymmetricCryptoKey FCryptography::CreateSymmetricCryptoKey(ESymmetricCrypto InCrypto, int32 InExpectKeySizeByte)
{
	switch (InCrypto)
	{
	    case ESymmetricCrypto::AES:
		    return TCtrCrypto<CryptoPP::AES>::CreateCryptoKey(InExpectKeySizeByte);
		case ESymmetricCrypto::BlowFish:
		    return TCtrCrypto<CryptoPP::Blowfish>::CreateCryptoKey(InExpectKeySizeByte);
		case ESymmetricCrypto::TwoFish:
		    return TCtrCrypto<CryptoPP::Twofish>::CreateCryptoKey(InExpectKeySizeByte);
		case ESymmetricCrypto::XOR:
		    return XorCrypto::CreateCryptoKey(InExpectKeySizeByte);
		case ESymmetricCrypto::ChaCha20:
			return GenChaCha20key();
		case ESymmetricCrypto::Invalid:
		default:
			return FSymmetricCryptoKey();
	}
}

TSharedPtr<FSymmetricEncryption> FCryptography::CreateEncryption(ESymmetricCrypto InCrypto, const FSymmetricCryptoKey& InCryptoKey)
{
	check(InCryptoKey.IsValid())
	switch (InCrypto)
	{
	    case ESymmetricCrypto::AES:
		    return MakeShared<TCtrEncryption<CryptoPP::AES>>(InCryptoKey);
		case ESymmetricCrypto::BlowFish:
		    return MakeShared<TCtrEncryption<CryptoPP::Blowfish>>(InCryptoKey);
		case ESymmetricCrypto::TwoFish:
		    return MakeShared<TCtrEncryption<CryptoPP::Twofish>>(InCryptoKey);
		case ESymmetricCrypto::XOR:
		    return MakeShared<FXorEncryption>(InCryptoKey);
		case ESymmetricCrypto::ChaCha20:
			return MakeShared<FChaCha20Encryption>(InCryptoKey);
		case ESymmetricCrypto::Invalid:
		default:
			return TSharedPtr<FSymmetricEncryption>();
	}
}

TSharedPtr<FSymmetricDecryption> FCryptography::CreateDecryption(ESymmetricCrypto InCrypto, const FSymmetricCryptoKey& InCryptoKey)
{
	check(InCryptoKey.IsValid())
	switch (InCrypto)
	{
	    case ESymmetricCrypto::AES:
		    return MakeShared<TCtrDecryption<CryptoPP::AES>>(InCryptoKey);
		case ESymmetricCrypto::BlowFish:
		    return MakeShared<TCtrDecryption<CryptoPP::Blowfish>>(InCryptoKey);
		case ESymmetricCrypto::TwoFish:
		    return MakeShared<TCtrDecryption<CryptoPP::Twofish>>(InCryptoKey);
		case ESymmetricCrypto::XOR:
		    return MakeShared<FXorDecryption>(InCryptoKey);
		case ESymmetricCrypto::ChaCha20:
			return MakeShared<FChaCha20Decryption>(InCryptoKey);
		case ESymmetricCrypto::Invalid:
		default:
			return TSharedPtr<FSymmetricDecryption>();
	}
}

bool FCryptography::TestAsymmetricCrypto(EAsymmetricCrypto InCrypto)
{
	static TMap<EAsymmetricCrypto, FString> AsymmetricCryptoStringMap{
		{EAsymmetricCrypto::Invalid, TEXT("Invalid")},
		{EAsymmetricCrypto::RSA, TEXT("RSA")}
	};
	for (int32 PlainDataSize = 0; PlainDataSize < 8192; PlainDataSize += 72)
	{
		TArray<uint8> PlainData;
		for (int32 i = 0; i < PlainDataSize; ++i)
		{
			PlainData.Add(static_cast<uint8>(i % 256));
		}
		for (int32 j = 0; j < 512; j += 9)
		{
			FAsymmetricKeyPair KeyPair = CreateAsymmetricKeyPair(InCrypto, j);
			check(KeyPair.IsValid())
			TSharedPtr<FAsymmetricEncryption> Encryption = CreateEncryption(InCrypto, KeyPair.GetPublicKey());
			TSharedPtr<FAsymmetricDecryption> Decryption = CreateDecryption(InCrypto, KeyPair.GetPrivateKey());
			TArray<uint8> EncryptedData, DecryptedData;
			check(Encryption->EncryptData(PlainData, EncryptedData))
			check(Decryption->DecryptData(EncryptedData, DecryptedData))
			check(PlainData == DecryptedData)
			UE_LOG(Cryptography, Warning, TEXT("Finish %s Test, PlainData length %d, CipherData length %d, Ratio %f, PublicKey length %d, PrivateKey length %d"), *AsymmetricCryptoStringMap[InCrypto], PlainData.Num(), 
				EncryptedData.Num(), static_cast<float>(EncryptedData.Num()) / static_cast<float>(PlainData.Num()), KeyPair.GetPublicKey().GetKey().Num(), KeyPair.GetPrivateKey().GetKey().Num());
		}
	}
	return true;
}

bool FCryptography::TestSymmetricCrypto(ESymmetricCrypto InCrypto)
{
	static TMap<ESymmetricCrypto, FString> SymmetricCryptoStringMap{
		{ESymmetricCrypto::Invalid, TEXT("Invalid")},
		{ESymmetricCrypto::AES, TEXT("AES")},
		{ESymmetricCrypto::BlowFish, TEXT("BlowFish")},
		{ESymmetricCrypto::TwoFish, TEXT("TwoFish")},
		{ESymmetricCrypto::XOR, TEXT("XOR")},
	};
	for (int32 PlainDataSize = 0; PlainDataSize < 8192; PlainDataSize += 72)
	{
		TArray<uint8> PlainData;
		for (int32 i = 0; i < PlainDataSize; ++i)
		{
			PlainData.Add(static_cast<uint8>(i % 256));
		}
		for (int32 j = 0; j < 256; j += 9)
		{
			FSymmetricCryptoKey CryptoKey = CreateSymmetricCryptoKey(InCrypto, j);
			check(CryptoKey.IsValid())
			TSharedPtr<FSymmetricEncryption> Encryption = CreateEncryption(InCrypto, CryptoKey);
			TSharedPtr<FSymmetricDecryption> Decryption = CreateDecryption(InCrypto, CryptoKey);
			TArray<uint8> EncryptedData, DecryptedData;
			check(Encryption->EncryptData(PlainData, EncryptedData))
			check(EncryptedData.Num() == PlainData.Num())
			check(Decryption->DecryptData(EncryptedData, DecryptedData))
			check(PlainData == DecryptedData)
			UE_LOG(Cryptography, Warning, TEXT("Finish %s Test, PlainData length %d, ExpectKeySizeByte %d, CreatedKeySizeByte %d, CreatedIVSizeByte %d"), *SymmetricCryptoStringMap[InCrypto], PlainData.Num(), j, CryptoKey.GetKey().Num(), CryptoKey.GetIV().Num());
		}
	}
	return true;
}
