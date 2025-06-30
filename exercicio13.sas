/*Exercício 13 - SUM
Somar os valores, ignorando valores faltantes.SUM(variaveis);A=10 , B=. e C=30
*/
DATA exerc_sum;
	a=10;
	b=.;
	c=30;
	SOMA = SUM(A,B,C);
RUN;