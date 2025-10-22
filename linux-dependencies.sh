#!/bin/sh

set -eux
ARCH="$(uname -m)"
EXTRA_PACKAGES="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/get-debloated-pkgs.sh"

echo "Installing build dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
	base-devel \
	catch2 \
	ccache \
	clang \
	cmake \
	gamemode \
	git \
	glslang \
 	inetutils \
 	jq \
	libva \
 	libvdpau \
	libvpx \
 	lld \
	llvm \
	llvm-libs \
	nasm \
	ninja \
	numactl \
 	mold \
	patchelf \
	pulseaudio \
	pulseaudio-alsa \
	python-pip \
	qt6ct \
	qt6-tools \
	qt6-wayland \
 	sdl3 \
	strace \
	unzip \
	vulkan-headers \
 	vulkan-mesa-layers \
	wget \
 	wireless_tools \
  	xcb-util-cursor \
	xcb-util-image \
	xcb-util-renderutil \
	xcb-util-wm \
	xorg-server-xvfb \
	zip \
	zsync

if [ "$(uname -m)" = 'x86_64' ]; then
		pacman -Syu --noconfirm haskell-gnutls svt-av1

		# Pin Clang verison 20.1.8 for now
		wget -q --retry-connrefused --tries=30 https://archive.archlinux.org/packages/c/clang/clang-20.1.8-2-x86_64.pkg.tar.zst
		wget -q --retry-connrefused --tries=30 https://archive.archlinux.org/packages/l/llvm/llvm-20.1.8-1-x86_64.pkg.tar.zst
		wget -q --retry-connrefused --tries=30 https://archive.archlinux.org/packages/l/llvm-libs/llvm-libs-20.1.8-1-x86_64.pkg.tar.zst
		wget -q --retry-connrefused --tries=30 https://archive.archlinux.org/packages/l/lld/lld-20.1.8-1-x86_64.pkg.tar.zst
		sudo pacman -U --noconfirm ./*.pkg.tar.zst
		rm -f ./*.pkg.tar.zst
fi

wget --retry-connrefused --tries=30 "$EXTRA_PACKAGES" -O ./get-debloated-pkgs.sh
chmod +x ./get-debloated-pkgs.sh
./get-debloated-pkgs.sh --add-opengl --add-vulkan qt6-base-mini opus-mini libxml2-mini intel-media-driver-mini

echo "All done!"
echo "---------------------------------------------------------------"
