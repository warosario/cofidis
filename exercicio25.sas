/*
Exercício 25 - MONTH
Extrai o mês.MONTH();
*/

DATA exerc_month;
	dnasc = '26JUL1984'd;
    mes_nasc = month(dnasc);
    FORMAT dnasc date9.;
RUN;