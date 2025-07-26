# Usa uma imagem base do PHP com Apache
FROM php:8.1-apache

# Define o diretório de trabalho dentro do container
WORKDIR /var/www/html

# Instala dependências do sistema para a extensão GD (JPEG, PNG, FreeType)
RUN apt-get update && apt-get install -y \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    zlib1g-dev \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Configura e instala a extensão GD com suporte explícito a JPEG e FreeType
RUN docker-php-ext-configure gd --with-jpeg=/usr --with-freetype=/usr \
    && docker-php-ext-install -j$(nproc) gd

# Instala as outras extensões PHP necessárias
RUN docker-php-ext-install pdo_mysql bcmath

# Habilita o módulo rewrite do Apache (útil para URLs amigáveis)
RUN a2enmod rewrite

# Copia os arquivos da aplicação para o diretório de trabalho do container
# VOLUME .:/var/www/html no docker-compose.yml já faz isso.
# COPY . /var/www/html