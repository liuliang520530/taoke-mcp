FROM node:20.11.1-alpine
USER root
WORKDIR /server

COPY . /server/

RUN npm install --production --ignore-scripts

# 设置环境变量
ENV NODE_ENV=production
ENV ENV_OVERRIDE=false
ENV ENV_URL=http://config.sinataoke.cn/api/mcp/secret
ENV ENV_SECRET=url:mcp.sinataoke.cn

# Expose HTTP port
EXPOSE 8080

# 启动命令
CMD ["node", "/server/dist/index.js", "--transport", "http", "--port", "8080"]