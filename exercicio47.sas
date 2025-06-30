/*
Exercício 47
PROC TABULATE – Criar um relatório com o resumo estatístico das notas finais da tabela avaliações de funcionários por ano:
*/
proc tabulate data=formacao.avaliacoes_funcionarios;
  class ano ;
  var nota_final;
  table ano, nota_final*(mean min max);
run;

/*Explicação
proc tabulate data=formacao.avaliacoes_funcionarios; -> Inicia o procedimento TABULATE utilizando os dados da tabela avaliacoes_funcionarios (localizada na biblioteca formacao).
class ano; -> Declara que ano é uma variável categórica (classe), ou seja, será usada para quebras de linha ou coluna no relatório.
var nota_final; -> Indica que nota_final é uma variável numérica de análise, ou seja, sobre a qual serão aplicadas estatísticas.
table ano, nota_final*(mean min max); -> Monta a tabela cruzada: As linhas (ano) correspondem aos anos. As colunas mostrarão as estatísticas (média, mínimo e máximo) da variável nota_final para cada ano.
*/

/*EXTRA*/
/*Média do empregado no periodo na empresa*/
proc tabulatE data=formacao.avaliacoes_funcionarios;
  class id;
  var nota_final;
  table id, nota_final*(mean min max);
run;