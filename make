#!/usr/bin/env bash
set -e

# ====== 函数定义 ======
green() { echo -e "\033[32m$1\033[0m"; }
red()   { echo -e "\033[31m$1\033[0m"; }

# ====== 环境准备 ======
cd "$(dirname "$0")"  # 切换到脚本所在目录

DATE=$(date +%y%m%d)
BASE_DIR="data"
PREFIX="$BASE_DIR/open-c3-installer-$DATE"
INDEX=1

# 自动生成唯一构建目录
while [ -d "${PREFIX}${INDEX}" ]; do
    INDEX=$((INDEX + 1))
done

OUTPUT_DIR="${PREFIX}${INDEX}"          # data/open-c3-installer-2407051
VERSION_DIR="open-c3-installer-${DATE}${INDEX}"  # open-c3-installer-2407051

mkdir -p "$OUTPUT_DIR/images"
green "📁 构建输出目录：$OUTPUT_DIR"

# ====== 拉取或更新 open-c3 ======
if [ -d "open-c3/.git" ]; then
    echo "📂 检测到 open-c3 已存在，执行 git pull ..."
    cd open-c3 && git pull || {
        red "❌ git pull 失败"
        exit 1
    }
    cd ..
else
    echo "📥 open-c3 不存在，开始 clone ..."
    git clone https://github.com/open-c3/open-c3.git || {
        red "❌ git clone 失败"
        exit 1
    }
fi

# ====== 校验并获取镜像列表 ======
IMAGE_LIST="open-c3/Installer/scripts/quick_start-image.list"
if [ ! -f "$IMAGE_LIST" ]; then
    red "❌ 镜像列表文件不存在：$IMAGE_LIST"
    exit 1
fi

# ====== 拉取 & 保存镜像 ======
echo "📦 开始拉取并保存 Docker 镜像..."
while IFS= read -r image; do
    [[ -z "$image" || "$image" == \#* ]] && continue

    filename="$OUTPUT_DIR/images/$(echo "$image" | tr '/:' '_').tar"

    if [ -f "$filename" ]; then
        echo "✅ 已存在，跳过：$filename"
        continue
    fi

    echo "🚀 拉取镜像：$image"
    if ! docker pull "$image"; then
        red "❌ 拉取失败：$image"
        continue
    fi

    echo "💾 保存镜像到：$filename"
    if ! docker save "$image" -o "$filename"; then
        red "❌ 保存失败：$image"
        continue
    fi

done < "$IMAGE_LIST"

green "✅ 镜像处理完成"

# ====== 拷贝 install 脚本与源码 ======
if [ ! -f "install" ]; then
    red "❌ install 脚本不存在，请确认脚本位置正确"
    exit 1
fi

cp install "$OUTPUT_DIR/" || {
    red "❌ install 脚本复制失败"
    exit 1
}

cp -r open-c3 "$OUTPUT_DIR/" || {
    red "❌ open-c3 源码复制失败"
    exit 1
}

# ====== 打包构建结果 ======
cd "$BASE_DIR"
TAR_NAME="${VERSION_DIR}.tar.gz"

green "📦 正在打包为 $TAR_NAME ..."
tar -zcf "$TAR_NAME" "$(basename "$OUTPUT_DIR")" || {
    red "❌ 打包失败"
    exit 1
}

green "🎉 打包完成：$(realpath "$TAR_NAME")"
echo "🔖 版本号：$VERSION_DIR"

# ====== 可选上传进行测试 ======
if [ -x ../test.sh ]; then
    green "📤 检测到 test.sh，开始执行测试操作 ..."
    if ../test.sh "$VERSION_DIR"; then
        green "✅ 测试完成"
    else
        red "❌ 测试失败"
    fi
else
    echo "ℹ️  未找到可执行的 ../test.sh，跳过测试"
fi
