/*
Exercício 2 - SCAN
Obter uma palavra específica da string.SCAN(variavel, posicao,”busca”) 
*/

DATA exerc_scan;
  endereco ='Rua das Palmeiras,123 Centro';
  rua = SCAN(endereco,1,',');
  prefixo = SUBSTR(rua,1,3);
RUN;
