
#pragma once
#include "CoreMinimal.h"

class FByteOrder final
{
public:
	static void Set8(void* memory, uint32 offset, uint8 v)
	{
		static_cast<uint8*>(memory)[offset] = v;
	}

	static uint8 Get8(const void* memory, uint32 offset)
	{
		return static_cast<const uint8*>(memory)[offset];
	}

	static void SetBE16(void* memory, uint16 v)
	{
		Set8(memory, 0, static_cast<uint8>(v >> 8));
		Set8(memory, 1, static_cast<uint8>(v >> 0));
	}

	static void SetBE32(void* memory, uint32 v)
	{
		Set8(memory, 0, static_cast<uint8>(v >> 24));
		Set8(memory, 1, static_cast<uint8>(v >> 16));
		Set8(memory, 2, static_cast<uint8>(v >> 8));
		Set8(memory, 3, static_cast<uint8>(v >> 0));
	}

	static void SetBE64(void* memory, uint64 v)
	{
		Set8(memory, 0, static_cast<uint8>(v >> 56));
		Set8(memory, 1, static_cast<uint8>(v >> 48));
		Set8(memory, 2, static_cast<uint8>(v >> 40));
		Set8(memory, 3, static_cast<uint8>(v >> 32));
		Set8(memory, 4, static_cast<uint8>(v >> 24));
		Set8(memory, 5, static_cast<uint8>(v >> 16));
		Set8(memory, 6, static_cast<uint8>(v >> 8));
		Set8(memory, 7, static_cast<uint8>(v >> 0));
	}

	static uint16 GetBE16(const void* memory)
	{
		return static_cast<uint16>((Get8(memory, 0) << 8) | (Get8(memory, 1) << 0));
	}

	static uint32 GetBE32(const void* memory)
	{
		return (static_cast<uint32>(Get8(memory, 0)) << 24) |
			(static_cast<uint32>(Get8(memory, 1)) << 16) |
			(static_cast<uint32>(Get8(memory, 2)) << 8) |
			(static_cast<uint32>(Get8(memory, 3)) << 0);
	}

	static uint64 GetBE64(const void* memory)
	{
		return (static_cast<uint64>(Get8(memory, 0)) << 56) |
			(static_cast<uint64>(Get8(memory, 1)) << 48) |
			(static_cast<uint64>(Get8(memory, 2)) << 40) |
			(static_cast<uint64>(Get8(memory, 3)) << 32) |
			(static_cast<uint64>(Get8(memory, 4)) << 24) |
			(static_cast<uint64>(Get8(memory, 5)) << 16) |
			(static_cast<uint64>(Get8(memory, 6)) << 8) |
			(static_cast<uint64>(Get8(memory, 7)) << 0);
	}

	static void SetLE16(void* memory, uint16 v)
	{
		Set8(memory, 0, static_cast<uint8>(v >> 0));
		Set8(memory, 1, static_cast<uint8>(v >> 8));
	}

	static void SetLE32(void* memory, uint32 v)
	{
		Set8(memory, 0, static_cast<uint8>(v >> 0));
		Set8(memory, 1, static_cast<uint8>(v >> 8));
		Set8(memory, 2, static_cast<uint8>(v >> 16));
		Set8(memory, 3, static_cast<uint8>(v >> 24));
	}

	static void SetLE64(void* memory, uint64 v)
	{
		Set8(memory, 0, static_cast<uint8>(v >> 0));
		Set8(memory, 1, static_cast<uint8>(v >> 8));
		Set8(memory, 2, static_cast<uint8>(v >> 16));
		Set8(memory, 3, static_cast<uint8>(v >> 24));
		Set8(memory, 4, static_cast<uint8>(v >> 32));
		Set8(memory, 5, static_cast<uint8>(v >> 40));
		Set8(memory, 6, static_cast<uint8>(v >> 48));
		Set8(memory, 7, static_cast<uint8>(v >> 56));
	}

	static uint16 GetLE16(const void* memory)
	{
		return static_cast<uint16>((Get8(memory, 0) << 0) | (Get8(memory, 1) << 8));
	}

	static uint32 GetLE32(const void* memory)
	{
		return (static_cast<uint32>(Get8(memory, 0)) << 0) |
			(static_cast<uint32>(Get8(memory, 1)) << 8) |
			(static_cast<uint32>(Get8(memory, 2)) << 16) |
			(static_cast<uint32>(Get8(memory, 3)) << 24);
	}

	static uint64 GetLE64(const void* memory)
	{
		return (static_cast<uint64>(Get8(memory, 0)) << 0) |
			(static_cast<uint64>(Get8(memory, 1)) << 8) |
			(static_cast<uint64>(Get8(memory, 2)) << 16) |
			(static_cast<uint64>(Get8(memory, 3)) << 24) |
			(static_cast<uint64>(Get8(memory, 4)) << 32) |
			(static_cast<uint64>(Get8(memory, 5)) << 40) |
			(static_cast<uint64>(Get8(memory, 6)) << 48) |
			(static_cast<uint64>(Get8(memory, 7)) << 56);
	}

	// Check if the current host is big endian.
	static bool IsHostBigEndian()
	{
		const uint32 number = 1;
		return 0 == *reinterpret_cast<const uint8*>(&number);
	}

	static uint16 HostToNetwork16(uint16 n)
	{
		uint16 result;
		SetBE16(&result, n);
		return result;
	}

	static uint32 HostToNetwork32(uint32 n)
	{
		uint32 result;
		SetBE32(&result, n);
		return result;
	}

	static uint64 HostToNetwork64(uint64 n)
	{
		uint64 result;
		SetBE64(&result, n);
		return result;
	}

	static uint16 NetworkToHost16(uint16 n)
	{
		return GetBE16(&n);
	}

	static uint32 NetworkToHost32(uint32 n)
	{
		return GetBE32(&n);
	}

	static uint64 NetworkToHost64(uint64 n)
	{
		return GetBE64(&n);
	}
};
