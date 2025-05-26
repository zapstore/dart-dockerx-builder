# dart-dockerx-builder

## DEPRECATED!

Fortunately as of Dart 3.8 it's possible to do cross-compilation!

```bash
dart compile exe --target-os=linux --target-arch=arm64
```

----

Give `build.sh` an argument with the Dart project folder and it will output executables for `darwin-arm64`, `linux-amd64` and `linux-aarch64`.

Assumes host is MacOS, and `docker` with `dockerx` plugin and `colima` are installed. I do not use Docker Desktop.

```bash
brew install docker
brew install colima
colima start
curl -LO https://github.com/docker/buildx/releases/download/v0.17.1/buildx-v0.17.1.darwin-arm64
chmod +x buildx-v0.17.1.darwin-arm64
sudo mv buildx-v0.17.1.darwin-arm64 /usr/local/bin/docker-buildx
/usr/local/bin/docker-buildx version
mkdir -p ~/.docker/cli-plugins
ln -s /usr/local/bin/docker-buildx ~/.docker/cli-plugins/docker-buildx
docker buildx version
docker context use colima
```

# License

Public domain.