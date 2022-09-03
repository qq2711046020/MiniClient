// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "SymmetricCrypto.h"

THIRD_PARTY_INCLUDES_START
#include "chacha.h"
THIRD_PARTY_INCLUDES_END

FSymmetricCryptoKey GenChaCha20key();

class FChaCha20Encryption final : public FSymmetricEncryption
{
public:
	explicit FChaCha20Encryption(const FSymmetricCryptoKey& InCryptoKey)
	{
		check(InCryptoKey.IsValid())
			_Encryption.SetKeyWithIV(InCryptoKey.GetKey().GetData(), InCryptoKey.GetKey().Num(), InCryptoKey.GetIV().GetData(), InCryptoKey.GetIV().Num());
	}
	~FChaCha20Encryption() = default;
	FChaCha20Encryption(const FChaCha20Encryption&) = delete;
	FChaCha20Encryption(FChaCha20Encryption&&) = delete;
	FChaCha20Encryption& operator=(const FChaCha20Encryption&) = delete;
	FChaCha20Encryption& operator=(FChaCha20Encryption&&) = delete;

	bool EncryptData(const TArray<uint8>& InData, TArray<uint8>& OutData) override
	{
		OutData = InData;
		try
		{
			_Encryption.ProcessData(OutData.GetData(), OutData.GetData(), OutData.Num());
		}
		catch (CryptoPP::Exception const& e)
		{
			UE_LOG(Cryptography, Error, TEXT("ChaCha20 Encrypt Exception: %s"), UTF8_TO_TCHAR(e.what()));
			return false;
		}
		return true;
	}
private:
	CryptoPP::ChaCha::Encryption _Encryption;
};

class FChaCha20Decryption final : public FSymmetricDecryption
{
public:
	explicit FChaCha20Decryption(const FSymmetricCryptoKey& InCryptoKey)
	{
		check(InCryptoKey.IsValid())
		_Decryption.SetKeyWithIV(InCryptoKey.GetKey().GetData(), InCryptoKey.GetKey().Num(), InCryptoKey.GetIV().GetData(), InCryptoKey.GetIV().Num());
	}
	~FChaCha20Decryption() = default;
	FChaCha20Decryption(const FChaCha20Decryption&) = delete;
	FChaCha20Decryption(FChaCha20Decryption&&) = delete;
	FChaCha20Decryption& operator=(const FChaCha20Decryption&) = delete;
	FChaCha20Decryption& operator=(FChaCha20Decryption&&) = delete;

	bool DecryptData(const TArray<uint8>& InData, TArray<uint8>& OutData) override
	{
		OutData = InData;
		try
		{
			_Decryption.ProcessData(OutData.GetData(), OutData.GetData(), OutData.Num());
		}
		catch (CryptoPP::Exception const& e)
		{
			UE_LOG(Cryptography, Error, TEXT("ChaCha20 Decrypt Exception: %s"), UTF8_TO_TCHAR(e.what()));
			return false;
		}
		return true;
	}
private:
	CryptoPP::ChaCha::Decryption _Decryption;
};