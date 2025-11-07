FROM n8nio/n8n:latest

# Instalar FFmpeg
RUN apt-get update && \
    apt-get install -y ffmpeg && \
    apt-get clean

# Criar diretório da aplicação
WORKDIR /app

# Instalar n8n global
RUN npm install -g n8n

# Variáveis obrigatórias do n8n
ENV N8N_PORT=5678
ENV N8N_BASIC_AUTH_ACTIVE=true

EXPOSE 5678

CMD ["n8n"]
