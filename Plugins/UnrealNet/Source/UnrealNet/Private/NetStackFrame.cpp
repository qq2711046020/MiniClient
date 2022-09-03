//#include "NetStackFrame.h"
//#include "UnrealNetPrivatePCH.h"
//#include "ByteOrder.h"
//
//FZipperStackFrame::FZipperStackFrame(const TArray<uint8> & InDict)
//{
//	_Compression = FZStandard::CreateCompression(InDict);
//	check(_Compression.IsValid())
//	_Decompression = FZStandard::CreateDecompression(InDict);
//	check(_Decompression.IsValid())
//}
//
//bool FZipperStackFrame::Encode(TArray<uint8> & InOutData)
//{
//	if (_Compression.IsValid())
//	{
//		TArray<uint8> CompressedData;
//		if (_Compression->Compress(InOutData, CompressedData))
//		{
//			TArray<uint8> OutData;
//			uint8 bCompressed = 0;
//			if (CompressedData.Num() < InOutData.Num())
//			{
//				bCompressed = 1;
//				OutData.Reset(1 + CompressedData.Num());
//				OutData.Append(&bCompressed, 1);
//				OutData.Append(CompressedData.GetData(), CompressedData.Num());
//			}
//			else
//			{
//				OutData.Reset(1 + InOutData.Num());
//				OutData.Append(&bCompressed, 1);
//				OutData.Append(InOutData.GetData(), InOutData.Num());
//			}
//			InOutData = MoveTemp(OutData);
//			return true;
//		}
//		UE_LOG(LogUnrealNet, Error, TEXT("Compression Compress error"));
//		return false;
//	}
//	TArray<uint8> OutData;
//	uint8 bCompressed = 0;
//	OutData.Reset(1 + InOutData.Num());
//	OutData.Append(&bCompressed, 1);
//	OutData.Append(InOutData.GetData(), InOutData.Num());
//	InOutData = MoveTemp(OutData);
//	return true;
//}
//
//bool FZipperStackFrame::Decode(TArray<uint8> & InOutData)
//{
//	if (InOutData.Num() > 0)
//	{
//		const uint8 bCompressed = InOutData[0];
//		if (bCompressed > 0)
//		{
//			if (_Decompression.IsValid())
//			{
//				const TArray<uint8> CompressedData(InOutData.GetData() + 1, InOutData.Num() - 1);
//				if (_Decompression->Decompress(CompressedData, InOutData))
//				{
//					return true;
//				}
//				UE_LOG(LogUnrealNet, Error, TEXT("Decompression Decompress error"));
//			}
//			else
//			{
//				UE_LOG(LogUnrealNet, Error, TEXT("Decompression is not available"));
//			}
//			return false;
//		}
//		TArray<uint8> OutData;
//		OutData.Reset(InOutData.Num() - 1);
//		OutData.Append(InOutData.GetData() + 1, InOutData.Num() - 1);
//		InOutData = MoveTemp(OutData);
//		return true;
//	}
//	UE_LOG(LogUnrealNet, Error, TEXT("FPublicHeaderStackFrame::Decode InOutData is empty"));
//	return false;
//}
//
//bool FPublicHeaderStackFrame::Encode(TArray<uint8> & InOutData)
//{
//	TArray<uint8> OutData;
//	OutData.Reset(8 + InOutData.Num());
//	OutData.AddZeroed(8);
//	OutData.Append(InOutData.GetData(), InOutData.Num());
//	FByteOrder::SetBE32(OutData.GetData() + 4, InOutData.Num());
//	const uint32 Crc32 = FCrc::MemCrc32(OutData.GetData() + 4, OutData.Num() - 4);
//	FByteOrder::SetBE32(OutData.GetData(), Crc32);
//	InOutData = MoveTemp(OutData);
//	return true;
//}
//
//bool FPublicHeaderStackFrame::Decode(TArray<uint8> & InOutData)
//{
//	if (InOutData.Num() < 8)
//	{
//		UE_LOG(LogUnrealNet, Error, TEXT("FPublicHeaderStackFrame::Decode InOutData length must be greater than 8 bytes"));
//		return false;
//	}
//	if (FByteOrder::GetBE32(InOutData.GetData()) != FCrc::MemCrc32(InOutData.GetData() + 4, InOutData.Num() - 4))
//	{
//		UE_LOG(LogUnrealNet, Error, TEXT("FPublicHeaderStackFrame::Decode CRC Mismatch"));
//		return false;
//	}
//	const uint32 PayloadLength = FByteOrder::GetBE32(InOutData.GetData() + 4);
//	if (InOutData.Num() != static_cast<int32>(PayloadLength + 8))
//	{
//		UE_LOG(LogUnrealNet, Error, TEXT("FPublicHeaderStackFrame::Decode InOutData length error"));
//		return false;
//	}
//	TArray<uint8> OutData;
//	OutData.Append(InOutData.GetData() + 8, PayloadLength);
//	InOutData = MoveTemp(OutData);
//	return true;
//}
//
//bool FPrivateHeaderStackFrame::Encode(TArray<uint8> & InOutData)
//{
//	TArray<uint8> OutData;
//	OutData.Reset(3 + InOutData.Num());
//	OutData.AddZeroed(3);
//	OutData.Append(InOutData.GetData(), InOutData.Num());
//	if (_bIncrease)
//	{
//		FByteOrder::SetBE16(OutData.GetData(), ++_WriteSerialNumber);
//	}
//	else
//	{
//		FByteOrder::SetBE16(OutData.GetData(), _WriteSerialNumber);
//	}
//	OutData[2] = _ProtocolVersion;
//	InOutData = MoveTemp(OutData);
//	return true;
//}
//
//bool FPrivateHeaderStackFrame::Decode(TArray<uint8> & InOutData)
//{
//	if (InOutData.Num() < 3)
//	{
//		UE_LOG(LogUnrealNet, Error, TEXT("FPrivateHeaderStackFrame::Decode InOutData length must be greater than 3 bytes"));
//		return false;
//	}
//	uint16 ExpectedReadSerialNumber = _ReadSerialNumber;
//	if (_bIncrease)
//	{
//		++ExpectedReadSerialNumber;
//	}
//	const uint16 ReceivedReadSerialNumber = FByteOrder::GetBE16(InOutData.GetData());
//	if (ExpectedReadSerialNumber != ReceivedReadSerialNumber)
//	{
//		UE_LOG(LogUnrealNet, Error, TEXT("FPrivateHeaderStackFrame::Decode ReadSerialNumber Mismatch, Expect %u Receive %u"), ExpectedReadSerialNumber, ReceivedReadSerialNumber);
//		return false;
//	}
//	const uint8 ReceivedProtocolVersion = InOutData[2];
//	if (_ProtocolVersion != ReceivedProtocolVersion)
//	{
//		UE_LOG(LogUnrealNet, Error, TEXT("FPrivateHeaderStackFrame::Decode ProtocolVersion Mismatch, Expect %u Receive %u"), _ProtocolVersion, ReceivedProtocolVersion);
//		return false;
//	}
//	_ReadSerialNumber = ExpectedReadSerialNumber;
//	TArray<uint8> OutData;
//	OutData.Append(InOutData.GetData() + 3, InOutData.Num() - 3);
//	InOutData = MoveTemp(OutData);
//	return true;
//}
//
//FSymmetricCryptoStackFrame::FSymmetricCryptoStackFrame(ESymmetricCrypto InCrypto, const FSymmetricCryptoKey & InCryptoKey)
//{
//	_Encryption = FCryptography::CreateEncryption(InCrypto, InCryptoKey);
//	check(_Encryption.IsValid())
//	_Decryption = FCryptography::CreateDecryption(InCrypto, InCryptoKey);
//	check(_Decryption.IsValid())
//}
//
//bool FSymmetricCryptoStackFrame::Encode(TArray<uint8> & InOutData)
//{
//	if (_Encryption.IsValid())
//	{
//		TArray<uint8> OutData;
//		if (_Encryption->EncryptData(InOutData, OutData))
//		{
//			InOutData = MoveTemp(OutData);
//			return true;
//		}
//		UE_LOG(LogUnrealNet, Error, TEXT("SymmetricEncryption EncryptData error"));
//	}
//	else
//	{
//		UE_LOG(LogUnrealNet, Error, TEXT("SymmetricEncryption is not available"));
//	}
//	return false;
//}
//
//bool FSymmetricCryptoStackFrame::Decode(TArray<uint8> & InOutData)
//{
//	if (_Decryption.IsValid())
//	{
//		TArray<uint8> OutData;
//		if (_Decryption->DecryptData(InOutData, OutData))
//		{
//			InOutData = MoveTemp(OutData);
//			return true;
//		}
//		UE_LOG(LogUnrealNet, Error, TEXT("SymmetricDecryption DecryptData error"));
//	}
//	else
//	{
//		UE_LOG(LogUnrealNet, Error, TEXT("SymmetricDecryption is not available"));
//	}
//	return false;
//}
//
//FAsymmetricCryptoStackFrame::FAsymmetricCryptoStackFrame(EAsymmetricCrypto InCrypto, const FAsymmetricPublicKey & InPublicKey)
//{
//	_Encryption = FCryptography::CreateEncryption(InCrypto, InPublicKey);
//	check(_Encryption.IsValid())
//}
//
//FAsymmetricCryptoStackFrame::FAsymmetricCryptoStackFrame(EAsymmetricCrypto InCrypto, const FAsymmetricPrivateKey & InPrivateKey)
//{
//	_Decryption = FCryptography::CreateDecryption(InCrypto, InPrivateKey);
//	check(_Decryption.IsValid())
//}
//
//FAsymmetricCryptoStackFrame::FAsymmetricCryptoStackFrame(EAsymmetricCrypto InCrypto, const FAsymmetricPublicKey & InPublicKey, const FAsymmetricPrivateKey & InPrivateKey)
//{
//	_Encryption = FCryptography::CreateEncryption(InCrypto, InPublicKey);
//	check(_Encryption.IsValid())
//	_Decryption = FCryptography::CreateDecryption(InCrypto, InPrivateKey);
//	check(_Decryption.IsValid())
//}
//
//bool FAsymmetricCryptoStackFrame::Encode(TArray<uint8> & InOutData)
//{
//	if (_Encryption.IsValid())
//	{
//		TArray<uint8> OutData;
//		if (_Encryption->EncryptData(InOutData, OutData))
//		{
//			InOutData = MoveTemp(OutData);
//			return true;
//		}
//		UE_LOG(LogUnrealNet, Error, TEXT("AsymmetricEncryption EncryptData error"));
//	}
//	else
//	{
//		UE_LOG(LogUnrealNet, Error, TEXT("AsymmetricEncryption is not available"));
//	}
//	return false;
//}
//
//bool FAsymmetricCryptoStackFrame::Decode(TArray<uint8> & InOutData)
//{
//	if (_Decryption.IsValid())
//	{
//		TArray<uint8> OutData;
//		if (_Decryption->DecryptData(InOutData, OutData))
//		{
//			InOutData = MoveTemp(OutData);
//			return true;
//		}
//		UE_LOG(LogUnrealNet, Error, TEXT("AsymmetricDecryption DecryptData error"));
//	}
//	else
//	{
//		UE_LOG(LogUnrealNet, Error, TEXT("AsymmetricDecryption is not available"));
//	}
//	return false;
//}
