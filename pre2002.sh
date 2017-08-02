#!/bin/bash
# = Dados Pre2002 =

url=http://leisenumeros.com.br/wp-content/uploads/2016/06/bruno-carazza-dados-de-doac3a7c3b5es-eleitorais-de-1994-e-1998-por-david-samuels-ajustados-por-bruno-carazza.xlsx
echo "=> Baixando arquivo de $url"
wget -O pre2002.xlsx "$url"
echo "=> Convertendo para CSV"
xlsx2csv pre2002.xlsx > pre2002.csv
echo "=> Extraindo doações da Odebrecht"
grep "ODEB" pre2002.csv > odbpre2002.csv

awk -F, '{if ($1 ~ /1994/) { print $0; }}' pre2002.csv > 1994.csv
awk -F, '{if ($1 ~ /1998/) { print $0; }}' pre2002.csv > 1998.csv
# 5 doações que somem assim