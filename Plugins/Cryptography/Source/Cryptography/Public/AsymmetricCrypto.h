#pragma once

#include "CoreMinimal.h"

enum class EAsymmetricCrypto : int8
{
	Invalid,
	RSA
};

class FAsymmetricPublicKey final
{
public:
	FAsymmetricPublicKey() = default;
	FAsymmetricPublicKey(const TArray<uint8>& InKey) noexcept
	{
		_Key = InKey;
	}
	void SetKey(const TArray<uint8>& InKey)
	{
		_Key = InKey;
	}
	const TArray<uint8>& GetKey() const
	{
		return _Key;
	}
	bool IsValid() const
	{
		return _Key.Num() > 0;
	}

private:
	TArray<uint8> _Key;
};

class FAsymmetricPrivateKey final
{
public:
	FAsymmetricPrivateKey() = default;
	FAsymmetricPrivateKey(const TArray<uint8>& InKey) noexcept
	{
		_Key = InKey;
	}
	void SetKey(const TArray<uint8>& InKey)
	{
		_Key = InKey;
	}
	const TArray<uint8>& GetKey() const
	{
		return _Key;
	}
	bool IsValid() const
	{
		return _Key.Num() > 0;
	}

private:
	TArray<uint8> _Key;
};

class FAsymmetricKeyPair final
{
public:
	FAsymmetricKeyPair() = default;
	FAsymmetricKeyPair(const FAsymmetricPublicKey& InPublicKey, const FAsymmetricPrivateKey& InPrivateKey) noexcept
	{
		_PublicKey = InPublicKey;
		_PrivateKey = InPrivateKey;
	}
	void SetPublicKey(const FAsymmetricPublicKey& InPublicKey)
	{
		_PublicKey = InPublicKey;
	}
	const FAsymmetricPublicKey& GetPublicKey() const
	{
		return _PublicKey;
	}
	void SetPrivateKey(const FAsymmetricPrivateKey& InPrivateKey)
	{
		_PrivateKey = InPrivateKey;
	}
	const FAsymmetricPrivateKey& GetPrivateKey() const
	{
		return _PrivateKey;
	}
	bool IsValid() const
	{
		return _PublicKey.IsValid() && _PrivateKey.IsValid();
	}

private:
	FAsymmetricPublicKey _PublicKey;
	FAsymmetricPrivateKey _PrivateKey;
};

class FAsymmetricEncryption
{
public:
	FAsymmetricEncryption() = default;
	virtual ~FAsymmetricEncryption() = default;
	FAsymmetricEncryption(const FAsymmetricEncryption&) = delete;
	FAsymmetricEncryption(FAsymmetricEncryption&&) = delete;
	FAsymmetricEncryption& operator=(const FAsymmetricEncryption&) = delete;
	FAsymmetricEncryption& operator=(FAsymmetricEncryption&&) = delete;

	virtual bool EncryptData(const TArray<uint8>& InData, TArray<uint8>& OutData) = 0;
};

class FAsymmetricDecryption
{
public:
	FAsymmetricDecryption() = default;
	virtual ~FAsymmetricDecryption() = default;
	FAsymmetricDecryption(const FAsymmetricDecryption&) = delete;
	FAsymmetricDecryption(FAsymmetricDecryption&&) = delete;
	FAsymmetricDecryption& operator=(const FAsymmetricDecryption&) = delete;
	FAsymmetricDecryption& operator=(FAsymmetricDecryption&&) = delete;

	virtual bool DecryptData(const TArray<uint8>& InData, TArray<uint8>& OutData) = 0;
};
