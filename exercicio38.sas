/*
Exercício 38
Use o DATA Step para criar uma nova variável que classifica os empregados com base na experiência em "Júnior” até 4 anos e "Sênior” maior ou igual a 4 anos, do departamento de TI, criando um nova tabela somente com o id e a classificação.
*/

data empregados_classificados;
   set formacao.empregados;
   where departamento = 'TI';

   length classificacao $10;
   
   /* Classificação baseada em anos de experiência */
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
   create table empregados_classificados as
   select 
      id,
      case 
         when experiencia < 4 then 'Júnior'
         else 'Sênior'
      end as classificacao
   from formacao.empregados
   where departamento = 'TI';
quit;