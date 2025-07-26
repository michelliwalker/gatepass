<<<<<<< HEAD
# 🚀 GatePass: Sistema de Compra e Venda de Ingressos/Produtos

![GatePass Logo](public/images/gate-pass-logo.png) ## 📄 Visão Geral do Projeto

O **GatePass** é um sistema completo e moderno projetado para facilitar a compra e venda de ingressos ou produtos. Ele oferece uma experiência de usuário intuitiva com um design aprimorado, um controle de estoque robusto com lógica de reserva por tempo e um fluxo de compra seguro e simulado. O projeto foi construído com foco em boas práticas de desenvolvimento e arquitetura modular, utilizando **PHP puro** no backend e tecnologias web padrão para o frontend, tudo empacotado e orquestrado por **Docker** para um ambiente de desenvolvimento portátil e eficiente.

## 🧰 Linguagens e Tecnologias Utilizadas

Este projeto foi desenvolvido utilizando as seguintes tecnologias:

* **Linguagens:**
    * **PHP 8.1:** Para toda a lógica de backend, gerenciamento de sessões, interação com o banco de dados e controle de fluxo.
    * **HTML:** Estruturação das páginas e formulários da interface do usuário.
    * **CSS:** Estilização visual (layouts, componentes, responsividade), com uso de variáveis CSS para modularidade.
* **Banco de Dados:**
    * **MariaDB 10.6:** Sistema de gerenciamento de banco de dados relacional para persistência dos dados da aplicação.
* **Orquestração e Ambiente:**
    * **Docker:** Para criar e gerenciar containers isolados para a aplicação PHP e o banco de dados.
    * **Docker Compose:** Para definir e executar aplicações multi-container Docker com um único comando.
* **Dependências PHP (via Composer):**
    * **Dompdf (`dompdf/dompdf`):** Biblioteca essencial para a geração de documentos PDF a partir de HTML, utilizada para os ingressos.

## ✨ Funcionalidades Principais

O **GatePass** oferece um conjunto abrangente de funcionalidades, divididas por papéis de usuário:

### Módulo de Usuários (Vendedores/Administradores)

* **Autenticação Completa:**
    * **Cadastro:** Criação de novas contas de vendedor (`/public/cadastro_usuario.php`).
    * **Login/Logout:** Gerenciamento de sessões seguras (`/public/login.php`, `/public/logout.php`).
    * **Verificação de Sessão:** Proteção de páginas sensíveis (`GatePass\Core\Auth`).
* **Gerenciamento de Perfil:**
    * **Edição de Perfil:** Atualização de dados pessoais e senha (com validação de senha atual) (`/public/editar_perfil.php`).
    * **Exclusão de Perfil:** Remoção definitiva da conta com confirmação (`/public/excluir_perfil.php`).
* **Gestão de Produtos:**
    * **Cadastro de Produtos:** Adição de novos produtos/ingressos com detalhes (`/public/cadastrar_produto.php`).
        * **Upload de Imagens:** Suporte para upload de `Foto de Perfil` e `Foto de Fundo/Banner` do evento (JPG, PNG, GIF), vinculadas ao produto.
    * **Visualização de Produtos:** Listagem dos produtos cadastrados pelo próprio vendedor (`/public/listar_produtos.php`).
    * **Edição de Produtos:** Modificação de detalhes de produtos existentes (apenas os próprios) (`/public/editar_produto.php`).
    * **Exclusão de Produtos:** Remoção de produtos (apenas os próprios) (`/public/excluir_produto.php`).
* **Painel Administrativo:**
    * **Dashboard do Vendedor:** Página centralizada (`/public/dashboard_vendedor.php`) para acesso rápido a todas as funcionalidades de gestão.
    * **Listagem de Usuários:** Visão geral de outros usuários do sistema (`/public/listar_usuarios.php`).

### Módulo de Clientes (Compradores)

* **Autenticação Independente:**
    * **Cadastro:** Clientes podem se auto-cadastrar para criar sua conta (`/public/cadastro_cliente.php`).
    * **Login/Logout:** Gerenciamento de sessões específicas para clientes (`/public/login_cliente.php`, `/public/logout_cliente.php`).
