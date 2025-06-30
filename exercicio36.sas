/*
Exercício 36
Escreva uma consulta para selecionar apenas empregados que trabalham no departamento "TI" e ganham mais de $ 5500.
*/

DATA exerc_select;
  SET formacao.empregados;
  WHERE salario > 5500 AND UPCASE(departamento) = "TI";
RUN;


data exerc_select_1;
    set formacao.empregados;
    if departamento = 'TI' and salario > 5500;
    dia = today();
run;


DATA exerc_select_2;
  SET formacao.empregados (WHERE=(salario > 5500 AND UPCASE(departamento) = "TI"));
  dia = today();
RUN;


proc sql;
    create table exerc_select_sql as
    select * , 1 as teste
    from (select * from formacao.empregados where departamento = 'TI' and salario > 5500);
quit;


proc sql;
    select *
    from formacao.empregados
    where departamento = 'TI'
      and salario = 5500;
quit;


proc sql;
    create table exerc_select_sql as
    select *
    from formacao.empregados
    where departamento = 'TI'
      and salario > 5500;
quit;
