FROM node:20.11.1-alpine
USER root
WORKDIR /server

COPY . /server/

RUN npm install --production --ignore-scripts

# 设置环境变量
ENV NODE_ENV=production
ENV ENV_OVERRIDE=false
ENV ENV_URL=http://config.sinataoke.cn/api/mcp/secret
ENV PORT=8081
# ENV_SECRET 应在运行时通过 -e 参数传入，不在镜像中硬编码

# Expose HTTP port
EXPOSE 8081

# 启动命令（直接运行，不需要额外参数）
CMD ["node", "/server/dist/smithery.js"]