* **Navegação e Compra:**
    * **Vitrine de Produtos:** Página pública e responsiva (`/public/listar_produtos_publico.php`) para visualizar todos os ingressos/produtos disponíveis.
    * **Detalhes do Produto:** Página dedicada para informações aprofundadas do ingresso (`/public/detalhes_produto.php`).
        * **Reserva de Estoque (2 Minutos):** Quando a última unidade de um produto é visualizada por um cliente logado, ela é automaticamente reservada por 2 minutos, garantindo sua disponibilidade temporária. A reserva expira e o item é liberado se a compra não for concluída no prazo.
    * **Sistema de Carrinho de Compras:**
        * **Adicionar ao Carrinho:** Inclusão de produtos (com quantidade) no carrinho a partir da vitrine ou detalhes.
        * **Gerenciar Carrinho:** Página dedicada (`/public/ver_carrinho.php`) para visualizar, ajustar quantidades e remover itens do carrinho.
    * **Fluxo de Checkout:**
        * Página de resumo do pedido (`/public/checkout.php`) com re-validação de estoque em tempo real.
        * **Seleção de Método de Pagamento:** Opções simuladas de PIX, Boleto e Cartão de Crédito.
    * **Finalização da Compra:** Processamento seguro da transação (`/public/processar_compra.php`), com decremento de estoque, registro da compra e garantia de atomicidade via transações de banco de dados.
* **Histórico de Compras:**
    * **Minhas Compras:** Clientes podem visualizar um histórico detalhado de todas as suas compras (`/public/minhas_compras.php`).
    * **Geração de Ingresso em PDF:** Para cada compra, é possível gerar um ingresso em formato PDF com layout padrão, utilizando as imagens do evento e dados da compra/cliente (incluindo CPF).

### Medidas de Segurança Implementadas

* **Sanitização de Dados:** Uso rigoroso de `htmlspecialchars()` e `filter_var()` em todas as entradas de usuário e saídas HTML para prevenir ataques de Cross-Site Scripting (XSS).
* **Prevenção de SQL Injection:** Todas as interações com o banco de dados utilizam Prepared Statements (consultas preparadas) através da extensão PDO, garantindo que nenhum código malicioso seja executado no banco.
* **Hashing de Senhas:** As senhas dos usuários e clientes são armazenadas de forma segura no banco de dados usando o algoritmo de hash `Bcrypt` (`password_hash()`, `password_verify()`).
* **Gerenciamento Seguro de Arquivos:** A classe `GatePass\Utils\FileUpload` valida o tipo e tamanho dos arquivos de imagem, gera nomes únicos e move os arquivos de forma segura, minimizando riscos de upload de arquivos maliciosos.
* **Controle de Acesso por Sessão:** Páginas protegidas e ações sensíveis (`editar_produto.php`, `excluir_perfil.php`) verificam a autenticação e permissões do usuário logado via `$_SESSION`.

## ⚙️ Como Instalar e Rodar Localmente

Siga estas instruções passo a passo para configurar e executar o projeto em seu ambiente de desenvolvimento.

### Pré-requisitos

