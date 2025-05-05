#!/bin/bash

# Check if directory argument is provided
if [ $# -eq 0 ]; then
  echo "Error: Please provide a directory path as an argument"
  echo "Usage: $0 <directory_path>"
  exit 1
fi

# Set directory from first argument
INPUT_DIR="$1"
OUTPUT_DIR="$1/bin"
# Set executable name to the basename of the directory
EXECUTABLE_NAME=$(basename "$INPUT_DIR")
TMP_DIR=/tmp/buildx-output

mkdir -p $OUTPUT_DIR

dart compile exe $INPUT_DIR/lib/main.dart -o $OUTPUT_DIR/$EXECUTABLE_NAME-macos-arm64

# Build for linux/arm64, using INPUT_DIR as build context
docker buildx build --platform linux/arm64 \
  --build-arg EXECUTABLE_NAME=$EXECUTABLE_NAME \
  --file $(pwd)/Dockerfile \
  --output type=local,dest=$TMP_DIR $INPUT_DIR
cp $TMP_DIR/app/$EXECUTABLE_NAME $OUTPUT_DIR/$EXECUTABLE_NAME-linux-aarch64
rm -fr $TMP_DIR

# Build for linux/amd64, using INPUT_DIR as build context
docker buildx build --platform linux/amd64 \
  --build-arg EXECUTABLE_NAME=$EXECUTABLE_NAME \
  --file $(pwd)/Dockerfile \
  --output type=local,dest=$TMP_DIR $INPUT_DIR
cp $TMP_DIR/app/$EXECUTABLE_NAME $OUTPUT_DIR/$EXECUTABLE_NAME-linux-amd64
rm -fr $TMP_DIR

chmod +x $OUTPUT_DIR/*