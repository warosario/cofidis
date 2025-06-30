/*
Exercício 4 - TRIM
Remover espaços à direita.TRIM(variavel) 
*/

DATA exerc_trim;
  texto = 'SAS Studio  ';
  ajustado = TRIM(texto);
RUN;

/*SAS Studio*/

DATA exerc_strip;
  texto = '   SAS Studio  ';
  ajustado = STRIP(texto);
RUN;

/*SAS Studio*/