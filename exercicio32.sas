/*
Exercício 32 - COMPRESS
Remove caracteres de uma stringCOMPRESS(variaveis);
*/

DATA exerc_compress;
 nome ='William-Rosario';
 nome_limpo = COMPRESS(nome, '-');
RUN;