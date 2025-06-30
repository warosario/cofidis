/*
Exercício 30 - IFC
Retorna valor baseado em condição (texto).IFC(condição,resultado1, resultado2);
*/

DATA exerc_ifc;
	nota=8.5;
	status=IFC(nota>7.5,'POSITIVO','NEGATIVO' );
RUN;

DATA WORK.NOTAS;
NOTA = 8;
RUN;

PROC SQL;

CREATE TABLE exerc_ifc_procsql as 
SELECT NOTA, 
       CASE WHEN ( nota > 8) THEN 'POSITIVO' ELSE 'NEGATIVO' END AS STATUS 
  FROM WORK.NOTAS;
QUIT;


PROC SQL;

CREATE TABLE exerc_ifn_procsql as 
SELECT id, ano,
       CASE WHEN ( nota_final > 8) THEN 'POSITIVO' ELSE 'NEGATIVO' END AS STATUS 
  FROM formacao.avaliacoes_funcionarios;
QUIT;

DATA exerc_ifc;
set formacao.avaliacoes_funcionarios;
	status=IFC(nota_final>7.5,'POSITIVO','NEGATIVO' );
RUN;