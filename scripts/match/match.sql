USE tse;
# CREATE TABLES TO MATCH AND LOAD FILES

DROP TABLE IF EXISTS odb;

CREATE TABLE odb (
    nome varchar(255),
    documento varchar(20),
    tipo varchar(255)
);

load data local infile 'csv/match.csv' into table odb CHARACTER SET UTF8 fields terminated by ','  enclosed by '"'  lines terminated by '\n'  (nome, documento, tipo);


DROP TABLE IF EXISTS odblike;

CREATE TABLE odblike (
    nome varchar(255)
);

load data local infile 'csv/matchlike.csv' into table odblike CHARACTER SET UTF8 fields terminated by ','  enclosed by '"'  lines terminated by '\n'  (nome);

# CREATE VIEWS
CREATE OR REPLACE VIEW documentos
AS
SELECT DISTINCT(TRIM(documento)) AS documento
FROM odb
WHERE TRIM(documento) <> "";

CREATE OR REPLACE VIEW nomes
AS
SELECT DISTINCT(TRIM(nome)) AS nome
FROM odb
WHERE TRIM(nome) <> "";


CREATE OR REPLACE VIEW prefixos_cnpj
AS
SELECT DISTINCT SUBSTR(TRIM(documento), 1, 8) AS inicio
FROM odb
WHERE TRIM(documento) <> "" AND LENGTH(documento) > 11;

# Match by similar name - Indirect donations
DROP TABLE IF EXISTS doa_nomelike_orig;
CREATE TABLE doa_nomelike_orig AS 
SELECT 
doacoes.id,
doacoes.uf,
doacoes.partido,
doacoes.cargo,
doacoes.candidato,
doacoes.numero,
doacoes.ano,
doacoes.cpf_candidato,
doacoes.doador,
doacoes.doador_original,
doacoes.doador_norm,
doacoes.cpf_doador,
doacoes.cpf_doador_original,
doacoes.recurso,
doacoes.data,
doacoes.setor_economico,
doacoes.motivo,
doacoes.valor_at,
doacoes.valor,
doacoes.dolar,
doacoes.tipo
FROM doacoes INNER JOIN odblike 
ON TRIM(doacoes.doador_original) LIKE CONCAT('%',odblike.nome, '%')
WHERE TRIM(odblike.nome) <> '' ;


# Match by similar name
DROP TABLE IF EXISTS doa_nomelike;
CREATE TABLE doa_nomelike AS 
SELECT 
doacoes.id,
doacoes.uf,
doacoes.partido,
doacoes.cargo,
doacoes.candidato,
doacoes.numero,
doacoes.ano,
doacoes.cpf_candidato,
doacoes.doador,
doacoes.doador_original,
doacoes.doador_norm,
doacoes.cpf_doador,
doacoes.cpf_doador_original,
doacoes.recurso,
doacoes.data,
doacoes.setor_economico,
doacoes.motivo,
doacoes.valor_at,
doacoes.valor,
doacoes.dolar,
doacoes.tipo
FROM doacoes INNER JOIN odblike 
ON TRIM(doacoes.doador) LIKE CONCAT('%',odblike.nome, '%')
WHERE TRIM(odblike.nome) <> '' ;

# Match subsidiares - Indirect donations
DROP TABLE IF EXISTS doa_filial_orig;
CREATE TABLE doa_filial_orig AS
SELECT 
doacoes.id,
doacoes.uf,
doacoes.partido,
doacoes.cargo,
doacoes.candidato,
doacoes.numero,
doacoes.ano,
doacoes.cpf_candidato,
doacoes.doador,
doacoes.doador_original,
doacoes.doador_norm,
doacoes.cpf_doador,
doacoes.cpf_doador_original,
doacoes.recurso,
doacoes.data,
doacoes.setor_economico,
doacoes.motivo,
doacoes.valor_at,
doacoes.valor,
doacoes.dolar,
doacoes.tipo
FROM doacoes INNER JOIN prefixos_cnpj 
ON TRIM(doacoes.cpf_doador_original) LIKE CONCAT(prefixos_cnpj.inicio, '%')
WHERE LENGTH(TRIM(doacoes.cpf_doador_original)) > 11 ;

# Match subsidiaries
DROP TABLE IF EXISTS doa_filial;
CREATE TABLE doa_filial AS
SELECT 
doacoes.id,
doacoes.uf,
doacoes.partido,
doacoes.cargo,
doacoes.candidato,
doacoes.numero,
doacoes.ano,
doacoes.cpf_candidato,
doacoes.doador,
doacoes.doador_original,
doacoes.doador_norm,
doacoes.cpf_doador,
doacoes.cpf_doador_original,
doacoes.recurso,
doacoes.data,
doacoes.setor_economico,
doacoes.motivo,
doacoes.valor_at,
doacoes.valor,
doacoes.dolar,
doacoes.tipo
FROM doacoes INNER JOIN prefixos_cnpj 
ON TRIM(doacoes.cpf_doador) LIKE CONCAT(prefixos_cnpj.inicio, '%')
WHERE LENGTH(TRIM(doacoes.cpf_doador)) > 11 ;

