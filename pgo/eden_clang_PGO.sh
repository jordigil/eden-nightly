#!/bin/bash

cd eden

cmake --fresh -G Ninja -S . -B build \
-DYUZU_USE_BUNDLED_QT=OFF \
-DYUZU_USE_BUNDLED_FFMPEG=ON \
-DYUZU_USE_BUNDLED_SIRIT=ON \
-DYUZU_SYSTEM_PROFILE=steamdeck \
-DYUZU_USE_EXTERNAL_SDL2=ON \
-DYUZU_USE_CPM=ON \
-DYUZU_USE_FASTER_LD=OFF \
-DBUILD_TESTING=OFF \
-DYUZU_TESTS=OFF \
-DDYNARMIC_TESTS=OFF \
-DYUZU_CMD=OFF \
-DYUZU_ROOM=ON \
-DYUZU_ROOM_STANDALONE=OFF \
-DUSE_DISCORD_PRESENCE=ON \
-DENABLE_QT_TRANSLATION=ON \
-DENABLE_UPDATE_CHECKER=ON \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_C_COMPILER=clang \
-DCMAKE_CXX_COMPILER=clang++ \
-DCMAKE_CXX_FLAGS="-march=znver2 -mtune=znver2 -Ofast -pipe -fuse-ld=lld -fprofile-generate -w" \
-DCMAKE_C_FLAGS="-march=znver2 -mtune=znver2 -Ofast -pipe -fuse-ld=lld -fprofile-generate -w" \
-DCMAKE_EXE_LINKER_FLAGS="-Wl,--as-needed" \
-DCMAKE_SYSTEM_PROCESSOR=x86_64
cmake --build build --parallel $(nproc)

# workload run
cd build
LLVM_PROFILE_FILE="eden-%p.profraw" ./bin/eden
llvm-profdata merge --output="eden.profdata" eden-*.profraw

# Delete the build folders for building cleanly next time
cd $HOME/eden
sudo rm -rf ./build

