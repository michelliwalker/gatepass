#!/bin/bash

# Este script automatiza a configuração inicial do ambiente de desenvolvimento.
# Ele cria as pastas necessárias, define permissões e inicia os serviços Docker.

set -e # Sai imediatamente se um comando retornar um status de não-zero.

echo "==============================================="
echo " Iniciando Configuração do Projeto GatePass   "
echo "==============================================="

echo "1. Criando diretórios de uploads e definindo permissões..."
# Cria a pasta 'uploads' e a subpasta 'produtos' dentro de 'public/'
# A opção -p garante que ele não dará erro se a pasta já existir.
mkdir -p public/uploads/produtos

# Define permissões de escrita para a pasta de uploads.
# ATENÇÃO: Permissão 777 é para AMBIENTE DE DESENVOLVIMENTO/TESTE.
# Em ambiente de PRODUÇÃO, use permissões mais restritivas (ex: 755 ou 775)
# e configure o servidor web para ter acesso ao diretório.
chmod -R 777 public/uploads
echo "   Diretórios criados e permissões definidas para public/uploads."

echo ""
echo "2. Instalando dependências do Composer..."
# Executa 'composer install' dentro de um container Docker temporário.
# Isso garante que as dependências PHP e o autoloader sejam gerados.
docker run --rm -v "$(pwd)":/app composer/composer install
echo "   Dependências do Composer instaladas."

echo ""
echo "3. Iniciando serviços Docker (PHP e MariaDB)..."
# Inicia os containers definidos no docker-compose.yml.
# --build: Garante que as imagens sejam (re)construídas.
# -d: Roda os containers em segundo plano.
# Na primeira execução, o MariaDB também inicializará o banco de dados via schema.sql.
docker compose up --build -d
echo "   Serviços Docker iniciados."

echo ""
echo "==============================================="
echo " Configuração Concluída!                        "
echo " Acesse http://localhost/public/ no seu navegador. "
echo "==============================================="