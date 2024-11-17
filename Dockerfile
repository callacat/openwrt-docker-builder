# 使用Ubuntu 20.04作为基础镜像
FROM debian:bullseye-slim

# 设定环境变量
ENV DEBIAN_FRONTEND=noninteractive

# 更新系统包并安装必要的依赖包
RUN apt-get update && apt-get install -y \
    ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
    bzip2 ccache cmake cpio curl device-tree-compiler fastjar flex gawk gettext gcc-multilib g++-multilib \
    git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libfuse-dev libglib2.0-dev libgmp3-dev \
    libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libpython3-dev libreadline-dev \
    libssl-dev libtool lrzsz mkisofs msmtp ninja-build p7zip p7zip-full patch pkgconf python3 \
    python3-pyelftools python3-setuptools qemu-utils rsync scons squashfs-tools subversion swig texinfo \
    uglifyjs upx-ucl unzip vim wget xmlto xxd zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /build

# 从LEDE的官方源码仓库克隆源码
RUN git clone https://github.com/coolsnowwolf/lede.git .

# 初始化LEDE编译环境
RUN ./scripts/feeds update -a && ./scripts/feeds install -a

# 设置缺省配置
COPY .config /build/.config

# 默认命令：进入一个交互式shell
CMD ["bash"]