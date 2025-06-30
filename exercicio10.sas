/*
Exercício 10 - TRANWRD
Substitui todas as ocorrências de uma substring por outra. TRANWRD(variavel,”parametro1”, ”parametro2”);
*/

DATA exerc_tranwrd;
  endereco ='Rua das Flores';
  resultado = TRANWRD(endereco,'Rua','Av');
RUN;