Certifique-se de ter o [Docker Desktop](https://www.docker.com/products/docker-desktop) instalado em seu sistema operacional (Windows, macOS, Linux). O Docker Desktop inclui o Docker Engine e o Docker Compose.

### Passos para Configuração e Execução

1.  **Clone o Repositório:**
    Abra seu terminal ou prompt de comando, navegue até o diretório onde deseja armazenar o projeto e clone o repositório:
    ```bash
    git clone [URL_DO_SEU_REPOSITORIO_GITHUB] GatePass
    cd GatePass
    ```
    *(Substitua `[URL_DO_SEU_REPOSITORIO_GITHUB]` pela URL real do seu repositório Git).*

2.  **Execute o Script de Setup Automatizado:**
    Este projeto inclui um script `setup.sh` que automatiza todos os passos iniciais de configuração: criação de diretórios, ajuste de permissões, instalação de dependências Composer e inicialização dos serviços Docker (aplicação PHP e banco de dados MariaDB).

    ```bash
    # Concede permissão de execução ao script
    chmod +x setup.sh

    # Executa o script de setup
    ./setup.sh
    ```
    * O script irá:
        * Criar a estrutura de pastas `public/uploads/produtos` para as imagens.
        * Definir permissões de escrita para `public/uploads` (usando `chmod -R 777` para desenvolvimento).
        * Instalar as dependências PHP (incluindo Dompdf e as extensões GD, PDO MySQL, BCMath) dentro de um container Docker temporário.
        * Construir as imagens Docker (`gatepass_app_php`, `gatepass_db_mariadb`).
        * Iniciar os containers em segundo plano.
        * Na **primeira execução**, o MariaDB também inicializará o banco de dados (`gatepass_db`) e criará todas as tabelas (definidas em `db/schema.sql`).

3.  **Verifique o Status dos Containers (Opcional):**
    Para confirmar que todos os serviços estão em execução:
    ```bash
    docker compose ps
    ```
    Você deverá ver `gatepass_app_php` e `gatepass_db_mariadb` com status `running`.

4.  **Acesse a Aplicação no Navegador:**
    Com os containers rodando, abra seu navegador web e acesse o endereço:
    ```
    http://localhost/public/
    ```
    Você será automaticamente redirecionado para a vitrine pública de produtos, pronto para começar a usar o **GatePass**.

## 📖 Como Usar o Sistema

### Para Compradores (Clientes)

1.  **Navegar e Adicionar ao Carrinho:**
    * Acesse `http://localhost/public/` para explorar os produtos.
    * Clique em "Adicionar ao Carrinho" nos produtos desejados.
2.  **Ver e Gerenciar Carrinho:**
    * No cabeçalho, clique em "Ver Carrinho" (exibe a quantidade de itens no carrinho) para acessar a página de gerenciamento (`/public/ver_carrinho.php`).
    * Nesta página, você pode ajustar a quantidade de itens ou removê-los.
3.  **Cadastro ou Login de Cliente:**
    * Para finalizar a compra, se você não estiver logado como cliente, o sistema (no checkout) o direcionará para fazer login ou se cadastrar.
    * Utilize os links "Login Cliente" ou "Cadastre-se Cliente" no cabeçalho.
4.  **Finalizar Compra:**
    * No carrinho, clique em "Finalizar Compra" para ir ao `checkout.php`.
    * Revise o resumo do pedido e escolha o método de pagamento (PIX, Boleto ou Cartão de Crédito - *simulado*).
    * Clique em "Confirmar Pagamento".
5.  **Minhas Compras e Ingresso PDF:**
    * Após a compra bem-sucedida, você será redirecionado para "Minhas Compras" (`/public/minhas_compras.php`).
    * Aqui, você verá o histórico de suas compras. Ao lado de cada compra, haverá um botão "Gerar Ingresso" para baixar o ingresso em PDF.

### Para Vendedores (Usuários)

1.  **Login de Vendedor:**
    * Na vitrine principal (`http://localhost/public/`), clique em "Acesso Vendedor" no cabeçalho.
2.  **Cadastro de Usuário (Opcional):**
    * Se ainda não tem uma conta de vendedor, use o link "Cadastre-se aqui" na página de login de vendedor.
3.  **Acessar Painel do Vendedor:**
    * Após o login como vendedor, você será redirecionado para o `Painel do Vendedor` (`/public/dashboard_vendedor.php`).
4.  **Gerenciar Produtos:**
    * No painel, você pode "Cadastrar Novo Produto" (e fazer upload de fotos!) e ver "Meus Produtos" para editar ou excluir os produtos que você cadastrou.
5.  **Outras Ações:**
    * "Editar Meu Perfil": Para gerenciar sua conta de vendedor.
    * "Listar Usuários": Para ver uma lista de todos os usuários do sistema.

## 📁 Estrutura do Projeto

GatePass/
├── public/                 # Contém todos os arquivos acessíveis via web (HTML, CSS, JS, Imagens, Scripts PHP)
│   ├── index.php           # Ponto de entrada que redireciona para a vitrine
│   ├── css/                # Estilos CSS globais (style.css)
│   ├── images/             # Imagens estáticas (logo, etc.)
│   ├── uploads/            # Diretório para imagens de produtos (upload de usuários)
│   │   └── produtos/       # Imagens específicas de produtos
│   ├── *.php               # Todas as páginas e scripts de interação do usuário/cliente (login, cadastro, produtos, carrinho, checkout, etc.)
├── src/                    # Código-fonte PHP principal da aplicação (classes, lógica de negócio)
│   ├── Core/               # Classes fundamentais (conexão DB, autenticação)
│   │   ├── Database.php    # Gerencia a conexão PDO com o MariaDB
│   │   └── Auth.php        # Gerencia a autenticação e sessões
│   ├── Models/             # Classes que representam entidades do negócio e interagem com o DB
│   │   ├── Usuario.php     # Modelo para usuários (vendedores)
│   │   ├── Cliente.php     # Modelo para clientes (compradores)
│   │   ├── Produto.php     # Modelo para produtos/ingressos
│   │   └── Compra.php      # Modelo para registros de compras
│   └── Utils/              # Classes utilitárias diversas
│       └── FileUpload.php  # Ajuda no upload seguro de arquivos
├── db/                     # Scripts de banco de dados
│   └── schema.sql          # Define o esquema (tabelas) do banco de dados MariaDB
├── vendor/                 # Diretório onde as dependências Composer são instaladas (ex: dompdf)
├── composer.json           # Arquivo de configuração do Composer
├── composer.lock           # Bloqueia as versões exatas das dependências Composer
├── Dockerfile              # Define a imagem Docker da aplicação PHP (com Apache, extensões)
├── docker-compose.yml      # Orquestra os serviços Docker (aplicação PHP e MariaDB)
└── setup.sh                # Script para automatizar a configuração inicial do ambiente


## 🗄️ Estrutura do Banco de Dados

O banco de dados `gatepass_db` é implementado em MariaDB e possui as seguintes tabelas principais:

* **`usuarios`**: Armazena as informações dos usuários (vendedores/administradores) do sistema.
    * `id_usuario` (PK, INT, Auto-Increment)
    * `nome` (VARCHAR)
    * `email` (VARCHAR, UNIQUE)
    * `senha` (VARCHAR, hashed)
    * `data_cadastro` (TIMESTAMP)
* **`clientes`**: Armazena as informações dos clientes (compradores) que realizam as compras.
    * `id_cliente` (PK, INT, Auto-Increment)
    * `nome` (VARCHAR)
    * `email` (VARCHAR, UNIQUE)
    * `senha` (VARCHAR, hashed)
    * `cpf` (VARCHAR, UNIQUE, NULLable)
    * `telefone` (VARCHAR, NULLable)
    * `data_cadastro` (TIMESTAMP)
* **`produtos`**: Contém os detalhes dos produtos/ingressos disponíveis para venda.
    * `id_produto` (PK, INT, Auto-Increment)
    * `id_usuario` (FK para `usuarios.id_usuario` - vendedor que cadastrou)
    * `nome` (VARCHAR)
    * `descricao` (TEXT, NULLable)
    * `preco` (DECIMAL)
    * `quantidade_total` (INT)
    * `quantidade_disponivel` (INT)
    * `quantidade_reservada` (INT)
    * `data_reserva` (TIMESTAMP, NULLable)
    * `reservado_por_cliente_id` (FK para `clientes.id_cliente`, NULLable - cliente que reservou)
    * `url_foto_perfil` (VARCHAR, NULLable)
    * `url_foto_fundo` (VARCHAR, NULLable)
    * `data_cadastro` (TIMESTAMP)
* **`compras`**: Registra cada transação de compra.
    * `id_compra` (PK, INT, Auto-Increment)
    * `id_produto` (FK para `produtos.id_produto`)
    * `id_cliente` (FK para `clientes.id_cliente`)
    * `id_usuario_vendedor` (FK para `usuarios.id_usuario` - vendedor do produto)
    * `quantidade_comprada` (INT)
    * `valor_total` (DECIMAL)
    * `metodo_pagamento` (VARCHAR)
    * `data_compra` (TIMESTAMP)

## 🤝 Como Contribuir

Contribuições são muito bem-vindas! Se você deseja colaborar com o projeto:

1.  **Faça um Fork** do repositório.
2.  **Crie uma nova Branch** para sua feature (`git checkout -b feature/minha-nova-funcionalidade`).
3.  **Implemente suas alterações** e certifique-se de que o código segue os padrões do projeto.
4.  **Faça Testes** para garantir que suas mudanças não introduzam bugs e funcionem conforme o esperado.
5.  **Faça Commit** de suas mudanças (`git commit -m "feat: Adiciona nova funcionalidade X"`).
6.  **Faça Push** para a sua Branch (`git push origin feature/minha-nova-funcionalidade`).
7.  **Abra um Pull Request** detalhando as mudanças realizadas.

## 📄 Licença

Este projeto está licenciado sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

**Desenvolvido por:**

* **Seu Nome:** [Seu Nome Completo]
* **Seu Email:** [seu.email@exemplo.com]

---
**Chapecó, Santa Catarina, Brasil.**
**Data da Documentação Final:** 26 de Julho de 2025.
=======
# gatepass
Projeto Final do curso DEV Evolution
>>>>>>> 36c43724fb3428d6adb61d0b89f75703b13b5799
