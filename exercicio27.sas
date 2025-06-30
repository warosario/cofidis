/*
Exercício 27 - PUT
Converte valor numérico para texto (com formato).PUT(variavel,formato);
*/

DATA exerc_put;
	idade=100;
	idade_formatado=PUT(idade,20.);
	FORMAT idade best3.; 
RUN;