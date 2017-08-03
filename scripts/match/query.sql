USE tse;


# Regulariza nome Construtora
UPDATE grupodb
SET doador = 'Construtora'
WHERE cpf_doador LIKE '15102288%' 
or doador LIKE 'NORBERTO ODEBRECHT S.A%'
or (doador not like 'CETREL%' and doador like 'CONST%'  );

UPDATE grupodb
SET doador = 'Braskem'
WHERE cpf_doador LIKE '42150391%'
or doador like 'Braske%';

UPDATE grupodb
SET doador = 'Quattor'
WHERE doador LIKE 'Quattor%';

UPDATE grupodb
SET doador = 'O. Realizações Imobiliárias'
WHERE doador LIKE 'Odebrecht Reali%';

UPDATE grupodb
SET doador = 'O. Agroindustrial'
WHERE doador LIKE 'Odebrecht Agro%';

UPDATE grupodb
SET doador = 'Pedro Carneiro Leão'
WHERE doador LIKE 'PEDRO AUGUS%';

UPDATE grupodb
SET doador = 'Alexandrino Alencar'
WHERE doador LIKE 'Alexandrino de%';

UPDATE grupodb
SET doador = 'Embraport'
WHERE doador LIKE 'EMBRAPORT%';

UPDATE grupodb
SET doador = 'Enseada Ind. Naval'
WHERE doador LIKE 'ENSEADA%' or doador LIKE 'ESTALEIRO%';

UPDATE grupodb
SET doador = 'ETH'
WHERE doador LIKE 'ETH%';

UPDATE grupodb
SET doador = 'Ismael Campos'
WHERE doador LIKE 'Ismael Campos%';

UPDATE grupodb
SET doador = 'Ruy Lemos'
WHERE doador LIKE 'RUI LEMOS%' or doador LIKE 'RUY LEMOS%';

UPDATE grupodb
SET doador = 'O. Óleo e Gás'
WHERE doador LIKE 'ODEBRECHT OLEO%' or doador LIKE 'ODEBRECHT ÓLEO%';

update grupodb
set doador = doador_original
where doador_original is not null and doador_original <> '';


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

SELECT doador 
FROM grupodb
GROUP by doador
INTO OUTFILE '/var/lib/mysql-files/grupo.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


SELECT id, uf, partido, cargo, candidato, ano, dolar 
FROM grupodb
INTO OUTFILE '/var/lib/mysql-files/table.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

/*
# Total por doador
select distinct candidato from grupodb where candidato not like '%financeiro%' and candidato not like 'Direção%' group by candidato
INTO OUTFILE '/var/lib/mysql-files/doador.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

