/*
Exercício 28 - INPUT
Converte texto para valor numérico ou data.INPUT(variavel,formato);
*/

DATA exerc_input;
	idade_formatado='100' ;
	idade=INPUT(idade_formatado,3.);
	FORMAT idade best3.; 
RUN;