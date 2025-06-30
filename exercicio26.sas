/*
Exercício 26 - DAY
Extrai o dia.DAY();
*/

DATA exerc_dia;
	dnasc = '26JUL1984'd;
    mes_nasc = day(dnasc);
    FORMAT dnasc date9.;
RUN;