title "Total de Vendas por Produto";
proc sgplot data=formacao.pedidos;
  where cliente_id = 311579;
  vbar produto / response=valor stat=sum datalabel; 
run;


/*
proc sgplot: inicia o procedimento para criar gráficos.
data=formacao.pedidos: usa a tabela pedidos da biblioteca formacao.
where cliente_id = 311579: filtra os dados para apenas o cliente.
vbar produto: cria um gráfico de barras verticais com a variável produto no eixo X.
response=valor: usa a variável valor como altura das barras.
stat=sum: soma os valores de cada produto.
datalabel: exibe os valores em cima de cada barra.
title: define o título do gráfico.
run: executa o bloco de código.
*/

















proc sql;
  create table pedidos_cidade as
  select c.cidade, count(p.pedido_id) as total_pedidos
  from formacao.pedidos p
  inner join formacao.clientes c on p.cliente_id = c.cliente_id
  where c.estado = 'ES' and c.cidade in ( 'Almeida','Alves','Araújo')
  group by c.cidade;
quit;

proc sgplot data=pedidos_cidade;
  vbar cidade / response=total_pedidos;
run;

proc sgplot data=formacao.clientes;
  vbar estado / stat=freq datalabel;
  title "Quantidade de Clientes por Estado";
run;
