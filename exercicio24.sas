/*
Exercício 24 - YEAR
Extrai o ano.YEAR ();
*/
DATA exerc_year;
	dnasc = '26JUL1984'd;
    ano_nasc = year(dnasc);
    FORMAT dnasc date9.;
RUN;