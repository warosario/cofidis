/*
Exercício 1 - SUBSTR

Extrair o primeiro nome.SUBSTR(variavel, inicio, fim)
*/

DATA exerc_substr;
  nome = 'William Rosario';
  primeiro_nome = SUBSTR(nome,1,7);
RUN;