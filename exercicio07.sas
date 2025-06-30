/*
Exercício 7 - LOWCASE
Converter string para minúsculas.LOWCASE(variavel);
*/

DATA exerc_lowcase;
  nome = 'WILLIAM ROSARIO';
  nome_minusculo = LOWCASE(nome);
RUN;

DATA exerc_procase;
  nome = 'william rosario';
  nome_procase = PROPCASE(nome);
RUN;