FROM node:18-alpine

# Instala as dependências do sistema
RUN apk update && \
    apk add --no-cache \
      ffmpeg \
      imagemagick \
      jq \
      curl \
      wget \
      git \
      python3 \
      py3-pip \
      postgresql-client \
      redis \
    && rm -rf /var/cache/apk/*

# Instala Python e pip
RUN python3 --version && pip3 --version

# Instala wait-for-it para aguardar serviços dependentes
RUN wget -O /usr/local/bin/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh \
    && chmod +x /usr/local/bin/wait-for-it.sh

# Cria diretório da aplicação
WORKDIR /app

# Copia package.json primeiro para cache eficiente
COPY package*.json ./
COPY . .

# Instala dependências do Node.js
RUN npm install

# Cria diretórios necessários
RUN mkdir -p /app/n8n_data /app/tmp_data

# Expõe a porta do n8n
EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:5678/healthz || exit 1

# Comando para iniciar (ajuste conforme necessário)
CMD ["node", "packages/cli/bin/n8n", "start"]