# Match by document
DROP TABLE IF EXISTS doa_doc;
CREATE TABLE doa_doc AS
SELECT 
doacoes.id,
doacoes.uf,
doacoes.partido,
doacoes.cargo,
doacoes.candidato,
doacoes.numero,
doacoes.ano,
doacoes.cpf_candidato,
doacoes.doador,
doacoes.doador_original,
doacoes.doador_norm,
doacoes.cpf_doador,
doacoes.cpf_doador_original,
doacoes.recurso,
doacoes.data,
doacoes.setor_economico,
doacoes.motivo,
doacoes.valor_at,
doacoes.valor,
doacoes.dolar,
doacoes.tipo
FROM doacoes
INNER JOIN documentos
ON TRIM(doacoes.cpf_doador) = documentos.documento;

# Match by document - Indirect donations
DROP TABLE IF EXISTS doa_doc_orig;
CREATE TABLE doa_doc_orig AS
SELECT 
doacoes.id,
doacoes.uf,
doacoes.partido,
doacoes.cargo,
doacoes.candidato,
doacoes.numero,
doacoes.ano,
doacoes.cpf_candidato,
doacoes.doador,
doacoes.doador_original,
doacoes.doador_norm,
doacoes.cpf_doador,
doacoes.cpf_doador_original,
doacoes.recurso,
doacoes.data,
doacoes.setor_economico,
doacoes.motivo,
doacoes.valor_at,
doacoes.valor,
doacoes.dolar,
doacoes.tipo
FROM doacoes
INNER JOIN documentos
ON TRIM(doacoes.cpf_doador_original) = documentos.documento;


# MATCH BY NAME
DROP TABLE IF EXISTS doa_rzsocial;
CREATE TABLE doa_rzsocial AS
SELECT 
doacoes.id,
doacoes.uf,
doacoes.partido,
doacoes.cargo,
doacoes.candidato,
doacoes.numero,
doacoes.ano,
doacoes.cpf_candidato,
doacoes.doador,
doacoes.doador_original,
doacoes.doador_norm,
doacoes.cpf_doador,
doacoes.cpf_doador_original,
doacoes.recurso,
doacoes.data,
doacoes.setor_economico,
doacoes.motivo,
doacoes.valor_at,
doacoes.valor,
doacoes.dolar,
doacoes.tipo
FROM doacoes
INNER JOIN nomes
ON TRIM(doacoes.doador) = nomes.nome;

# MATCH BY NAME - INDIRECT DONATIONS
DROP TABLE IF EXISTS doa_rzsocial_orig;
CREATE TABLE doa_rzsocial_orig AS
SELECT 
doacoes.id,
doacoes.uf,
doacoes.partido,
doacoes.cargo,
doacoes.candidato,
doacoes.numero,
doacoes.ano,
doacoes.cpf_candidato,
doacoes.doador,
doacoes.doador_original,
doacoes.doador_norm,
doacoes.cpf_doador,
doacoes.cpf_doador_original,
doacoes.recurso,
doacoes.data,
doacoes.setor_economico,
doacoes.motivo,
doacoes.valor_at,
doacoes.valor,
doacoes.dolar,
doacoes.tipo
FROM doacoes
INNER JOIN nomes
ON TRIM(doacoes.doador_original) = nomes.nome;

# JOIN ALL TABLES
DROP TABLE IF EXISTS grupodb;
CREATE TABLE grupodb AS
SELECT 
*
FROM doa_rzsocial
UNION
SELECT 
*
FROM doa_nomelike
UNION
SELECT 
*
FROM doa_nomelike_orig
UNION
SELECT 
*
FROM doa_doc
UNION
SELECT 
*
FROM doa_filial
UNION
SELECT 
*
FROM doa_rzsocial_orig
UNION
SELECT 
*
FROM doa_filial_orig
UNION
SELECT 
*
FROM doa_doc_orig;

# MATCH THIRD-PARTY COMPANIES
DROP TABLE IF EXISTS laranjas;
CREATE TABLE laranjas AS
SELECT 
doacoes.id,
doacoes.uf,
doacoes.partido,
doacoes.cargo,
doacoes.candidato,
doacoes.numero,
doacoes.ano,
doacoes.cpf_candidato,
doacoes.doador,
doacoes.doador_original,
doacoes.doador_norm,
doacoes.cpf_doador,
doacoes.cpf_doador_original,
doacoes.recurso,
doacoes.data,
doacoes.setor_economico,
doacoes.motivo,
doacoes.valor_at,
doacoes.valor,
doacoes.dolar,
doacoes.tipo
FROM doacoes
WHERE doador_original like 'CERVEJARIA PETR%' or doador_original LIKE '%leyroz%' or doador_original LIKE '%praiamar%' or doador_original like 'dag const%' or doador_original like 'rof comercial%'
or doador like 'CERVEJARIA PETR%' or doador LIKE '%leyroz%' or doador LIKE '%praiamar%' or doador like 'dag const%' or doador like 'rof comercial%'
or cpf_doador like '06958578%' or cpf_doador like '00851567%' or cpf_doador like '08415791%' or cpf_doador like '73410326%'  
or cpf_doador_original like '06958578%' or cpf_doador_original like '00851567%' or cpf_doador_original like '08415791%' or cpf_doador_original like '73410326%' ;