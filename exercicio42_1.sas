/*
Exercício 42.1
Criar um macro que faça o update na coluna setor filtrando por um departamento específico na tabela formacao.departamento.
*/

/*INSERIR REGISTRO*/

%macro inserir_departamento(departamento, setor);
    proc sql;
        insert into formacao.departamentos (departamento, setor)
        values ("&departamento", "&setor");
    quit;
%mend inserir_departamento;

%macro inserir_departamento(departamento, setor);
    data formacao.departamentos;
        set formacao.departamentos end=last;
        output;
        if last then do;
            departamento = "&departamento";
            setor = "&setor";
            output;
        end;
    run;
%mend inserir_departamento;

%inserir_departamento(Teste, Teste);

/*EXTRAS*/

/*DELETAR REGISTRO*/

%macro deletar_departamento(departamento, setor);
    data formacao.departamentos;
        set formacao.departamentos;
        if departamento = "&departamento" and setor = "&setor" then delete;
    run;
%mend deletar_departamento;

%macro deletar_departamento(departamento, setor);
    proc sql;
        delete from formacao.departamentos where departamento = "&departamento" and setor = "&setor";
    quit;
%mend deletar_departamento;

%deletar_departamento(Teste, Teste);

/*UPDATE REGISTRO*/

%macro atualizar_departamento(departamento_antigo, setor_antigo, departamento_novo, setor_novo);
    data formacao.departamentos;
        set formacao.departamentos;
        if departamento = "&departamento_antigo" and setor = "&setor_antigo" then do;
            departamento = "&departamento_novo";
            setor = "&setor_novo";
        end;
    run;
%mend atualizar_departamento;

    data formacao.departamentos;
        set formacao.departamentos;
        if departamento = "Financeiro" and setor = "Administrativo" then do;
            departamento = "Financeiro";
            setor = "Contábil";
        end;
    run;

%atualizar_departamento(Financeiro, Administrativo, Financeiro, Contábil);

%macro atualizar_departamento(departamento_antigo, setor_antigo, departamento_novo, setor_novo);
    proc sql;
        update formacao.departamentos
        set departamento = "&departamento_novo",
            setor = "&setor_novo"
        where departamento = "&departamento_antigo"
          and setor = "&setor_antigo";
    quit;
%mend atualizar_departamento;

%atualizar_departamento(Financeiro, Administrativo, Financeiro, Contábil);




