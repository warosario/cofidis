/*
Exercício 31 - COALESCE
Retorna o primeiro valor não-nuloCOALESCE(variaveis);
*/

DATA exerc_coalesce;
	a=5;
	b=.;
	c=72;
	resultado = COALESCE(a,b,c);
RUN;