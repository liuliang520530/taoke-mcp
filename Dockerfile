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
ENV PORT=8081

# Expose HTTP port
EXPOSE 8081

# 启动命令（直接运行，不需要额外参数）
CMD ["node", "/server/dist/smithery.js"]