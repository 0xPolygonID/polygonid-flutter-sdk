# $ANDROID_NDK_HOME is already set and pointing to the Android NDK folder

# ENV
AARCH64_LINKER=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android26-clang
ARMV7_LINKER=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/armv7a-linux-androideabi26-clang
I686_LINKER=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/i686-linux-android26-clang

# Build
CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER=$AARCH64_LINKER cargo build - target aarch64-linux-android - release
CARGO_TARGET_ARMV7_LINUX_ANDROIDEABI_LINKER=$ARMV7_LINKER cargo build - target armv7-linux-androideabi - release
CARGO_TARGET_I686_LINUX_ANDROID_LINKER=$I686_LINKER cargo build - target i686-linux-android - release
