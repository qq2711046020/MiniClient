#pragma once

#include "AsymmetricCrypto.h"

THIRD_PARTY_INCLUDES_START
#include "rsa.h"
THIRD_PARTY_INCLUDES_END

class FRsaEncryption final: public FAsymmetricEncryption
{
public:
	explicit FRsaEncryption(const FAsymmetricPublicKey & InPublicKey);
	~FRsaEncryption() = default;
	FRsaEncryption(const FRsaEncryption&) = delete;
	FRsaEncryption(FRsaEncryption&&) = delete;
	FRsaEncryption& operator=(const FRsaEncryption&) = delete;
	FRsaEncryption& operator=(FRsaEncryption&&) = delete;

	bool EncryptData(const TArray<uint8>& InData, TArray<uint8>& OutData) override;

private:
	TUniquePtr<CryptoPP::RSAES_OAEP_SHA_Encryptor> _Encryption;
};

class FRsaDecryption final: public FAsymmetricDecryption
{
public:
	explicit FRsaDecryption(const FAsymmetricPrivateKey & InPrivateKey);
	~FRsaDecryption() = default;
	FRsaDecryption(const FRsaDecryption&) = delete;
	FRsaDecryption(FRsaDecryption&&) = delete;
	FRsaDecryption& operator=(const FRsaDecryption&) = delete;
	FRsaDecryption& operator=(FRsaDecryption&&) = delete;

	bool DecryptData(const TArray<uint8>& InData, TArray<uint8>& OutData) override;

private:
	TUniquePtr<CryptoPP::RSAES_OAEP_SHA_Decryptor> _Decryption;
};

namespace RsaCrypto
{
	FAsymmetricKeyPair CreateKeyPair(int32 InExpectKeySizeByte);
}
