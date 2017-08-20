USE tse;

CREATE OR REPLACE VIEW topdoa
AS
select doador_norm, sum(valor) as valor from grupodb 
where doador_original is null or doador_original  = '' 
group by doador_norm order by valor desc;

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
WHERE doador_original IS NULL or doador_original = ''
INTO OUTFILE '/var/lib/mysql-files/geral.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SELECT uf, partido, cargo, candidato, ano, sum(dolar) as valor
FROM grupodb
WHERE ano > '2001' and tipo = 'candidato' and (doador_original IS NULL or doador_original = '')
GROUP BY uf, partido, cargo, candidato, ano
ORDER BY valor DESC
INTO OUTFILE '/var/lib/mysql-files/table-dolar.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SELECT candidato
1FROM grupodb
WHERE candidato NOT LIKE 'Comit%' or candidato NOT LIKE 'Direção%'
and ano > '2001' and tipo = 'candidato'
GROUP BY candidato
ORDER BY candidato ASC
INTO OUTFILE '/var/lib/mysql-files/candidatos.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

