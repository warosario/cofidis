/*
Exercício 49
PROC SGPLOT – Criar um gráfico de barra (vbar) que mostra a quantidade de clientes por estado:
*/
proc sgplot data=formacao.clientes;
  vbar estado / stat=freq datalabel;
  title "Quantidade de Clientes por Estado";
run;

/*
proc sgplot  data=clientes; Usa a tabela clientes para criar o gráfico.
vbar estado = Cria barras verticais para cada valor da variável estado.
stat=freq =Conta quantas vezes cada estado aparece (frequência).
datalabel = Mostra  o número de clientes acima de cada barra.
title = Define o título do gráfico.
run; = Executa o código.
*/

