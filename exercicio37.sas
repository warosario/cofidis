/*
Exercício 37
Combine as tabelas clientes e pedidos para exibir todos os pedidos feitos por clientes de uma cidade específica.
*/

proc sort data=formacao.clientes; by cliente_id; run;
proc sort data=formacao.pedidos;  by cliente_id; run;

/*inner join 100.084*/
data pedidos_por_produto;
   merge formacao.clientes(in=inc) formacao.pedidos(in=inp);
   by cliente_id;
   if inc and inp and produto = 'Notebook';
run;

proc sql;
   create table pedidos_por_produto as
   select *
   from formacao.clientes as c
   inner join formacao.pedidos as p
     on c.cliente_id = p.cliente_id
   where p.produto = 'Notebook';
quit;

/*left join = 1.015.884*/ 
data pedidos_por_produto_left;
   merge formacao.clientes(in=inc) formacao.pedidos(in=inp);
   by cliente_id;
   if inc;
run;

proc sql;
   create table pedidos_por_produto_left as
   select *
   from formacao.clientes as c
   left join formacao.pedidos as p
     on c.cliente_id = p.cliente_id;
quit;

/*right join = 1.000.000*/ 
data pedidos_por_produto_right;
   merge formacao.clientes(in=inc) formacao.pedidos(in=inp);
   by cliente_id;
   if inp;
run;

proc sql;
   create table pedidos_por_produto_right as
   select *
   from formacao.clientes as c
   right join formacao.pedidos as p
     on c.cliente_id = p.cliente_id;
quit;

/*fulll join = 1.015.884*/ 
data pedidos_por_produto_full;
   merge formacao.clientes(in=inc) formacao.pedidos(in=inp);
   by cliente_id;
   if inc or inp;
run;

proc sql;
   create table pedidos_por_produto_full as
   select *
   from formacao.clientes as c
   full join formacao.pedidos as p
     on c.cliente_id = p.cliente_id;
quit;




