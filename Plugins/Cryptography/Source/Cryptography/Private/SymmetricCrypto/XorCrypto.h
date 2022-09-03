
#pragma once

#include "SymmetricCrypto.h"

class FXorEncryption final : public FSymmetricEncryption
{
public:
	explicit FXorEncryption(const FSymmetricCryptoKey& InCryptoKey);
	~FXorEncryption() = default;
	FXorEncryption(const FXorEncryption&) = delete;
	FXorEncryption(FXorEncryption&&) = delete;
	FXorEncryption& operator=(const FXorEncryption&) = delete;
	FXorEncryption& operator=(FXorEncryption&&) = delete;

	bool EncryptData(const TArray<uint8>& InData, TArray<uint8>& OutData) override;

private:
	TArray<uint8> _Key;
};

class FXorDecryption final : public FSymmetricDecryption
{
public:
	explicit FXorDecryption(const FSymmetricCryptoKey& InCryptoKey);
	~FXorDecryption() = default;
	FXorDecryption(const FXorDecryption&) = delete;
	FXorDecryption(FXorDecryption&&) = delete;
	FXorDecryption& operator=(const FXorDecryption&) = delete;
	FXorDecryption& operator=(FXorDecryption&&) = delete;

	bool DecryptData(const TArray<uint8>& InData, TArray<uint8>& OutData) override;

private:
	TArray<uint8> _Key;
};

namespace XorCrypto
{
	FSymmetricCryptoKey CreateCryptoKey(int32 InExpectKeySizeByte);
}
