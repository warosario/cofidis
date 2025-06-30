/*
Exercício 44
Criar uma tabela chamada pedidos_compress, utilizando a compressão = yes , e verificar a diferença de tamanho com a original.
*/

/*verifica o tamanho da tabela*/
proc contents data= formacao.pedidos;
run;
/* File Size (bytes) = 48365568*/

/*compress all*/
data formacao.pedidos_compressyes(compress=yes);
  set formacao.pedidos;
run;
/*Compressing data set FORMACAO.PEDIDOS_COMPRESSYES increased size by 19.29 percent.*/


/*compress binary*/
data formacao.pedidos_compressbinary(compress=binary);
  set formacao.pedidos;
run;
/*Compressing data set FORMACAO.PEDIDOS_COMPRESSBINARY increased size by 37.50 percent.*/

/*compress char*/
data formacao.pedidos_compresschar(compress=char);
  set formacao.pedidos;
run;
/*Compressing data set FORMACAO.PEDIDOS_COMPRESSCHAR increased size by 19.29 percent.*/

