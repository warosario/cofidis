/*PROC LOGISTIC – Churn / Evento Binário

Objetivo do Exercício

Avaliar e modelar a probabilidade de ocorrência de um evento binário (como churn, compra, inadimplência, etc.) com base em variáveis explicativas, usando regressão logística no SAS.

O que é Esperado:

1. Preparar os dados
	•	Ter uma base de dados com uma variável dependente binária (evento_binario) com valores 0 e 1.
	•	Ter variáveis independentes que você acredita que explicam o evento: ex. idade, sexo, renda.

✔ Esperado:
	•	Um DATA com os campos necessários.
	•	Validação se há valores faltantes ou inconsistências.
*/

data meus_dados;
  input id_cliente idade sexo $ renda evento_binario;
  datalines;
1 25 M 3500 0
2 45 F 7000 1
3 33 F 5000 1
4 28 M 4200 0
5 60 F 10000 1
6 40 M 8000 0
;
run;

proc logistic data=meus_dados outmodel=modelo_log;
  class sexo (param=ref ref='M'); /* necessário para variáveis categóricas */
  model evento_binario(event='1') = idade sexo renda;
run;


/*
Explicações:
outmodel=modelo_log: salva o modelo em um objeto reutilizável.
sexo (param=ref ref='M'): usa codificação dummy (ref. masculina).
A variável dependente evento_binario deve conter 0 e 1.
*/

/*
Aplicar o Modelo a Novos Dados (Score) 
*/

proc logistic inmodel=modelo_log;
  score data=meus_dados out=meus_dados_com_score
        outroc=roc_data;
run;


/*
O que é gerado:
Dataset meus_dados_com_score com a coluna P_1 → probabilidade do evento = 1.
Opcional: outroc=roc_data → dados da curva ROC para avaliação.
*/

/*Juntar Resultados com os Dados Originais (opcional)*/

proc sql;
  create table analise_final as
  select a.*, b.P_1 as prob_evento
  from meus_dados a
  left join meus_dados_com_score b
  on a.id_cliente = b.id_cliente;
quit;
