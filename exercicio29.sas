/*
Exercício 29 - IFN
Retorna valor baseado em condição (numérico).IFN(condição,resultado1, resultado2);
*/

DATA exerc_ifn;
	nota=8;
	status=IFN(nota>7, 1, 0);
RUN;

DATA WORK.NOTAS;
NOTA = 8;
RUN;

PROC SQL;

CREATE TABLE exerc_ifn_procsql as 
SELECT NOTA, CASE WHEN ( nota > 7) THEN 1 ELSE 0 END AS STATUS FROM WORK.NOTAS;

QUIT;
