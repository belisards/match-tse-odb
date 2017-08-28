USE tse; 

#BLACKLISTS: remove

DELETE FROM laranjas
WHERE 
 (doador_norm LIKE '%PETR%' and ano < '2007')
 or cpf_doador = '05278890000111'
 or doador LIKE 'PRAIAMAR EMPREENDIMENTOS%'
 or doador LIKE 'PRAIAMAR HOTEL%'
 or doador LIKE '%GASOLEOS PRAIAMAR%'
 or doador LIKE 'odebrismar%'
 or doador like 'EDENILIO FERREIRA%';

DELETE FROM grupodb
WHERE 
doador like 'saneaqua equipamen%' or
doador_original like 'saneaqua equipamentos%' or
doador =  'DANIEL FERREIRA LIMA' 
or doador = 'JOAO BARBOSA FILHO' OR cpf_doador = '01261568087' 
# José de Carvalho de Filho
or cpf_doador = '22885773804' or cpf_doador = '80503659991' 
or doador = 'RENATO ALVES VALE' 
or cpf_doador = '08545543786' or cpf_doador = '15945487000152'
# Luciano Alves da Cruz
# Wrong CNPJ
or cpf_doador = '75057299000110'
# Sergio Luiz Neves 
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
or doador =  'SIDIANA MARIA KIEPPER'
or doador LIKE 'BRASKARKE%'
or doador LIKE 'BRASKARNE%'
or doador LIKE 'ODEBRISM%'
or doador = 'CARLÃO DA SANEATINS'
# Odebrecht buys Quattor in 2010
or (ano < '2010' AND cpf_doador = '04705090000177')
# Buys Suzano Petroquimica in 2007
or (ano < '2007' AND cpf_doador = '04705090000258')
or (doador LIKE 'ANTONIO DE CASTRO%' and ano < '2000')
or (doador LIKE '%QUATTOR%' and ano < '2009')
or (doador like 'mectron%' and ano < "2011")
or (doador like '%petroflex%' and ano < "2007")
or ((doador like 'copesul%' or cpf_doador like '89611909%') and ano < "2008")
or doador like 'cobrape%'
or doador like 'recopesul comercio%';