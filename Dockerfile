# 基础镜像（适配白山智算平台）
FROM registry.bs58i.baishancdnx.com/edge-ai/cuda12.1-ubuntu22.04:latest

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# 配置Python环境
RUN python3.10 -m pip install --upgrade pip && \
    pip install torch==2.2.0 --index-url https://download.pytorch.org/whl/cu121

# 安装训练依赖
RUN pip install \
    modelscope>=1.19 \
    ms-swift \
    transformers==4.49.0 \
    deepspeed==0.14.5 \
    flash-attn==2.5.8

# 复制脚本
COPY scripts/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# 设置工作目录
WORKDIR /workspace
VOLUME /mnt/bscs  # 挂载存储

# 启动命令
ENTRYPOINT ["entrypoint.sh"]

