/*
Exercício 39
Utilizando o DATA Step, divida a tabela formacao.empregados em várias tabelas separadas por departamento (ex: TI, RH, Financeiro). Em seguida, una essas tabelas novamente utilizando PROC APPEND. Por fim, reproduza o mesmo resultado utilizando PROC SQL. 
*/

data empregados_ti empregados_rh empregados_financeiro;
   set formacao.empregados;

   if departamento = 'TI' then output empregados_ti;
   else if departamento = 'RH' then output empregados_rh;
   else if departamento = 'Financeiro' then output empregados_financeiro;
run;

data empregados_unificados;
   set empregados_ti;
run;

proc append base=empregados_unificados data=empregados_rh force; run;
proc append base=empregados_unificados data=empregados_financeiro force; run;

PROC CONTENTS DATA=empregados_unificados;RUN;



Exercício 39 continuação em Proc SQL;

Utilizando o DATA Step, divida a tabela formacao.empregados em várias tabelas separadas por departamento (ex: TI, RH, Financeiro). Em seguida, una essas tabelas novamente utilizando PROC APPEND. Por fim, reproduza o mesmo resultado utilizando PROC SQL com UNION ALL. 


proc sql;
   create table empregados_unificados_sql as
   (select * from formacao.empregados where departamento in ('TI'))
   union all
   (select * from formacao.empregados where departamento in ('RH',))
   union all
   (select * from formacao.empregados where departamento in ('Financeiro'));
quit;