#!/usr/bin/env bash

export ANDROID_NDK_ROOT=E:/UE_ENV/Android/ndk/21.1.6352462
export ANDROID_SDK_ROOT=E:/UE_ENV/Android
export ANDROID_HOME=E:/UE_ENV/Android
export JAVA_HOME=E:\UE_ENV\Android\jdk

echo $ANDROID_NDK_ROOT
echo $ANDROID_SDK_ROOT
echo $ANDROID_HOME

export ANDROID_API="29"
if [ -d "$ANDROID_NDK_ROOT" ]; then
    export PATH="$PATH:$ANDROID_NDK_ROOT"
fi

if [ -d "$ANDROID_SDK_ROOT/tools/bin" ]; then
    export PATH="$PATH:$ANDROID_SDK_ROOT/tools/bin"
	echo "设置SDK环境变量$ANDROID_SDK_ROOT/tools/bin"
fi

if [ -d "$ANDROID_SDK_ROOT/platform-tools" ]; then
    export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
	echo "设置SDK环境变量$ANDROID_SDK_ROOT/platform-tools"
fi

if [ -d "$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/windows-x86_64/bin" ]; then
    export PATH="$PATH:$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/windows-x86_64/bin"
	echo "设置NDK/BIN环境变量$ANDROID_SDK_ROOT/platform-tools"
fi



#build lib "arm64-v8a" "x86" "x86_64" "armeabi-v7a"
for command_platform in "arm64-v8a" "x86" "x86_64" "armeabi-v7a"
do
	(
		ANDROID_API="$ANDROID_API" ANDROID_CPU="$command_platform" source ./testscripts/setenv-android.sh
		make -f gnumakefile-cross
		if [ ! -d ./Android/$command_platform ]; then
			mkdir -p Android/$command_platform
		fi
		cp -f libcryptopp.a Android/$command_platform
		make clean
	)
done