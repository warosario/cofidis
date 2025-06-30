/*
Exercício 42
Criar uma macro que faça o UPCASE no parametro enviado.
*/

%macro to_upcase(texto);
  %upcase(&texto)
%mend;

data exerc42;
SET formacao.departamentos;
  nome_macro = "%to_upcase(william rosario)";
run;

%macro cria_dataset_com_upcase(dataset, var);
  data &dataset._up;
    set &dataset;
    &var._up = upcase(&var);
  run;
%mend;

%cria_dataset_com_upcase(dataset=formacao.departamentos, var=SETOR);

/*UPCASE NO DATA STEP*/
data formacao.departamentos_up;
set formacao.departamentos;
     setor_up = upcase(setor);
run;

/*UPCASE DINAMICO*/
%macro to_upcase_macro(texto, var_saida);
  %global &var_saida;
  %let &var_saida = %upcase(&texto);
%mend;

%to_upcase_macro(william rosario, nome_maisculo);

data exerc42;
  nome_macro = "&nome_maisculo";
run;