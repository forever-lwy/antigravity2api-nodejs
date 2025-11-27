# 使用 Node.js 官方镜像
FROM node:20-slim

# 设置工作目录
WORKDIR /app

# 设置时区
ENV TZ=Asia/Shanghai

# 安装 CA 证书（解决 TLS 证书验证问题）
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 复制 package.json 和 package-lock.json（如果存在）
COPY package*.json ./

# 安装依赖
RUN npm install --production

# 复制项目文件
COPY . .

# 确保二进制文件有执行权限
RUN chmod +x src/bin/*

# 暴露端口（默认 8045）
EXPOSE 8045

# 创建数据目录
RUN mkdir -p /app/data

# 启动服务
CMD ["npm", "start"]
