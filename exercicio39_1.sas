/*
Exercício 39 continuação em Proc SQL;
Utilizando o DATA Step, divida a tabela formacao.empregados em várias tabelas separadas por departamento (ex: TI, RH, Financeiro). Em seguida, una essas tabelas novamente utilizando PROC APPEND. Por fim, reproduza o mesmo resultado utilizando PROC SQL com UNION ALL. 
*/

proc sql;
   create table empregados_unificados_sql as
   (select * from formacao.empregados where departamento in ('TI'))
   union all
   (select * from formacao.empregados where departamento in ('RH',))
   union all
   (select * from formacao.empregados where departamento in ('Financeiro'));
quit;