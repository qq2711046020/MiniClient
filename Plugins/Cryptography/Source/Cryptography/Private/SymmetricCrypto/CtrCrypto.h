
#pragma once

#include "SymmetricCrypto.h"

THIRD_PARTY_INCLUDES_START
#include "osrng.h"
#include "modes.h"
THIRD_PARTY_INCLUDES_END

template<typename InCipher>
class TCtrEncryption final : public FSymmetricEncryption
{
public:
	explicit TCtrEncryption(const FSymmetricCryptoKey& InCryptoKey)
	{
		check(InCryptoKey.IsValid())
		_Encryption = MakeUnique<typename CryptoPP::CTR_Mode<InCipher>::Encryption>();
		_Encryption->SetKeyWithIV(InCryptoKey.GetKey().GetData(), InCryptoKey.GetKey().Num(), InCryptoKey.GetIV().GetData(), InCryptoKey.GetIV().Num());
	}
	~TCtrEncryption() = default;
	TCtrEncryption(const TCtrEncryption&) = delete;
	TCtrEncryption(TCtrEncryption&&) = delete;
	TCtrEncryption& operator=(const TCtrEncryption&) = delete;
	TCtrEncryption& operator=(TCtrEncryption&&) = delete;

	bool EncryptData(const TArray<uint8>& InData, TArray<uint8>& OutData) override
	{
		OutData = InData;
		try
		{
			_Encryption->ProcessData(OutData.GetData(), OutData.GetData(), OutData.Num());
		}
		catch (CryptoPP::Exception const& e)
		{
			UE_LOG(Cryptography, Error, TEXT("CTR Encrypt Exception: %s"), UTF8_TO_TCHAR(e.what()));
			return false;
		}
		return true;
	}

private:
	TUniquePtr<typename CryptoPP::CTR_Mode<InCipher>::Encryption> _Encryption;
};

template<typename InCipher>
class TCtrDecryption final : public FSymmetricDecryption
{
public:
	explicit TCtrDecryption(const FSymmetricCryptoKey& InCryptoKey)
	{
		check(InCryptoKey.IsValid())
		_Decryption = MakeUnique<typename CryptoPP::CTR_Mode<InCipher>::Decryption>();
		_Decryption->SetKeyWithIV(InCryptoKey.GetKey().GetData(), InCryptoKey.GetKey().Num(), InCryptoKey.GetIV().GetData(), InCryptoKey.GetIV().Num());
	}
	~TCtrDecryption() = default;
	TCtrDecryption(const TCtrDecryption&) = delete;
	TCtrDecryption(TCtrDecryption&&) = delete;
	TCtrDecryption& operator=(const TCtrDecryption&) = delete;
	TCtrDecryption& operator=(TCtrDecryption&&) = delete;

	bool DecryptData(const TArray<uint8>& InData, TArray<uint8>& OutData) override
	{
		OutData = InData;
		try
		{
			_Decryption->ProcessData(OutData.GetData(), OutData.GetData(), OutData.Num());
		}
		catch (CryptoPP::Exception const& e)
		{
			UE_LOG(Cryptography, Error, TEXT("CTR Decrypt Exception: %s"), UTF8_TO_TCHAR(e.what()));
			return false;
		}
		return true;
	}

private:
	TUniquePtr<typename CryptoPP::CTR_Mode<InCipher>::Decryption> _Decryption;
};

template<typename InCipher>
class TCtrCrypto final
{
public:
	static FSymmetricCryptoKey CreateCryptoKey(int32 InExpectKeySizeByte)
	{
		typename CryptoPP::CTR_Mode<InCipher>::Encryption Encryption;
		TArray<uint8> Key, IV;
		Key.SetNumUninitialized(Encryption.GetValidKeyLength(InExpectKeySizeByte));
		IV.SetNumUninitialized(Encryption.IVSize());
		CryptoPP::AutoSeededRandomPool Rng;
		Rng.GenerateBlock(Key.GetData(), Key.Num());
		Rng.GenerateBlock(IV.GetData(), IV.Num());
		return FSymmetricCryptoKey(Key, IV);
	}
};
