/*
Exercício 17 - ROUND
Arredondar o valor para o múltiplo especificado.ROUND(variavel, casas decimais);A=10.23 | Round = 0,1
*/
DATA exerc_around;
	a=10.2345;
	arrend = ROUND(A,0.1);
RUN;