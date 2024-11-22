#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <target src>"
    exit 1
fi

TARGET_SRC=$1
TARGET_NAME=$(basename "$TARGET_SRC" .rs)

export LD_LIBRARY_PATH=/root/.rustup/toolchains/1.70-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/lib:$LD_LIBRARY_PATH

rustc --emit=llvm-bc $TARGET_SRC

./cbi ${TARGET_NAME}.bc

./fuzz/afl-clang-fast ${TARGET_NAME}.ci.bc -o ${TARGET_NAME}.ci -L/root/.rustup/toolchains/1.70-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/lib -lstd-8389830094602f5a
