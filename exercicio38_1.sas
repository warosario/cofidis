/*
Exercício 38.1
Duplique o exercício anterior e adicione as seguintes variáveis: o tempo de experiência e quanto falta para a mudança de classificação.
*/

data empregados_classificados;
   set formacao.empregados;
   where departamento = 'TI';

   length classificacao $10;

   if experiencia < 4 then do;
      classificacao = 'Júnior';
      falta_mudar_class = 4 - experiencia;
   end;
   else do;
      classificacao = 'Sênior';
      falta_mudar_class = 0;
   end;

   keep id experiencia classificacao falta_mudar_class;
run;

proc sql;
   create table empregados_classificados_sql as
   select 
      id,
      experiencia,
      case 
         when experiencia < 4 then 'Júnior'
         else 'Sênior'
      end as classificacao,
      case 
         when experiencia < 4 then 4 - experiencia
         else 0
      end as falta_mudar_class
   from formacao.empregados
   where departamento = 'TI';
quit;

PROC SORT DATA=empregados_classificados OUT=empregados_classificados_OUT;
BY ID;
RUN;

PROC SORT DATA=empregados_classificados_sql OUT=empregados_classificados_sql_OUT;
BY ID;
RUN;

PROC COMPARE
 BASE=empregados_classificados_OUT
 COMPARE=empregados_classificados_sql_OUT OUT=TESTE;
run;