USE tse;
# Script para importar e fazer o match do Grupo Odebrecht

DROP TABLE IF EXISTS odb;

CREATE TABLE odb (
    nome varchar(255),
    documento varchar(20),
    tipo varchar(255)
);

load data local infile 'csv/match.csv' into table odb CHARACTER SET UTF8 fields terminated by ','  enclosed by '"'  lines terminated by '\n'  (nome, documento, tipo);

# Crias as views
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

# Cria tabela por filial - CNPJ do doador originario
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

# Cria tabela por filial
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

# Cria tabela por documento
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

# Cria tabela por documento - CPF original
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

# Cria tabela por LIKE
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
FROM doacoes
WHERE doador LIKE '%Brask%' or doador like 'supervia%'OR doador LIKE '%CETREL%' OR doador_original LIKE '%CETREL%'OR doador LIKE '%Odebr%' OR doador LIKE '%SANEATINS%' or doador like '%energipar%'OR doador LIKE '%Ordebr%' 
OR doador LIKE '%Brasque%' OR  doador LIKE '%Oubrecht%' OR doador LIKE '%Adebrecht%' OR doador LIKE '%Odevrecht%' OR doador LIKE '%Oderbrecht%' OR doador LIKE '%Edebrecht%' OR doador LIKE '%Construtora Noberto%' OR doador LIKE 'Oubrecht' or doador LIKE 'quantiq' OR doador LIKE '%CETREL%' OR doador_original LIKE '%Brask%' OR doador_original LIKE '%Odebre%' or doador like 'CERVEJARIA PETR%' or doador LIKE '%leyroz%' or doador LIKE '%praiamar%'
OR doador_original LIKE '%Brasque%' OR  doador_original LIKE '%Oubrecht%' OR doador_original LIKE '%Adebrecht%' OR doador_original LIKE '%Odevrecht%' OR doador_original LIKE '%Oderbrecht%' OR doador_original LIKE '%Edebrecht%' OR doador_original LIKE '%Construtora Noberto%' OR doador_original LIKE 'Oubrecht' OR doador_original LIKE '%CETREL%' or doador_original like 'CERVEJARIA PETR%' or doador_original LIKE '%leyroz%' or doador_original LIKE '%praiamar%';

# Consulta por nome
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

# Consulta por nome - doador original
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

# CRIA TABELA FINAL
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



# CORRIGE O BANCO E REMOVE ENTRADAS INDEVIDAS
DELETE FROM grupodb
WHERE 

doador =  'DANIEL FERREIRA LIMA'  # Falta CPF de Daniel Ferreira Lima, da ODEPREV.
or doador = 'JOAO BARBOSA FILHO' OR cpf_doador = '01261568087' 
# João Barbosa Filho
or cpf_doador = '22885773804' or cpf_doador = '80503659991' # José de Carvalho de Filho
or doador = 'RENATO ALVES VALE' # está sem cpf_doador
or cpf_doador = '08545543786' or cpf_doador = '15945487000152' # hom Luciano Alves da Cruz
#Pq Iguacu, esta com Odeb. mas com CNPJ de outra empresa, apenas 1 doacao
or cpf_doador = '75057299000110'
# Homônimos Sergio Luiz Neves 
or cpf_doador = '52432742672' or cpf_doador LIKE '%7084586962' 
#Rui Lemos Sampaio
or cpf_doador = '02858240582'
# Homônio Sergio França Leão
or cpf_doador = '16152131634'
# ANTONIO DE CASTRO ALMEIDA
or cpf_doador = '04996348534'
or cpf_doador = '80708595715'
# NEBRASKA
or cpf_doador = '05694370000190'
# Homônio Pedro P de Sá
or cpf_doador = '33486743449'
#BRASKIT BRASKAL
or cpf_doador = '04606863000168'
or cpf_doador = '05955807000100'
# Flavio Aparecido Peres
or cpf_doador = '71191356868'
or cpf_doador = '71191356868'
# Marcio Faria da Silva
or cpf_doador = '07499979741'
# Luciano Teixeira Odebrecht
or cpf_doador = '25792778000101'
or cpf_doador = '87956764904'
or cpf_doador = '16339812000104'
or doador = 'JULIANA FERREIRA BORGES' 
or doador LIKE 'PAULO ODEBRECHT%'
or doador LIKE '%BRASKAL EMBALAG%' 
or doador LIKE 'BRASKIT%' 
or doador LIKE  'LUCIANO ODEB%'
or doador = 'LUCIANO TEIXEIRA ODEB%'
or doador = 'JOSE MIZAEL AVELAR ODEBRECHT'
or cpf_doador = '97924733272' # Marcelo Felberg hominimo
or doador =  'EDUARDO ODEBRECHT' 
or doador = 'ODEBRECHT COM E IND DE CAFE LTDA' or cpf_doador = '78597150000111' or doador LIKE 'ODEBRECHET COM. E IND. DE CAFE%'
or doador = 'FLAVIO APARECIDO PERES' or cpf_doador = '97580929872' 
or doador = 'CARIOCA CHRISTIANI NIELSEN ENGENHARIA S A' 
or doador =  'SIDIANA MARIA KIEPPER'
or doador LIKE 'BRASKARKE%'
or doador LIKE 'BRASKARNE%'
or doador = 'CARLÃO DA SANEATINS'
# Quattor só foi comprada pela Odebrecht em 2010
or (ano < '2010' AND cpf_doador = '04705090000177')
#Suzano Petroquimica comprada em 2007
or (ano < '2007' AND cpf_doador = '04705090000258')
#Antes de 2002 nao temos CPF
or (doador LIKE 'ANTONIO DE CASTRO%' and ano < '2000')
# PETIÇÃO 6.694  mostra que esquema com Petropolis começou em 2008
or (doador LIKE 'CERVEJARIA PETR%' and ano < '2007')
# Removo o que nao é do Grupo Itaipava (Praiamar)
or cpf_doador = '05278890000111'
or doador = 'PRAIAMAR HOTEL'
or doador = 'PRAIAMAR EMPREENDIMENTOS TURISTICOS LTDA'; 