# 安装器打包方式

## 配置
```
在test.txt文件中，配置好用来测试安装器是否可以正常使用的机器的IP。
在sync.txt文件中，配置要上传到什么服务器上去。
```

注：
```
上面两个文件，文件可以是多行，每行一个ip地址。
```

# 执行

```
./make 

#上面这个脚本，会根据open-c3/Installer/scripts/quick_start-image.list文件中描述的镜像列表，
#把所有镜像和最新的open-c3的代码打成一个压缩包。
#打包成功后会自动调用 ./test.sh 进行测试。

#测试成功后，确定服务正常，手动执行下面命令把包上传到公网发布出去。
./sync.sh
```

注：
```
open-c3/Installer/scripts/quick_start-image.list 列表可以从任何新安装的环境中获取到，手动更新到git中。

网盘目前需要手动上传，sync.sh 会把文件上传到网盘机器的电脑桌面上，手动上传到网盘中。

```
