/*
Exercício 46
PROC REPORT – Criar um relatório tabular simples mostrando a quantidade de clientes por estado:
*/

proc report data=formacao.clientes nowd;
  column estado n;
  define estado / group 'Estado';
  define n / 'Quantidade de Clientes';
run;

/* Explicação
proc report data=formacao.clientes nowd; -> Inicia o PROC REPORT com a tabela formacao.clientes.  O nowd ativa o modo linha de comando, ou seja, sem a janela interativa (WINDOWS).
column estado n; -> Define as colunas que irão aparecer no relatório.  estado será agrupado e n representa a contagem automática de linhas (frequência) por grupo.
define estado / group 'Estado';-> Diz ao SAS para agrupar por estado (similar a GROUP BY no SQL).  O rótulo da coluna será “Estado”.
define n / 'Quantidade de Clientes'; -> Define que a coluna n será usada apenas como exibição e dá o rótulo “Quantidade de Clientes”.  Como n não é uma variável real, o SAS entende que é o número de observações por grupo.
run; ->Executa o relatório.
*/

/*EXTRAS*/
proc report data=formacao.clientes nowindows;
  column estado n;
  define estado / group 'Estado';
  define n  / 'Total de Clientes';

  rbreak after / summarize; 
  compute after;
    line 'Fim do relatório de clientes por estado.';
  endcomp;
run;

/*EXTRAS*/

PROC SORT DATA=formacao.clientes OUT=clientes_ordenado;
  BY estado;
RUN;

DATA clientes_por_estado;
  SET clientes_ordenado;
  BY estado;

  IF FIRST.estado THEN total = 0;
  total + 1;

  IF LAST.estado THEN OUTPUT;
  IF LAST.estado THEN PUT "Estado: " estado @20 "Total de clientes: " total;
  
  KEEP estado total;
RUN;

proc report data=clientes_por_estado;
  column estado total;
run;

/*EXTRAS*/

PROC SQL;
  SELECT estado,COUNT(1) FROM formacao.clientes GROUP BY estado;
QUIT;

/*EXTRAS*/

PROC SQL PRINT ;
  CREATE TABLE clientes_por_estado AS
  SELECT estado, COUNT(1) AS CONTADOR FROM formacao.clientes GROUP BY estado;
QUIT;

PROC PRINT DATA=clientes_por_estado NOOBS LABEL;
  VAR estado CONTADOR;
  LABEL
    estado = "Estado"
    CONTADOR  = "Quantidade de Clientes";
  TITLE "Quantidade de Clientes por Estado";
RUN;

/*EXTRAS*/

PROC FREQ DATA=formacao.clientes ;
  TABLES estado / OUT=clientes_por_estado(KEEP=estado COUNT);
RUN;

DATA _NULL_;
  SET clientes_por_estado;
  PUT "Estado: " estado @20 "Quantidade: " count;
RUN;