/*
Exercício 41
Criar para todas as datas das tabelas importadas “empregados” e “pedidos” com o formato YYYYMMDD.
*/

proc format;
   picture ddmmyyyy (default=8)
      low-high = '%0d%0m%Y' (datatype=date);
   picture yyyymmdd (default=8)
      low-high = '%0Y%0m%0d' (datatype=date);
run;

DATA EXERC41;
SET formacao.pedidos;
  /*DATA_PEDIDO2 = DATA_PEDIDO;*/
  FORMAT DATA_PEDIDO yyyymmdd. ;
RUN;

PROC SQL;
  CREATE TABLE EXERC41 AS 
  SELECT *, 
        DATA_PEDIDO FORMAT=yyyymmdd. AS DATA_PEDIDO2 
   FROM formacao.pedidos;
QUIT;

proc print data=formacao.pedidos (obs=100);
   format data_pedido yyyymmdd.;
run;

/*EXTRA*/ 

proc format;
   value $prefixsexo
      'F' = 'Sra.'
      'M' = 'Sr.';
run;

data empregados_formatado;
   set formacao.empregados;
   prefixo = put(sexo, $prefixsexo.);
   nome_completo = catx(' ', prefixo, nome);
run;

proc print data=empregados_formatado (obs=100);
   var nome_completo sexo nome;
run;
