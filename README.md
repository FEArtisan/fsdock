# fsdock
用于 NodeJS 开发环境的 Docker 工具包。它的灵感来源于 [Laradock](https://github.com/laradock/laradock) 项目。

<a name="getting-started"></a>
## Getting Started

<a name="Installation"></a>
### Installation

1.将此存储库克隆到任何位置

```shell
git clone https://github.com/FEArtisan/fsdock.git
```

文件夹结构应如下所示：
```
<main-folder>
|
|--fsdock
|--project-1
|--project-2
```

确保APP_CODE_PATH_HOST变量指向父目录。

```
APP_CODE_PATH_HOST=../
```

2.转到 nginx 并创建配置文件以在访问不同域名时指向不同的项目目录：

3.更改配置文件*.conf：

您可以根据需要重命名配置文件、项目文件夹和域名，只需确保配置文件中的 root 指向正确的项目文件夹路径即可。

4.将域名添加到本机 DNS： `/etc/hosts`。
```
127.0.0.1  project-1.test
127.0.0.1  project-2.test
```

<a name="Usage"></a>
### Usage

1.进入 fsdock 文件夹并复制 .env.example 到 .env
```shell
cp .env.example .env
```

2.启动容器
```shell
docker-compose up -d nginx mysql redis
```

3.打开浏览器并访问本地测试域名。

http://project-1.test/

## production
```shell
docker-compose -f prod.docker-compose.yml up -d nginx mysql redis
```
