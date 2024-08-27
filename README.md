# docker-biglybt

一个使用 `ghcr.io/linuxserver/webtop:ubuntu-xfce` 为基础模型的 `BiglyBT` 容器，提供 `WEBUI` 和 `WEB VNC` 服务。

WEBUI 使用 [TrguiNG](https://github.com/jayzcoder/TrguiNG) 。

## 使用

### 通过 docker run 部署

```sh
docker run \
  --name biglybt \
  --restart=always \
  -e TZ="Asia/Shanghai" \
  -e LC_ALL="zh_CN.UTF-8" \
  -v "./config:/config/.biglybt" \
  -p "3000:3000" \
  -p "9091:9091" \
  -d \
  ghcr.io/azicen/biglybt:latest
```

### 通过 docker-compose 部署

```yaml
services:
  biglybt:
    container_name: biglybt
    image: ghcr.io/azicen/biglybt:latest
    environment:
      TZ: Asia/Shanghai
      LC_ALL: zh_CN.UTF-8
    volumes:
      - ./config:/config/.biglybt
    ports:
      - "3000:3000"
      - "9091:9091"
    restart: always
```

## 环境变量

### 必要的环境变量

| 变量名       | 描述         | 默认值 |
| ------------ | ------------ | ------ |
| TZ           | 时区         |        |
| LC_ALL       | 语言环境     |        |
| WEBUI_PORT   | WEBUI 端口   | 9091   |
| WEBUI_USER   | WEBUI 用户名 | admin  |
| WEBUI_PASSWD | WEBUI 密码   | admin  |

### 可选的环境变量

查看 [webtop](https://docs.linuxserver.io/images/docker-webtop/#optional-environment-variables) 获得更多可选环境变量。
