/*
Exercício 3 – INDEX
Encontrar a posição de uma substring. INDEX(variavel,”busca”)
*/

DATA exerc_index;
  frase = 'Entrega em São Paulo';
  posicao = INDEX(frase,'São');
  final = LENGTH(frase);
  cidade = SUBSTR(frase,posicao,final);
RUN;