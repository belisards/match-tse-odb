USE tse;

/*
WHITE LIST
 ISMAEL CAMPOS DE ABREU
 ALEXANDRINO DE SALES RAMOS DE ALENCAR
 FABIO ANDREANI GANDOLFO
 LUIZ ANTONIO SCHNEIDER ALVES DE ALMEIDA
 PAULO RICARDO BAQUEIRO DE MELO
 JOAO GOUVEIA FERRAO NETO
 PEDRO AUGUSTO CARNEIRO LEAO	17482755420
 RUY LEMOS SAMPAIO	00648841553
 Sérgio Luis Neves
 BLACLKLIST
*/

DELETE FROM grupodb
WHERE 

doador =  'DANIEL FERREIRA LIMA'  # Falta CPF de Daniel Ferreira Lima, da ODEPREV.
or doador = 'JOAO BARBOSA FILHO' OR cpf_doador = '01261568087' 
# João Barbosa Filho
or cpf_doador = '22885773804' or cpf_doador = '80503659991' # José de Carvalho de Filho
or doador = 'RENATO ALVES VALE' # está sem cpf_doador
or cpf_doador = '08545543786' or cpf_doador = '15945487000152' # hom Luciano Alves da Cruz

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
or doador = 'ODEBRECHT COM E IND DE CAFE LTDA' or cpf_doador = '78597150000111'
or doador = 'FLAVIO APARECIDO PERES' or cpf_doador = '97580929872' 
or doador = 'CARIOCA CHRISTIANI NIELSEN ENGENHARIA S A' 
or doador =  'SIDIANA MARIA KIEPPER'
or doador LIKE 'BRASKARKE%'
# Quattor só foi comprada pela Odebrecht em 2010
or (ano < '2010' AND cpf_doador = '04705090000177')
#Suzano Petroquimica comprada em 2007
or (ano < '2007' AND cpf_doador = '04705090000258'); 
 
# Regulariza

UPDATE grupodb
SET doador = 'CNO'
WHERE cpf_doador LIKE '15102288%' or doador LIKE 'CONSTRUTORA NORBERTO%';

UPDATE grupodb
SET doador = 'Braskem'
WHERE cpf_doador LIKE '42150391%';

update grupodb
set doador = doador_original
where doador_original is not null and doador_original <> '';

### Correção monetária
UPDATE `grupodb` SET `valor_at` = CASE
  	WHEN ano = 1994 THEN valor * 7.01399555092
    WHEN ano = 1998 THEN valor * 3.30783660603
    WHEN ano = 2000 THEN valor * 2.9469836327
    WHEN ano = 2002 THEN valor * 2.54338537892
    WHEN ano = 2004 THEN valor * 2.0799195046
    WHEN ano = 2006 THEN valor * 1.86807096785
    WHEN ano = 2008 THEN valor * 1.70558593805
    WHEN ano = 2010 THEN valor * 1.54809714061
    WHEN ano = 2012 THEN valor * 1.37732840188
    WHEN ano = 2014 THEN valor * 1.21967315647
    WHEN ano = 2016 THEN valor * 1.02875495291
    ELSE `valor_at`
    END;

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
grupodb.tipo
FROM grupodb
INTO OUTFILE '/var/lib/mysql-files/geral.csv'
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

