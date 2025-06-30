/*
Exercício 40
Ordenar clientes por estado, depois cidade, depois nome (todas ascendente):
Ordenar clientes por estado (descendente), depois cidade (ascendente):
Remover registros duplicados com base nas variáveis nome e cidade (mantém a primeira ocorrência):
Remover registros completamente duplicados (em todas as colunas):
Ordenar usando o método tagsort (útil em muitos dados duplicados), por estado:
Ordenar por nome usando regras Unicode (ex: acentos corretamente ordenados):
*/

/*1*/
proc sort data=formacao.clientes out=clientes_ordenado;
   by estado cidade nome;
run;

proc sql; 
create table clientes_ordenado as 
select * from formacao.clientes order by estado, cidade, nome; 
quit; 

/*2*/
proc sort data=formacao.clientes out=clientes_desc;
   by descending estado cidade;
run;

proc sql; 
create table clientes_desc as 
select * from formacao.clientes order by estado desc, cidade asc; 
quit; 

/*3*/
proc sort data=formacao.clientes out=clientes_sem_duplicatas nodupkey;
   by nome cidade;
run;

proc sql; 
create table clientes_sem_duplicatas as 
select distinct nome, cidade, estado 
from formacao.clientes 
order by nome, cidade; 
quit; 

/*4*/
proc sort data=formacao.clientes out=clientes_sem_duplicatas_exatas nodup;
   by _all_;
run;

proc sql; 
create table clientes_sem_duplicatas_exatas as 
select distinct * from formacao.clientes order by nome, cidade, estado; 
quit;

/*5*/
proc sort data=formacao.clientes out=clientes_tagsort tagsort;
   by estado;
run;

/* Não aplicável em PROC SQL pois método de ordenação é interno do SAS */

/*6*/
proc sort data=formacao.clientes out=clientes_unicode sortseq=unicode;
   by nome;
run;

/* Não aplicável em PROC SQL, depende do collation do banco de dados*/