FROM n8nio/n8n:latest

# Instalar FFmpeg (Alpine usa apk)
USER root
RUN apk update && apk add --no-cache ffmpeg

# Variáveis obrigatórias
ENV N8N_PORT=5678
ENV N8N_BASIC_AUTH_ACTIVE=true

EXPOSE 5678

CMD ["n8n"]
