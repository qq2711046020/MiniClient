#pragma once

#include "Modules/ModuleManager.h"
#include "AsymmetricCrypto.h"
#include "SymmetricCrypto.h"

class CRYPTOGRAPHY_API FCryptography : public IModuleInterface
{
public:
	static FAsymmetricKeyPair CreateAsymmetricKeyPair(EAsymmetricCrypto InCrypto, int32 InExpectKeySizeByte);
	static TSharedPtr<FAsymmetricEncryption> CreateEncryption(EAsymmetricCrypto InCrypto, const FAsymmetricPublicKey & InPublicKey);
	static TSharedPtr<FAsymmetricDecryption> CreateDecryption(EAsymmetricCrypto InCrypto, const FAsymmetricPrivateKey & InPrivateKey);

	static FSymmetricCryptoKey CreateSymmetricCryptoKey(ESymmetricCrypto InCrypto, int32 InExpectKeySizeByte);
	static TSharedPtr<FSymmetricEncryption> CreateEncryption(ESymmetricCrypto InCrypto, const FSymmetricCryptoKey & InCryptoKey);
	static TSharedPtr<FSymmetricDecryption> CreateDecryption(ESymmetricCrypto InCrypto, const FSymmetricCryptoKey & InCryptoKey);

	static bool TestAsymmetricCrypto(EAsymmetricCrypto InCrypto);
	static bool TestSymmetricCrypto(ESymmetricCrypto InCrypto);
};
