USE tse;


# Regulariza nomes
UPDATE grupodb
SET doador_norm = 'Construtora'
WHERE cpf_doador LIKE '15102288%' 
or doador LIKE 'NORBERTO ODEBRECHT S.A%'
or (doador not like 'CETREL%' and doador like 'C%'  );

UPDATE grupodb
SET doador_norm = 'Braskem'
WHERE cpf_doador LIKE '42150391%'
or doador like 'Braske%'
or doador like 'BRASKE%';

UPDATE grupodb
SET doador_norm = 'Quattor'
WHERE doador LIKE 'Quattor%' or doador LIKE 'Quattar%';

UPDATE grupodb
SET doador_norm = 'O. Realizações Imobiliárias'
WHERE doador LIKE 'Odebrecht Reali%'
or doador LIKE 'ODEBRECHT REAL%';

UPDATE grupodb
SET doador_norm = 'O. Agroindustrial'
WHERE doador LIKE 'Odebrecht Agro%'
or doador LIKE 'ODEBRECHT AGROI%';

UPDATE grupodb
SET doador_norm = 'O. Ambiental'
WHERE doador LIKE 'ODEBRECHT AMBIENTAL%';

UPDATE grupodb
SET doador_norm = 'Pedro Carneiro Leão'
WHERE doador LIKE 'PEDRO AUGUS%';

UPDATE grupodb
SET doador_norm = 'Alexandrino Alencar'
WHERE doador LIKE 'Alexandrino de%';

UPDATE grupodb
SET doador_norm = 'Embraport'
WHERE doador LIKE 'EMBRAP%';

UPDATE grupodb
SET doador_norm = 'Enseada Ind. Naval'
WHERE doador LIKE 'ENSEADA%' or doador LIKE 'ESTALEIRO%';

UPDATE grupodb
SET doador_norm = 'ETH'
WHERE doador LIKE 'ETH%';

UPDATE grupodb
SET doador_norm = 'Ismael Campos'
WHERE doador LIKE 'Ismael Campos%';

UPDATE grupodb
SET doador_norm = 'Ruy Lemos'
WHERE doador LIKE 'RUI LEMOS%' or doador LIKE 'RUY LEMOS%';

UPDATE grupodb
SET doador_norm = 'O. Óleo e Gás' 
WHERE doador LIKE 'ODEBRECHT OLEO%' or doador LIKE 'ODERBRECHT OLE%' or doador LIKE 'ODEBRECH OLEO%' or doador LIKE 'ODEBRECHT ÓLEO%';

UPDATE grupodb
SET partido = 'DEM' 
WHERE partido = ' PFL';

# Copia o campo doador original para o campo doador, quando existir
update grupodb
SET doador_norm = doador_original
where doador_original is not null and doador_original <> '';

UPDATE grupodb SET `doador_norm` = UPPER( `doador` );

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

SELECT doador 
FROM grupodb
GROUP by doador
INTO OUTFILE '/var/lib/mysql-files/grupo.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


SELECT id, uf, partido, cargo, candidato, ano, doador, dolar 
FROM grupodb
INTO OUTFILE '/var/lib/mysql-files/table-dolar.csv'
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

