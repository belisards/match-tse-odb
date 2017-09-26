USE tse;

CREATE OR REPLACE VIEW topdoa
AS
select doador_norm, sum(valor_at) as valor from o 
group by doador_norm order by valor desc;

CREATE OR REPLACE VIEW o
AS
select * from grupodb 
where (doador_original is null or doador_original  = '') and ano > '2000' ;


# Third-party donations
SELECT 
laranjas.id,
laranjas.uf,
laranjas.partido,
laranjas.cargo,
laranjas.candidato,
laranjas.ano,
laranjas.cpf_candidato,
laranjas.doador,
laranjas.doador_original,
laranjas.doador_norm,
laranjas.cpf_doador,
laranjas.cpf_doador_original,
laranjas.recurso,
laranjas.data,
laranjas.motivo,
laranjas.valor,
laranjas.valor_at,
laranjas.dolar,
laranjas.tipo
FROM laranjas
ORDER BY laranjas.id
INTO OUTFILE '/var/lib/mysql-files/laranjas.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


# All donations
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
grupodb.fonte,
grupodb.tipo
FROM grupodb
ORDER BY grupodb.id
INTO OUTFILE '/var/lib/mysql-files/geral.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


# Table for web-view
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

select doador_norm from grupodb group by doador_norm
INTO OUTFILE '/var/lib/mysql-files/doadores.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


select partido, sum(valor) as valor from grupodb 
group by partido 
order by valor desc
INTO OUTFILE '/var/lib/mysql-files/partidos.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


# Only direct donations
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
WHERE (doador_original IS NULL or doador_original = '') and ano > '2001'
ORDER BY grupodb.id
INTO OUTFILE '/var/lib/mysql-files/direta.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
