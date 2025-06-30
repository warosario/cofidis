/*
Exercício 8 - CATX
Concatenar strings com delimitador, ignorando valores em branco.CATX(“delimitador”,variavel1,variavel2);
*/

DATA exerc_catx;
	estado='SP';
	cidade='São Paulo';
	cep='12345-678';
	espaco=' ';
	endereco=CATX(' - ', estado, cidade, cep);
	endereco2= estado || espaco || cidade || espaco || cep;
RUN;

DATA exerc_concat_simples;
	estado='SP';
	cidade='São Paulo';
	cep='12345678';
	espaco=' ';
	endereco=CAT(estado, cidade, cep);
	endereco2= estado || espaco || cidade || espaco || cep;
	endereco3= estado || ' ' || cidade || ' ' || cep;
RUN;