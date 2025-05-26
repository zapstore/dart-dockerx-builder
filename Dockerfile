FROM dart:stable AS builder

# Accept build argument for executable name (required, no default)
ARG EXECUTABLE_NAME

WORKDIR /app
# Copy from the build context (which will be the INPUT_DIR)
COPY . .
RUN dart pub get
RUN dart compile exe lib/main.dart -o ${EXECUTABLE_NAME}