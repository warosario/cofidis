/*
Exercício 43
Criar um indice unico (unique) para a tabela formacao.clientes , coluna cliente_id.
*/

/*criar o index unique*/
proc datasets lib=formacao;
  modify clientes;
  index create cliente_id / unique;
quit;

/*verificar os index*/
proc contents data= formacao.clientes;
run;

/*consultar a tabela pelo nome do index*/
data clientes_filtrados;
  set formacao.clientes(idxname=cliente_id);
  where cliente_id = 1234;
run;

/*deletar index nominal*/
proc datasets lib=formacao nolist;
  modify clientes;
  index delete cliente_id;
quit;

/*deletar todos os index*/
proc datasets lib=formacao nolist;
  modify clientes;
  index delete _all_;
quit;