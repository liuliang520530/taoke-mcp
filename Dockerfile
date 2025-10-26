FROM alpine AS builder
COPY . /tmp/build/
RUN set -x \
  # 配置国内镜像源，第一个是>表示覆盖，后面的>>表示追加
  && echo "https://mirrors.aliyun.com/alpine/latest-stable/main" > /etc/apk/repositories \
  && echo "https://mirrors.aliyun.com/alpine/latest-stable/community" >> /etc/apk/repositories \
  && echo "https://mirrors.tuna.tsinghua.edu.cn/alpine/latest-stable/main" >> /etc/apk/repositories \
  && echo "https://repo.huaweicloud.com/alpine/latest-stable/main" >> /etc/apk/repositories \
  && echo "http://mirrors.ustc.edu.cn/alpine/latest-stable/main" >> /etc/apk/repositories \
  && apk update \
  && apk add nodejs npm \
  && npm i -g pnpm@8.3.1 pm2 --registry=https://registry.npmmirror.com/ \
  && cd /tmp/build \
  && rm -rf node_modules \
  && pnpm install --registry=https://registry.npmmirror.com/

FROM node:20.11.1-alpine
USER root
WORKDIR /server

COPY --from=builder /usr/local/lib/node_modules/. /usr/local/lib/node_modules/
COPY --from=builder /usr/local/bin/. /usr/local/bin/
COPY --from=builder /tmp/build/node_modules/. /server/node_modules/
COPY . /server/

# RUN npm install --production --ignore-scripts

# 设置环境变量
ENV NODE_ENV=production
ENV ENV_OVERRIDE=false
ENV ENV_URL=http://rap2api.taobao.org/app/mock/304812/taoke-mcp
ENV ENV_SECRET=url:mcp.sinataoke.cn

# Expose HTTP port
EXPOSE 8080

# 启动命令
CMD ["node", "/server/dist/index.js", "--transport", "http", "--port", "8080"]