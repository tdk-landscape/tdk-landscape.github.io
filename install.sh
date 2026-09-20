#!/usr/bin/env sh
set -eu

OWNER="tdk-landscape"
REPO="tdk-cli-releases"
BIN_NAME="tdk"

fail() {
  echo "tdk install: $*" >&2
  exit 1
}

need() {
  command -v "$1" >/dev/null 2>&1 || fail "missing required command: $1"
}

need curl
need uname
need chmod
need mkdir
need tar

os="$(uname -s | tr '[:upper:]' '[:lower:]')"
arch="$(uname -m)"

case "$os" in
  linux) platform="linux" ;;
  darwin) platform="darwin" ;;
  *) fail "unsupported OS: $os" ;;
esac

case "$arch" in
  x86_64|amd64) cpu="amd64" ;;
  arm64|aarch64) cpu="arm64" ;;
  *) fail "unsupported CPU: $arch" ;;
esac

asset="tdk-${platform}-${cpu}"
url="https://github.com/${OWNER}/${REPO}/releases/latest/download/${asset}"

# Fixed filename (no version in it), so this always resolves to whatever
# release is currently "latest" - unlike the per-release zip, which is
# named with its own tag and can't be found this way.
engine_asset="tdk-cli-engine.tar.gz"
engine_url="https://github.com/${OWNER}/${REPO}/releases/latest/download/${engine_asset}"

install_dir="${TDK_INSTALL_DIR:-/usr/local/bin}"
tmp="${TMPDIR:-/tmp}/tdk.$$"
engine_tmp="${TMPDIR:-/tmp}/tdk-engine.$$.tar.gz"

download() {
  src="$1"
  dest="$2"
  n=0
  while [ "$n" -lt 8 ]; do
    if curl -fsSL "$src" -o "$dest"; then
      return 0
    fi
    n=$((n + 1))
    sleep $((n * 2))
  done
  return 1
}

echo "Installing ${asset}..."
download "$url" "$tmp" || fail "download failed: $url"
chmod +x "$tmp"

# The compiled binary has no source checkout to find engine/ in, so it
# looks for a tdk-cli/ folder next to itself (see
# cli/src/generator/template-engine.ts, vendorTdkExtension). Without this,
# `tdk project`/`tdk up` fail with "TDK extension not found".
echo "Installing bundled engine..."
download "$engine_url" "$engine_tmp" || fail "download failed: $engine_url"

if [ -w "$install_dir" ]; then
  mkdir -p "$install_dir"
  mv "$tmp" "${install_dir}/${BIN_NAME}"
  rm -rf "${install_dir}/tdk-cli"
  mkdir -p "${install_dir}/tdk-cli"
  tar -xzf "$engine_tmp" -C "${install_dir}/tdk-cli" --strip-components=1
else
  need sudo
  sudo mkdir -p "$install_dir"
  sudo mv "$tmp" "${install_dir}/${BIN_NAME}"
  sudo rm -rf "${install_dir}/tdk-cli"
  sudo mkdir -p "${install_dir}/tdk-cli"
  sudo tar -xzf "$engine_tmp" -C "${install_dir}/tdk-cli" --strip-components=1
fi
rm -f "$engine_tmp"

echo "Installed: ${install_dir}/${BIN_NAME}"
"${install_dir}/${BIN_NAME}" --version || true

