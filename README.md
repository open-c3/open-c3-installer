# open-c3-installer 【C3安装器】

## 用途说明

我们为C3安装提供了[一键安装的命令](https://open-c3.github.io/%E5%8D%95%E6%9C%BA%E7%89%88%E5%AE%89%E8%A3%85/)， 同时我们区分了国内和海外两个不同的安装命令使用不同的数据源。


C3的一键安装命令会 下载git代码、下载nodejs依赖模块、下载docker镜像。网络正常的情况下我们是可以正常安装的。


但是,有的环境有网络限制，很难从外部网络获取数据。所以我们提供了C3安装器。里面包含了安装C3所需的数据。


从[安装器网盘下载地址](https://pan.baidu.com/s/1888GjGrElqZm5qWPQ82hdw?pwd=6g75)下载一个最新的版本的文件。按照如下方式进行安装即可。

* > 网盘地址1:  [点击进入](https://pan.baidu.com/s/1888GjGrElqZm5qWPQ82hdw?pwd=6g75)
* > 网盘地址2:  [点击进入](https://pan.baidu.com/s/1NESiPnpwho_PnV0L5Hrcmw?pwd=yn6u)

## 安装方式

下载一个最新的版本文件放到/data/目录下，如：/data/open-c3-installer-v2.6.1-20220718.2337.tar.gz

执行命令:
```

cd /data
tar -zxvf open-c3-installer-v2.6.1-20220718.2337.tar.gz
cd /data/open-c3-installer
./install 10.10.10.10  # 10.10.10.10 为部署的C3的访问地址,C3服务器的内网或者外网地址

```
