USE tse;

### Correção monetária
UPDATE `doacoes` SET `valor_at` = CASE
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

# Converte para dolar
    UPDATE `doacoes` SET `dolar` = valor_at / 3.2;