//#pragma once
//
////#include "CoreMinimal.h"
//#include "Cryptography.h"
//#include "ZStandard.h"
//
//class INetStackFrame
//{
//public:
//	INetStackFrame() = default;
//	INetStackFrame(const INetStackFrame &) = delete;
//	INetStackFrame(INetStackFrame &&) = delete;
//	virtual ~INetStackFrame() = default;
//	INetStackFrame & operator=(const INetStackFrame &) = delete;
//	INetStackFrame & operator=(INetStackFrame &&) = delete;
//
//	virtual bool Encode(TArray<uint8> & InOutData) = 0;
//	virtual bool Decode(TArray<uint8> & InOutData) = 0;
//	virtual FString GetName() const = 0;
//};
//
//class FZipperStackFrame final : public INetStackFrame
//{
//public:
//	FZipperStackFrame(const TArray<uint8> & InDict);
//	FZipperStackFrame(const FZipperStackFrame &) = delete;
//	FZipperStackFrame(FZipperStackFrame &&) = delete;
//	~FZipperStackFrame() = default;
//	FZipperStackFrame & operator=(const FZipperStackFrame &) = delete;
//	FZipperStackFrame & operator=(FZipperStackFrame &&) = delete;
//
//	bool Encode(TArray<uint8> & InOutData) override;
//	bool Decode(TArray<uint8> & InOutData) override;
//	FString GetName() const override
//	{
//		return TEXT("FZipperStackFrame");
//	}
//
//private:
//	TSharedPtr<IZStdCompression> _Compression;
//	TSharedPtr<IZStdDecompression> _Decompression;
//};
//
//class FPublicHeaderStackFrame final : public INetStackFrame
//{
//public:
//	FPublicHeaderStackFrame() = default;
//	FPublicHeaderStackFrame(const FPublicHeaderStackFrame &) = delete;
//	FPublicHeaderStackFrame(FPublicHeaderStackFrame &&) = delete;
//	~FPublicHeaderStackFrame() = default;
//	FPublicHeaderStackFrame & operator=(const FPublicHeaderStackFrame &) = delete;
//	FPublicHeaderStackFrame & operator=(FPublicHeaderStackFrame &&) = delete;
//
//	bool Encode(TArray<uint8> & InOutData) override;
//	bool Decode(TArray<uint8> & InOutData) override;
//	FString GetName() const override
//	{
//		return TEXT("FPublicHeaderStackFrame");
//	}
//};
//
//class FPrivateHeaderStackFrame final : public INetStackFrame
//{
//public:
//	FPrivateHeaderStackFrame(uint16 InReadSerialNumber, uint16 InWriteSerialNumber, bool bIncrease)
//	{
//		_ReadSerialNumber = InReadSerialNumber;
//		_WriteSerialNumber = InWriteSerialNumber;
//		_bIncrease = bIncrease;
//	}
//	FPrivateHeaderStackFrame(const FPrivateHeaderStackFrame &) = delete;
//	FPrivateHeaderStackFrame(FPrivateHeaderStackFrame &&) = delete;
//	~FPrivateHeaderStackFrame() = default;
//	FPrivateHeaderStackFrame & operator=(const FPrivateHeaderStackFrame &) = delete;
//	FPrivateHeaderStackFrame & operator=(FPrivateHeaderStackFrame &&) = delete;
//
//	bool Encode(TArray<uint8> & InOutData) override;
//	bool Decode(TArray<uint8> & InOutData) override;
//	FString GetName() const override
//	{
//		return TEXT("FPrivateHeaderStackFrame");
//	}
//
//private:
//	uint16 _ReadSerialNumber = 0;
//	uint16 _WriteSerialNumber = 0;
//	bool _bIncrease = false;
//	const uint8 _ProtocolVersion = 1;
//};
//
//class FSymmetricCryptoStackFrame final : public INetStackFrame
//{
//public:
//	FSymmetricCryptoStackFrame(ESymmetricCrypto InCrypto, const FSymmetricCryptoKey & InCryptoKey);
//	FSymmetricCryptoStackFrame(const FSymmetricCryptoStackFrame &) = delete;
//	FSymmetricCryptoStackFrame(FSymmetricCryptoStackFrame &&) = delete;
//	~FSymmetricCryptoStackFrame() = default;
//	FSymmetricCryptoStackFrame & operator=(const FSymmetricCryptoStackFrame &) = delete;
//	FSymmetricCryptoStackFrame & operator=(FSymmetricCryptoStackFrame &&) = delete;
//
//	bool Encode(TArray<uint8> & InOutData) override;
//	bool Decode(TArray<uint8> & InOutData) override;
//	FString GetName() const override
//	{
//		return TEXT("FSymmetricCryptoStackFrame");
//	}
//
//private:
//	TSharedPtr<FSymmetricEncryption> _Encryption;
//	TSharedPtr<FSymmetricDecryption> _Decryption;
//};
//
//class FAsymmetricCryptoStackFrame final : public INetStackFrame
//{
//public:
//	FAsymmetricCryptoStackFrame(EAsymmetricCrypto InCrypto, const FAsymmetricPublicKey & InPublicKey);
//	FAsymmetricCryptoStackFrame(EAsymmetricCrypto InCrypto, const FAsymmetricPrivateKey & InPrivateKey);
//	FAsymmetricCryptoStackFrame(EAsymmetricCrypto InCrypto, const FAsymmetricPublicKey & InPublicKey, const FAsymmetricPrivateKey & InPrivateKey);
//	FAsymmetricCryptoStackFrame(const FAsymmetricCryptoStackFrame &) = delete;
//	FAsymmetricCryptoStackFrame(FAsymmetricCryptoStackFrame &&) = delete;
//	~FAsymmetricCryptoStackFrame() = default;
//	FAsymmetricCryptoStackFrame & operator=(const FAsymmetricCryptoStackFrame &) = delete;
//	FAsymmetricCryptoStackFrame & operator=(FAsymmetricCryptoStackFrame &&) = delete;
//
//	bool Encode(TArray<uint8> & InOutData) override;
//	bool Decode(TArray<uint8> & InOutData) override;
//	FString GetName() const override
//	{
//		return TEXT("FAsymmetricCryptoStackFrame");
//	}
//
//private:
//	TSharedPtr<FAsymmetricEncryption> _Encryption;
//	TSharedPtr<FAsymmetricDecryption> _Decryption;
//};
