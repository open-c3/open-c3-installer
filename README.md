# open-c3-installer 【Open-C3安装器】

## 用途说明

下面的命令可以在有网络的环境下一键安装Open-C3。但是如果你要安装Open-C3的机器不能上公网，可以使用Open-C3安装器进行安装。

```sh
curl -sSL https://github.com/open-c3/open-c3/releases/download/v2.6.1-latest/quick_start.sh | bash
```

## 使用方式

### 下载

通过下面的地址获取最新版本的安装包。

* 百度网盘:  [点击进入](https://pan.baidu.com/s/1nF8eqCmpjaDHJJlY4Sidog?pwd=open)
* 官网下载:  [点击进入](https://www.open-c3.online/open-c3-installer/)

### 安装

下载的安装包拷贝到一个干净的Linux Server(64 位，>= 4c8g )上，通过下面的命令进行安装。

如：open-c3-installer-2507061.tar.gz

```sh
tar -zxvf open-c3-installer-2507061.tar.gz
cd open-c3-installer-2507061
./install
```
