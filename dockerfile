# usa a imagem oficial do n8n
FROM n8nio/n8n:latest

USER root

# Instala utilitários importantes
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ffmpeg \
      imagemagick \
      jq \
      curl \
      wget \
      git \
      python3 \
      python3-pip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instale pacotes python úteis (opcional)
# RUN pip3 install --no-cache-dir pydub

# Retorna para usuário node (n8n roda como node)
USER node
