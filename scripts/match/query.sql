USE tse;

# Geral
SELECT 
grupodb.id,
grupodb.uf,
grupodb.partido,
grupodb.cargo,
grupodb.candidato,
grupodb.numero,
grupodb.ano,
grupodb.cpf_candidato,
grupodb.doador,
grupodb.doador_original,
grupodb.doador_norm,
grupodb.cpf_doador,
grupodb.cpf_doador_original,
grupodb.recurso,
grupodb.data,
grupodb.setor_economico,
grupodb.motivo,
grupodb.valor,
grupodb.valor_at,
grupodb.dolar,
grupodb.tipo
FROM grupodb
INTO OUTFILE '/var/lib/mysql-files/geral.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


SELECT id, uf, partido, cargo, candidato, ano, doador_norm, dolar 
FROM grupodb
INTO OUTFILE '/var/lib/mysql-files/table-dolar.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

