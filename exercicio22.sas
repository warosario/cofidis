/*
Exercício 22 - INTCK
Conta intervalos entre datas.INTCK();
*/
DATA exerc_intck;
	dnasc = '26JUL1984'd;
	hoje=today();
	idade = int(INTCK('day',dnasc,hoje)/365);
	FORMAT dnasc hoje date9.;
RUN;