# shadowsocks-libev-with-simple-obfs-docker

A docker for shadowsocks-libev with simple-obfs support. Fork from official repository.

一个包括了 simple-obfs 和 shadowsocks-libev 的 docker.

## Build 方法:

```
sudo docker build -t shadowsocks-libev-with-simple-obfs-docker .
```

## 使用方法:

有两种使用方法一种是直接使用 `docker` 命令， 一种是使用 `docker-compose` 。作者推荐使用 `docker-compose`。

### docker 方法

```
sudo docker --it -d --name shadowsocks-libev  -p [your port]:8843 -v /path/to/your/config.json:/etc/ss.json nerdneils/shadowsocks-libev-with-simple-obfs-docker
```

其中: - [your port] 是 1-65535 的整数， 推荐使用常用服务端口， 如 `443` 或者 `8080`。 - [path/to/your/config.json] 配置文件，可以仿照提供的模板进行修改。后续版本会附带一个生成配置文件的脚本。

### docker-compose 方法

- 修改 `ss.json` 文件。
- 运行 `docker-compose`, 使用 `sudo docker-compose up -d` 命令。
