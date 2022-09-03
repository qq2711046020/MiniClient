#pragma once

#include "CoreMinimal.h"

enum class ESymmetricCrypto : int8
{
	Invalid,
	AES,
	BlowFish,
	TwoFish,
	XOR,
	ChaCha20
};

class FSymmetricCryptoKey final
{
public:
	FSymmetricCryptoKey() = default;
	FSymmetricCryptoKey(const TArray<uint8>& InKey, const TArray<uint8>& InIV) noexcept
	{
		_Key = InKey;
		_IV = InIV;
	}
	void SetKey(const TArray<uint8>& InKey)
	{
		_Key = InKey;
	}
	const TArray<uint8>& GetKey() const
	{
		return _Key;
	}
	void SetIV(const TArray<uint8>& InIV)
	{
		_IV = InIV;
	}
	const TArray<uint8>& GetIV() const
	{
		return _IV;
	}
	bool IsValid() const
	{
		return _Key.Num() > 0 && _IV.Num() > 0;
	}
private:
	TArray<uint8> _Key;
	TArray<uint8> _IV;
};

class FSymmetricEncryption
{
public:
	FSymmetricEncryption() = default;
	virtual ~FSymmetricEncryption() = default;
	FSymmetricEncryption(const FSymmetricEncryption&) = delete;
	FSymmetricEncryption(FSymmetricEncryption&&) = delete;
	FSymmetricEncryption& operator=(const FSymmetricEncryption&) = delete;
	FSymmetricEncryption& operator=(FSymmetricEncryption&&) = delete;

	virtual bool EncryptData(const TArray<uint8>& InData, TArray<uint8>& OutData) = 0;
};

class FSymmetricDecryption
{
public:
	FSymmetricDecryption() = default;
	virtual ~FSymmetricDecryption() = default;
	FSymmetricDecryption(const FSymmetricDecryption&) = delete;
	FSymmetricDecryption(FSymmetricDecryption&&) = delete;
	FSymmetricDecryption& operator=(const FSymmetricDecryption&) = delete;
	FSymmetricDecryption& operator=(FSymmetricDecryption&&) = delete;

	virtual bool DecryptData(const TArray<uint8>& InData, TArray<uint8>& OutData) = 0;
};
