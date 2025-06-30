/*
Exercício 19 - TODAY
Retorna a data atual.TODAY();
*/

DATA exerc_today;
	hoje=today();
	amanha=today()+1;
	FORMAT hoje ddmmyy10. amanha date9. ;
RUN;