#!/bin/bash
mkdir -p build

rm -f build/*.log

do_build() {
    local i="$1"
    shift
    "${cmake_cmd[@]}" -S . --trace-expand --preset $i >build/config.$i.log 2>&1 && \
        cmake --build build/$i -j$(nproc) "$@" >build/build.$i.log 2>&1
}

cmake_cmd=( cmake )

#do_build x86_64-windows-vs2022 --config Debug
do_build aarch64-linux-gnu
do_build x86_64-linux-gnu
do_build x86_64-linux-gnu-dawn
do_build x86_64-w64-mingw32

cmake_cmd=( emcmake cmake -DCMAKE_BUILD_TYPE=Debug )
do_build wasm32-unknown-emscripten
