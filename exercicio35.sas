/*
Exercício 35
FIRST. / LAST.Escreva uma consulta para selecionar a primeira e a última data de pedido de cada cliente.
*/

proc sql;
  create table exerc_firstlast_sql as
  select cliente_id, 
  min(data_pedido) format=ddmmyy10. as primeira_compra,
  max(data_pedido) format=ddmmyy10. as utlima_compra 
  from formacao.pedidos
  group by cliente_id;
quit;
/*1	02/12/2019	18/11/2021*/

proc sort data=formacao.pedidos out=pedidos_ordenado;
  by cliente_id data_pedido;
run;

data exerc_firstlast (keep=cliente_id primeira_compra ultima_compra);
  set pedidos_ordenado;
  by cliente_id;

  format primeira_compra ultima_compra ddmmyy10.;

  retain primeira_compra ultima_compra;

  if first.cliente_id then do;
    primeira_compra = data_pedido;
  end;

  ultima_compra = data_pedido;

  if last.cliente_id then output;
  
run;
/*1	02/12/2019	18/11/2021*/

