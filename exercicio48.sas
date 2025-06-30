/*
Exercício 48
PROC TABULATE – Criar um relatório com o resumo estatístico das notas finais de avaliações de funcionários por ano e sexo da tabela de empregados:
*/

/* 1. Juntar as tabelas para obter ano, sexo e nota_final */
proc sql;
  create table avaliacoes_com_sexo as
  select 
    a.ano,
    e.sexo,
    a.nota_final
  from 
    formacao.avaliacoes_funcionarios as a
    inner join formacao.empregados as e
      on a.id = e.id
  ;
quit;

/* 2. Resumo estatístico das notas finais por ano e sexo | filtra o ano e gera por sexo */
proc tabulate data=avaliacoes_com_sexo;
  class ano sexo;
  var nota_final;
  table 
    ano,
    sexo,
    nota_final*(mean min max std n);
run;

/* 2. Resumo estatístico das notas finais por ano/sexo */
proc tabulate data=avaliacoes_com_sexo;
  class ano sexo;
  var nota_final;
  table 
    ano*sexo, /* Linhas: combinação de ano e sexo */
    nota_final*(mean min max std n) /* Colunas: estatísticas */
    / misstext='-';
run;