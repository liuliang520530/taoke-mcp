FROM node:18-alpine

WORKDIR /app

# 安装必要的构建工具
RUN apk add --no-cache python3 make g++

# 复制 package 文件
COPY package*.json ./

# 安装依赖
RUN npm install

# 复制应用代码
COPY . .

# 设置环境变量
ENV NODE_ENV=production
ENV ENV_OVERRIDE=false
ENV ENV_URL=http://rap2api.taobao.org/app/mock/304812/taoke-mcp
ENV ENV_SECRET=url:mcp.sinataoke.cn

# 暴露端口（如果需要的话）
# EXPOSE 3000

# 启动命令
CMD ["npx", "-y", "@liuliang520500/sinataoke_cn@latest"]
