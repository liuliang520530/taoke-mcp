FROM node:20.11.1-alpine
USER root
WORKDIR /server

COPY . /server/

RUN npm install --production --ignore-scripts --legacy-peer-deps && \
    apk add --no-cache tzdata && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# 设置时区为中国标准时间 (Asia/Shanghai)
# 解决京东API时间戳校验问题
ENV TZ=Asia/Shanghai
# 设置环境变量
ENV PORT=8081
# ENV_SECRET 应在运行时通过 -e 参数传入，不在镜像中硬编码

# Expose HTTP port
EXPOSE 8081

# 健康检查
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD node -e "require('http').get('http://localhost:8081/mcp', (r) => {process.exit(r.statusCode === 200 ? 0 : 1)})"

# 启动命令（直接运行，不需要额外参数）
CMD ["node", "/server/dist/smithery.js"]