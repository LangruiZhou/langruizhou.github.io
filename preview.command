#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

on_exit() {
  local status=$?
  if [ "$status" -ne 0 ]; then
    printf '\n预览未能启动，请查看上方的错误信息。\n'
    if [ -t 0 ]; then
      read -r -p "按回车键关闭窗口……" || true
    fi
  fi
}
trap on_exit EXIT

if ! command -v ruby >/dev/null 2>&1; then
  printf '本机未找到 Ruby，请先安装 Ruby，再双击此文件。\n'
  exit 1
fi

# 依赖仅安装在项目的 vendor/ 中，不修改系统 Ruby，也不需要 sudo。
export GEM_HOME="$PWD/vendor/preview-tools"
export GEM_PATH="$GEM_HOME"
export BUNDLE_PATH="$PWD/vendor/bundle"
export BUNDLE_GEMFILE="$PWD/Gemfile"
export BUNDLE_IGNORE_CONFIG=1
bundler_version="2.4.22"
bundler="$GEM_HOME/gems/bundler-$bundler_version/exe/bundle"

# 兼容 macOS 自带 Ruby 编译依赖时的 C++ 头文件路径。
if command -v xcrun >/dev/null 2>&1; then
  sdk_path="$(xcrun --show-sdk-path 2>/dev/null || true)"
  if [ -d "$sdk_path/usr/include/c++/v1" ]; then
    export SDKROOT="$sdk_path"
    export CPLUS_INCLUDE_PATH="$sdk_path/usr/include/c++/v1${CPLUS_INCLUDE_PATH:+:$CPLUS_INCLUDE_PATH}"
  fi
fi

printf '正在准备本地预览……\n'
if [ ! -f "$bundler" ]; then
  printf '首次启动：安装预览工具，需要联网。\n'
  gem install bundler --version "$bundler_version" --no-document
fi

if ! ruby "$bundler" check >/dev/null 2>&1; then
  printf '首次启动或依赖有更新：安装网页依赖，请稍候。\n'
  ruby "$bundler" install
fi

printf '\n预览地址：http://127.0.0.1:4000\n'
printf '浏览器会自动打开；修改 _data/ 后页面会自动刷新。\n'
printf '预览期间请保留此窗口，按 Control+C 停止。\n\n'
exec ruby "$bundler" exec jekyll serve --host 127.0.0.1 --livereload --open-url
