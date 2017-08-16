USE tse;

# Geral
SELECT 
grupodb.id,
grupodb.uf,
grupodb.partido,
grupodb.cargo,
grupodb.candidato,
grupodb.ano,
grupodb.cpf_candidato,
grupodb.doador,
grupodb.doador_original,
grupodb.doador_norm,
grupodb.cpf_doador,
grupodb.cpf_doador_original,
grupodb.recurso,
grupodb.data,
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

SELECT uf, partido, cargo, candidato, ano, sum(dolar) as valor
FROM grupodb
WHERE ano > '2001' and tipo = 'candidato'
GROUP BY uf, partido, cargo, candidato, ano
ORDER BY valor DESC
INTO OUTFILE '/var/lib/mysql-files/table-dolar.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SELECT candidato
FROM grupodb
WHERE candidato NOT LIKE 'Comit%' or candidato NOT LIKE 'Direção%'
and ano > '2001' and tipo = 'candidato'
GROUP BY candidato
ORDER BY candidato ASC
INTO OUTFILE '/var/lib/mysql-files/candidatos.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SELECT *
FROM grupodb
WHERE ano = '2014' and (doador like 'cbpo%' or doador_original like 'cbpo%')
INTO OUTFILE '/var/lib/mysql-files/2014.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';