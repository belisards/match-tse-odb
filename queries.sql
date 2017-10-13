
############################
## 

## CONNECTAS
##
############################


# Total
select sum(dolar) from o;
select sum(valor_at) from o;

# Total de empresas
select cpf_doador_original  from grupodb where length(cpf_doador_original ) > '11' and  (cpf_doador_original <> '' or cpf_doador_original IS NOT NULL) group by cpf_doador_original;

# Total de políticos 
select cpf_candidato from grupodb where ano > '2000' and tipo = 'candidato' and length(cpf_candidato) < '12' and cpf_candidato <> '' group by cpf_candidato;

# Total de entradas no TSE
select count(id) from doacoes where ano > '2000';

# Total de pessoas e empresas
select doador_norm from grupodb where ano >  '2000' group by doador_norm ;
select doador_norm, sum(valor_at) as valor from grupodb where ano >  '2000' group by doador_norm  order by valor desc;

# Total por partido
select partido, sum(dolar) as valor from o group by partido order by valor desc;
select partido, sum(valor_at) as valor from grupodb where ano = '2014' group by partido order by valor desc;
select partido, sum(valor_at) as valor from grupodb where ano = '2014' and tipo <> 'Candidato' group by partido order by valor desc;

# N. total de doação da Odb
select count(id) from grupodb where ano > '2000';

# Total Braskem + Construtora
 select sum(dolar) as valor from o where doador_norm like 'const%' or doador_norm like 'bras%';

 # Total por tipo
 select tipo, sum(dolar) from o group by tipo;
 select tipo, sum(valor_at) from o group by tipo;

 # Total por forma de pagamento
select recurso, sum(dolar) as d from o group by recurso order by d desc;
select recurso, sum(valor_at) as d from o group by recurso order by d desc;

# Total Odebrecht 
select cpf_doador from grupodb where length(cpf_doador) > '11' and  (cpf_doador_original = '' or cpf_doador_original IS NULL) group by cpf_doador;

select cpf_doador_original  from grupodb where length(cpf_doador_original ) > '11' and  (cpf_doador_original <> '' or cpf_doador_original IS NOT NULL) group by cpf_doador_original ;

select cpf_doador  from grupodb where length(cpf_doador_original ) > '11' and  (cpf_doador_original <> '' or cpf_doador_original IS NOT NULL) group by cpf_doador;

select doador_original , cpf_doador_original  from grupodb where length(cpf_doador_original ) > '11' and  (cpf_doador_original <> '' or cpf_doador_original IS NOT NULL) group by doador_original , cpf_doador_original ;

# Total por ano
select ano, sum(dolar) from o group by ano;

# Total financiamento de campanha em 2014
select sum(valor_at) from doacoes where ano = '2014' and doador_original = '' and recurso NOT LIKE 'Estim%';

# Odebrecht 2014
select sum(valor_at) from o where ano = '2014' and recurso NOT LIKE 'Estim%';

# Total por candidatos
select candidato, sum(dolar) as d from grupodb where ano > '2000' and tipo = 'candidato' group by candidato order by d desc limit 5;
select candidato, sum(valor_at) as d from grupodb where ano > '2000' and tipo = 'candidato' group by candidato order by d desc limit 5;


# Total por partido 2014
 select partido, sum(dolar) as d from grupodb where ano = '2014' and tipo <> 'candidato' group by partido order by d desc limit 5;

 select partido, sum(valor_at) as v from grupodb where ano = '2014' and tipo <> 'candidato' group by partido order by v desc limit 5;

 # Total por UF
 select uf, sum(dolar) as d from o group by uf order by d desc limit 5;

 # Total para o Temer
select * from grupodb where candidato like '%TEMER LULIA%';

 # Total para o Marina
select * from grupodb where candidato like '%OSMARINA MARINA%';

# Total por laranjas
select sum(valor_at) from laranjas where doador_original  = '' or doador_original IS NULL and ano > '2007';
select sum(dolar) from laranjas where doador_original  = '' or doador_original IS NULL and ano > '2008';

# Total entre 2008 e 2014
select sum(valor_at) from o where ano > '2007' and ano < '2015';
select sum(dolar) from o where ano > '2007' and ano < '2015';
select tipo, sum(valor) from o where ano > '2007' and ano < '2015' group by tipo;

############################
## 
## MATÉRIA 2016
##
############################

# Total 2016

select sum(valor) from o where ano = '2016';
select * from o where ano = '2016';
select sum(valor) from doacoes where cpf_candidato like '56583400553' and ano = '2016';





############################
## 
## MATÉRIA 1990
##
############################
# Total por partido
select partido, sum(valor_at) as v from grupodb where ano < '2000' and cargo not like 'govern%' group by partido order by v desc;

# Total excluindo principais
select sum(valor_at) as v from grupodb where ano < '2000' and cargo not like 'govern%' and partido <> 'dem' and partido <> 'psdb' and partido <> 'pmdb';

# Total oposição
select sum(valor_at) as v from grupodb where ano < '2000' and cargo not like 'govern%' and (partido = 'pt' or partido = 'psb' or partido = 'pdt');

# Total
 select sum(valor_at) as v from grupodb where ano < '2000' and cargo not like 'govern%';


# Total PT 
 select sum(valor_at) from grupodb where partido = 'pt' and cargo not like 'govern%' and ano < '2000';
select * from grupodb where partido = 'pt' and cargo not like 'govern%' and ano < '2000'

# Total período Lula - principais partidos
select partido, sum(valor_at) from o where (partido = 'psdb' or partido = 'pmdb' or partido = 'pfl' or partido = 'dem' or partido= 'pt') and (ano > '2003' and ano < '2015') and (cargo like 'pres%' or cargo like 'senad%' or cargo like 'deputado fede%') group by partido;

# Total período Lula
select sum(valor_at) from  o where (partido = 'psdb' or partido = 'pmdb' or partido = 'pfl' or partido = 'dem' or partido = 'pt') and (ano > '2003' and ano < '2015') and (cargo like 'pres%' or cargo like 'senad%' or cargo like 'deputado fede%') ;



############################
## 
## MATÉRIA GERAL
##
############################

# Total
select sum(valor_at) from o;

# Candidatos
select cpf_candidato from grupodb where ano > '2000' and tipo = 'candidato' and length(cpf_candidato) < '12' and cpf_candidato <> '' group by cpf_candidato;

# Total de registros
select count(id) from doacoes where ano > '2000';

#
# TOP 5 Candidatos beneficiados
select candidato, sum(valor_at) as d from grupodb where ano > '2000' and tipo = 'candidato' group by candidato order by d desc limit 5;
