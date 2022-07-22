
# 用途

```
用于测试安装器打包好的文件是否能正常使用。

```

# 用法

```
1. 上一步骤的打包机ip写入: /data/open-c3-installer/t/.dbhost  会从该服务器scp安装器的包。提前添加好ssh授权。
2. 把本机的ip写入:         /data/open-c3-installer/t/.myhost ,会使用该ip进行install

3. /data/open-c3-installer/t && ./run
```
