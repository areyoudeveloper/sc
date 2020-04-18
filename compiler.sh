
#! /usr/bin/env bash
export PATH=$PATH:~/bin/:/usr/bin
export DEBIAN_FRONTEND=noninteractive
export TZ=Asia/Jakarta
export ZIPNAME=GoGreen-Leaf
sudo ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sudo dpkg-reconfigure --frontend noninteractive tzdata

sudo apt-get install -y tzdata
sudo apt-get update -qq && \
    sudo apt-get upgrade -y && \
    sudo apt-get install --no-install-recommends -y \
	autoconf \
	autogen \
	automake \
	autotools-dev \
	bc \
	binutils \
	binutils-aarch64-linux-gnu \
	binutils-arm-linux-gnueabi \
	bison \
	bzip2 \
	ca-certificates \
	coreutils \
	cmake \
	curl \
	expect \
	flex \
	g++ \
	gawk \
	gcc \
	git \
	gnupg \
	gperf \
	help2man \
	lftp \
	libc6-dev \
	libelf-dev \
	libgomp1-* \
	liblz4-tool \
	libncurses5-dev \
	libssl-dev \
	libstdc++6 \
	libtool \
	libtool-bin \
	m4 \
	make \
	nano \
	openjdk-8-jdk \
	openssh-client \
	openssl \
	ovmf \
	patch \
	pigz \
	python3 \
	python \
	rsync \
	shtool \
	subversion \
	tar \
	texinfo \
	tzdata \
	u-boot-tools \
	unzip \
	wget \
	xz-utils \
	zip \
	zlib1g-dev \
	zstd

git clone https://github.com/areyoudeveloper/android_kernel_xiaomi_msm8917.git --depth 1
git clone https://github.com/areyoudeveloper/anykernel3-spectrum
git clone https://github.com/najahiiii/aarch64-linux-gnu.git -b linaro8-20190402

echo bulding!!

export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER=TEA
export CROSS_COMPILE=/home/runner/work/sssh/sssh/aarch64-linux-gnu/bin/aarch64-linux-gnu-
cd android_kernel_xiaomi_msm8917
make mrproper
mkdir -p out
make O=out rolex_defconfig
make O=out -j$(nproc --all) -l$(nproc --all) | tee /home/runner/log.txt

cp out/arch/arm64/boot/Image.gz-dtb ../anykernel3-spectrum
cd ../anykernel3-spectrum
zip -r9 ${ZIPNAME}.zip * -x build.sh

md5sum ${ZIPNAME}.zip
