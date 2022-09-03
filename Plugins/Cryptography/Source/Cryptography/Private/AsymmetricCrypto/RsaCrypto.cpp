#include "AsymmetricCrypto/RsaCrypto.h"
#include "CryptographyPrivatePCH.h"

THIRD_PARTY_INCLUDES_START
#include "osrng.h"
#include "hex.h"
THIRD_PARTY_INCLUDES_END

FRsaEncryption::FRsaEncryption(const FAsymmetricPublicKey & InPublicKey)
{
	check(InPublicKey.IsValid())
	const TArray<uint8> & KeyArray = InPublicKey.GetKey();
	CryptoPP::ArraySource KeySource(KeyArray.GetData(), KeyArray.Num(), true, new CryptoPP::HexDecoder);
	_Encryption = MakeUnique<CryptoPP::RSAES_OAEP_SHA_Encryptor>(KeySource);
}

bool FRsaEncryption::EncryptData(const TArray<uint8>& InData, TArray<uint8>& OutData)
{
	auto const FixedMaxPlainDataLength = static_cast<int32>(_Encryption->FixedMaxPlaintextLength());
	auto const FixedCipherDataLength = static_cast<int32>(_Encryption->FixedCiphertextLength());
	CryptoPP::AutoSeededRandomPool Rng;
	OutData.Reset();
	bool Out = true;
	for (int32 i = 0; i < InData.Num(); i += FixedMaxPlainDataLength)
	{
		const uint8* PlainDataPtr = InData.GetData() + i;
		const size_t PlainDataLength = FMath::Min(InData.Num() - i, FixedMaxPlainDataLength);
		TArray<uint8> CipherData;
		CipherData.AddUninitialized(FixedCipherDataLength);
		try
		{
			_Encryption->Encrypt(Rng, PlainDataPtr, PlainDataLength, CipherData.GetData());
		}
		catch (CryptoPP::Exception const& e)
		{
			UE_LOG(Cryptography, Error, TEXT("RSA Encrypt Exception: %s"), UTF8_TO_TCHAR(e.what()));
			Out = false;
			break;
		}
		OutData.Append(CipherData);
	}
	return Out;
}

FRsaDecryption::FRsaDecryption(const FAsymmetricPrivateKey & InPrivateKey)
{
	check(InPrivateKey.IsValid())
	const TArray<uint8> & KeyArray = InPrivateKey.GetKey();
	CryptoPP::ArraySource KeySource(KeyArray.GetData(), KeyArray.Num(), true);
	_Decryption = MakeUnique<CryptoPP::RSAES_OAEP_SHA_Decryptor>(KeySource);
}

bool FRsaDecryption::DecryptData(const TArray<uint8>& InData, TArray<uint8>& OutData)
{
	auto const FixedCipherDataLength = static_cast<int32>(_Decryption->FixedCiphertextLength());
	if ((InData.Num() % FixedCipherDataLength) != 0)
	{
		UE_LOG(Cryptography, Error, TEXT("Expect integral multiple RSA FixedCiphertextLength %d, receive %d"), FixedCipherDataLength, InData.Num());
		return false;
	}

	auto const FixedMaxPlainDataLength = static_cast<int32>(_Decryption->FixedMaxPlaintextLength());
	CryptoPP::AutoSeededRandomPool Rng;
	OutData.Reset();
	bool Out = false;
	for (int32 i = 0; i < InData.Num(); i += FixedCipherDataLength)
	{
		const uint8* CipherDataPtr = InData.GetData() + i;
		TArray<uint8> PlainData;
		PlainData.AddUninitialized(FixedMaxPlainDataLength);
		CryptoPP::DecodingResult Result;
		try
		{
			Result = _Decryption->Decrypt(Rng, CipherDataPtr, FixedCipherDataLength, PlainData.GetData());
		}
		catch (CryptoPP::Exception const & e)
		{
			UE_LOG(Cryptography, Error, TEXT("RSA Decrypt Exception: %s"), UTF8_TO_TCHAR(e.what()));
			break;
		}
		Out = Result.isValidCoding;
		if (Out)
		{
			OutData.Append(PlainData.GetData(), static_cast<int32>(Result.messageLength));
		}
		else
		{
			UE_LOG(Cryptography, Error, TEXT("RSA Decrypt error"));
			break;
		}
	}
	return Out;
}

namespace RsaCrypto
{
	FAsymmetricKeyPair CreateKeyPair(int32 InExpectKeySizeByte)
	{
		InExpectKeySizeByte = FMath::Max(InExpectKeySizeByte, 64);
		const int32 AlignedSize = Align(InExpectKeySizeByte, 4);
		CryptoPP::AutoSeededRandomPool Rng;
		CryptoPP::InvertibleRSAFunction Params;
		Params.GenerateRandomWithKeySize(Rng, AlignedSize * 8);

		const CryptoPP::RSA::PublicKey RsaPublicKey(Params);
		std::string PublicKeyString;
		CryptoPP::StringSink PublicKeySink(PublicKeyString);
		RsaPublicKey.Save(PublicKeySink);
		const TArray<uint8> PublicKeyArray(const_cast<uint8*>(reinterpret_cast<const uint8*>(PublicKeyString.data())), PublicKeyString.size());
		const FAsymmetricPublicKey PublicKey(PublicKeyArray);

		const CryptoPP::RSA::PrivateKey RsaPrivateKey(Params);
		std::string PrivateKeyString;
		CryptoPP::StringSink PrivateKeySink(PrivateKeyString);
		RsaPrivateKey.Save(PrivateKeySink);
		const TArray<uint8> PrivateKeyArray(const_cast<uint8*>(reinterpret_cast<const uint8*>(PrivateKeyString.data())), PrivateKeyString.size());
		const FAsymmetricPrivateKey PrivateKey(PrivateKeyArray);

		return FAsymmetricKeyPair(PublicKey, PrivateKey);
	}
}
