/*
Exercício 34
PROC IMPORT
Importar os 5 ficheiros CSV que estão na diretoria “CSV” para a libname formacao, considerando o DBMS = CSV, fazendo a substituição dos dados (REPLACE) e cabeçalho = SIM (GETNAMES).
*/

PROC IMPORT DATAFILE="/home/u40916726/csv/empregados.csv"
    OUT=formacao.empregados
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
    GUESSINGROWS=100;
RUN;

PROC IMPORT DATAFILE="/home/u40916726/csv/departamentos.csv"
    OUT=formacao.departamentos
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
RUN;

PROC IMPORT DATAFILE="/home/u40916726/csv/clientes.csv"
    OUT=formacao.clientes
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
RUN;

PROC IMPORT DATAFILE="/home/u40916726/csv/pedidos.csv"
    OUT=formacao.pedidos
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
    GUESSINGROWS=MAX;  /* Garante leitura adequada de todos os tipos */
RUN;

PROC IMPORT DATAFILE="/home/u40916726/csv/avaliacoes_funcionarios.csv"
    OUT=formacao.avaliacoes_funcionarios
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
RUN;