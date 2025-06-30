/*
Exercício 12 - MEAN
Calcular a média dos valores, ignorando valores faltantes.MEAN(variaveis);A=10 , B=. e C=30
*/

DATA exerc_mean;
	a=10;
	b=.;
	c=30;
	media = MEAN(A,B,C);
RUN;