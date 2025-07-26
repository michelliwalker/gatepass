<?php
// src/Core/Database.php

namespace GatePass\Core;

use PDO;
use PDOException;

class Database
{
    // Propriedade estática para armazenar a única instância da classe (padrão Singleton)
    private static $instancia = null; 
    
    // Propriedade para armazenar o objeto PDO da conexão
    private PDO $pdo; 

    /*

     Construtor privado para evitar a criação de múltiplas instâncias (Singleton).
     Inicializa a conexão com o banco de dados usando PDO.

     */

    private function __construct()
    {
        // Obtém as variáveis de ambiente para a conexão com o banco de dados
        $host = getenv('MYSQL_HOST');
        $database = getenv('MYSQL_DATABASE');
        $user = getenv('MYSQL_USER');
        $password = getenv('MYSQL_PASSWORD');
        $charset = 'utf8mb4';

        // Monta a string Data Source Name para a conexão PDO
        $dsn = "mysql:host=$host;dbname=$database;charset=$charset";
        
        // Define as opções para a conexão PDO
        $opcoes = [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION, // Lança PDOExceptions em caso de erros
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,       // Define o modo de busca padrão como array associativo
            PDO::ATTR_EMULATE_PREPARES   => false,                  // Desabilita a emulação de prepared statements para segurança e performance
        ];

        try {
            // Tenta criar uma nova instância PDO para a conexão com o banco de dados
            $this->pdo = new PDO($dsn, $user, $password, $opcoes);
        } catch (PDOException $e) {
            die("Erro de conexão com o banco de dados: " . $e->getMessage());
        }
    }

    /*
     
    Retorna a única instância da classe Database (implementação do Singleton).
    Cria a instância se ela ainda não existir.
     
     */

    public static function obterInstancia(): Database
    {
        if (self::$instancia === null) {
            self::$instancia = new Database();
        }
        return self::$instancia;
    }



    /*

    Retorna o objeto PDO da conexão ativa com o banco de dados.
     
    */
    public function obterConexao(): PDO
    {
        return $this->pdo;
    }
}