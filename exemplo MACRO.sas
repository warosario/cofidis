%macro existe_setor(setor);
    %global resultado;
    proc sql ;
        select case when count(*) > 0 then 'VERDADEIRO' else 'FALSO' end
        into :resultado trimmed
        from formacao.departamentos
        where Ç = "&setor";
    quit;
    %put &resultado;
%mend existe_setor;

%existe_setor(Administrativo);



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

  data formacao.departamentos_up;
    set formacao.departamentos;
    setor_up = upcase(setor);
  run;


%macro to_upcase_macro(texto, var_saida);
  %global &var_saida;
  %let &var_saida = %upcase(&texto);
%mend;

%to_upcase_macro(william rosario, nome_maisculo);

data exerc42;
  nome_macro = "&nome_maisculo";
run;



%macro converter(texto, tipo);
  %if &tipo = 1 %then %upcase(&texto);
  %else %if &tipo = 2 %then %lowcase(&texto);
  %else &texto; /* Se tipo inválido, retorna sem alterar */
%mend;

data exemplo;
  resultado1 = "%converter(SaS Macro, 1)";
  resultado2 = "%converter(SaS Macro, 2)";
  resultado3 = "%converter(SaS Macro, 3)";
run;

%macro converter_macro(texto, tipo, outvar);
  %global &outvar;
  %if &tipo = 1 %then %let &outvar = %upcase(&texto);
  %else %if &tipo = 2 %then %let &outvar = %lowcase(&texto);
  %else %let &outvar = &texto;
%mend;

/* 1. Criar macrovariáveis com o mês e ano atual */
%let ano  = %sysfunc(year(%sysfunc(today())));
%let mes  = %sysfunc(putn(%sysfunc(month(%sysfunc(today()))), z2.));

/* 2. Criar nome dinâmico para o dataset */
%let nome_dataset = william_&ano.&mes.;
%put &nome_dataset;

/* 3. Criar o dataset com base nesse nome */
data &nome_dataset.;
  data_criacao = today();
  formato_data = put(today(), yymmn6.);
run;


%macro criar_dataset_base();

/* 1. Obtem ano e mês atual */
%let hoje = %sysfunc(today());
%let ano  = %sysfunc(year(&hoje));
%let mes  = %sysfunc(putn(%sysfunc(month(&hoje)), z2.));

/* 2. Monta o nome do dataset: base_YYYYMM */
%let nome_dataset = base_&ano.&mes.;

/* 3. Cria o dataset */
data &nome_dataset.;
  data_criada = &hoje;
  mes_ano = "&mes/&ano";
run;

%mend;

%criar_dataset_base();

%macro criar_dataset_base(prefixo=base);
%let hoje = %sysfunc(today());
%let ano  = %sysfunc(year(&hoje));
%let mes  = %sysfunc(putn(%sysfunc(month(&hoje)), z2.));
%let nome_dataset = &prefixo._&ano.&mes.;

data &nome_dataset.;
  data_criada = &hoje;
run;
%mend;

%criar_dataset_base(prefixo=vendas);