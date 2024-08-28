# docker-biglybt

一个 `BiglyBT` 容器，提供 `WEBUI` 和 `WEB VNC` 服务。

WEBUI 使用 [TrguiNG](https://github.com/jayzcoder/TrguiNG) 。

## 使用

### 通过 docker run 部署

```sh
docker run \
  --name biglybt \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ="Asia/Shanghai" \
  -e VNC_PORT=5901 \
  -e NOVNC_PORT=6081 \
  -e WEBUI_PORT=9091 \
  -e WEBUI_USER=admin \
  -e WEBUI_PASSWD=admin \
  -v "./config:/config/.biglybt" \
  -p "5901:5901" \
  -p "6081:6081" \
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
      VNC_PORT: 5901
      NOVNC_PORT: 6081
      WEBUI_PORT: 9091
      WEBUI_USER: admin
      WEBUI_PASSWD: admin
    volumes:
      - ./config:/config/.biglybt
    ports:
      - "5901:5901"
      - "6081:6081"
      - "9091:9091"
    restart: always
```

## 环境变量

### 环境变量

| 变量名       | 描述               | 默认值    |
| ------------ | ------------------ | --------- |
| VNC_HOST     | VNC 监听地址       | 127.0.0.1 |
| VNC_PORT     | VNC 监听端口       | 5901      |
| VNC_GEOMETRY | VNC 显示分辨率     | 1280x800  |
| TITLE        | noVNC web 标题     | BiglyBT   |
| NOVNC_HOST   | noVNC web 监听地址 | 0.0.0.0   |
| NOVNC_PORT   | noVNC web 监听端口 | 6081      |
| WEBUI_PORT   | WEBUI 监听端口     | 9091      |
| WEBUI_USER   | WEBUI 用户名       | admin     |
| WEBUI_PASSWD | WEBUI 密码         | admin     |
