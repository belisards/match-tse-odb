# -| Financiamento de campanha da Odebrecht |-

----
### O que é?

Trata-se de um script baseado no [Tribuna](https://github.com/rafapolo/tribuna), que identifica todos os financiamentos de campanha do grupo Odebrecht declarados ao Tribunal Superior Eleitoral desde 2002. O script é todo baseado em bash e SQL. Foi finalizado em julho de 2017. Em caso de alterações nos dados por parte do TSE, talvez seja necessário ajustes para que a identificação ocorra adequadamente.

----

### Como foi feito?

Inicialmente, a partir de fontes públicas e processo manuais e automatizados, foram relacionadas diversas empresas do grupo (considerando sedes e filiais) e seus respectivos sócios. Este mapeamento foi enriquecido com outras listagem, como a de delatores do grupo Odebrecht na Lava Jato, atas de reuniões, etc.

A solução do Tribuna foi adotado como método para tratamento dos dados do TSE. Assim, através de scripts SQL, é feita uma comparação (match) entre nomes, empresas e documentos mapeados com as doações declaradas. Posteriormente, outro script faz a exclusão de homônimos e resultados incertos para, enfim, gerar a listagem final de doações identificadas. A fim de padronizar o documento para a visualização dos dados, foram feitas transformações no campo de nome do doador no Open Refine.


---

### Quem?

O processo de análise dos dados e elaboração do scripts foi feito por Rafael Polo, Álvaro Turicas e Adriano Belisário.

Esta investigação foi apoiada pela [Connectas](http://connectas.org/).
