/*
Exercício FINAL

Criar uma libname SAS via commando com o seu ultimo nome, apontando para diretoria com o seu ultimo nome;
(PROC IMPORT) Importar as tabelas de vendas, vendedor, cliente, região e produto (ficheiros disponiveis no GITHUB);
(DATA STEP e/ou PROC SQL) Criar uma consulta utilizando no minimo 3 tabelas, por exemplo nome do cliente, com quais produtos comprou e o valor total;
Utilizar pelo menos 5 funções distintas dentro da consulta (Data, Númerica ou Texto);
(PROC REPORT) Gerar um relatório com todas as colunas com as top 100 vendas;
(FORECAST) Gerar a previsão de vendas por região para os próximos 6 meses;
(PROC EXPORT) Exportar o resultado da previsão para a diretoria com seu último nome.

*/

* Define a biblioteca ROSARIO para armazenar as tabelas em uma pasta específica no ambiente SAS;
LIBNAME ROSARIO BASE '/home/u40916726/rosario';

* Importa o arquivo CSV de regiões e cria a tabela ROSARIO.REGIOES;
PROC IMPORT DATAFILE="/home/u40916726/csv/regiao_portugal.csv"
    OUT=ROSARIO.REGIOES
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
    GUESSINGROWS=1000;
RUN;

* Importa a tabela de vendedores;
PROC IMPORT DATAFILE="/home/u40916726/csv/vendedor_500.csv"
    OUT=ROSARIO.VENDEDORES
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
    GUESSINGROWS=1000;
RUN;

* Importa a tabela de clientes;
PROC IMPORT DATAFILE="/home/u40916726/csv/cliente_100mil.csv"
    OUT=ROSARIO.CLIENTES
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
    GUESSINGROWS=1000;
RUN;

* Importa a tabela de produtos;
PROC IMPORT DATAFILE="/home/u40916726/csv/produto_10mil.csv"
    OUT=ROSARIO.PRODUTOS
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
    GUESSINGROWS=1000;
RUN;

* Importa a tabela de vendas com 1,5 milhão de registros;
PROC IMPORT DATAFILE="/home/u40916726/csv/vendas_1_5_milhoes.csv"
    OUT=ROSARIO.VENDAS
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
    GUESSINGROWS=1000;
RUN;

* Comentado: Exemplo de formato de data personalizado (não utilizado no código final);
/*
PROC FORMAT;
   PICTURE ddmmyyyy (DEFAULT=8)
   low-high = '%0d%0m%Y' (DATATYPE=date);
RUN;
*/

* Cria tabela com resumo de compras por cliente e produto;
PROC SQL;
  CREATE TABLE ROSARIO.CLIENTE_POR_COMPRA AS
    SELECT 
      TRANSLATE(UPCASE(C.NOME_CLIENTE),' ','-') AS NOME,   /* Converte nome do cliente para maiúsculas e substitui espaços por hífens*/
      CASE WHEN P.NOME_PRODUTO = 'Pariatur 9212' THEN 'AZEITONA' 
           ELSE UPCASE(P.NOME_PRODUTO) 
      END AS PRODUTO,                                       /* Corrige nome do produto específico;*/
      DATEPART(V.DATA_VENDA) FORMAT=DATE9. AS DATA_VENDA,  /* Extrai apenas a data da variável datetime;*/
      SUM(V.QUANTIDADE) AS QTDE,                            /* Soma da quantidade vendida;*/
      AVG(P.PRECO_UNITARIO) FORMAT=BEST12. AS PRECO_UNIT,   /* Preço médio;*/
      SUM(V.QUANTIDADE * P.PRECO_UNITARIO) FORMAT=BEST12. AS VALOR_TOTAL /* Valor total da compra;*/
    FROM ROSARIO.VENDAS V
    INNER JOIN ROSARIO.CLIENTES C ON V.CLIENTE_ID = C.CLIENTE_ID
    INNER JOIN ROSARIO.PRODUTOS P ON V.PRODUTO_ID = P.PRODUTO_ID
    GROUP BY C.NOME_CLIENTE, P.NOME_PRODUTO
    ORDER BY VALOR_TOTAL DESC;
QUIT;

* Gera relatório com as 100 maiores compras por cliente e produto;
PROC REPORT DATA=ROSARIO.CLIENTE_POR_COMPRA (OBS=100);
  COLUMN NOME PRODUTO DATA_VENDA QTDE PRECO_UNIT VALOR_TOTAL;
RUN;

* Ordena as tabelas para merge posterior;
PROC SORT DATA=ROSARIO.VENDAS;     BY CLIENTE_ID; RUN;
PROC SORT DATA=ROSARIO.CLIENTES;   BY CLIENTE_ID; RUN;
PROC SORT DATA=ROSARIO.REGIOES;    BY REGIAO_ID;  RUN;

* Junta vendas com dados de clientes (apenas os campos necessários);
DATA VENDAS_CLIENTES;
  MERGE
    ROSARIO.VENDAS   (IN=A)
    ROSARIO.CLIENTES (IN=B KEEP=CLIENTE_ID REGIAO_ID);
  BY CLIENTE_ID;
  IF A AND B;  * Garante que só registros presentes em ambas as tabelas sejam incluídos;
RUN;

* Ordena dados para merge com a tabela de regiões;
PROC SORT DATA=VENDAS_CLIENTES;   BY REGIAO_ID; RUN;
PROC SORT DATA=ROSARIO.REGIOES;   BY REGIAO_ID; RUN;

* Junta as vendas com as regiões e extrai o mês da data de venda;
DATA ROSARIO.VENDAS_COM_REGIAO (DROP=venda_id data_venda vendedor_id cliente_id produto_id regiao_id);
  MERGE
    VENDAS_CLIENTES     (IN=A)
    ROSARIO.REGIOES     (IN=B KEEP=REGIAO_ID NOME_REGIAO);
  BY REGIAO_ID;
  IF A AND B;

  * Extrai o primeiro dia do mês da venda;
  DATA_VENDA_MES = MDY(MONTH(DATEPART(DATA_VENDA)), 1, YEAR(DATEPART(DATA_VENDA)));
  FORMAT DATA_VENDA_MES DATE9.;
RUN;

* Ordena as vendas por região e mês para sumarização;
PROC SORT DATA=ROSARIO.VENDAS_COM_REGIAO OUT=ORDENADA;
  BY NOME_REGIAO DATA_VENDA_MES;
RUN;

* Agrupa vendas por região e mês e calcula quantidade total;
DATA ROSARIO.VENDAS_AGRUPADAS (KEEP=NOME_REGIAO DATA_VENDA_MES QTDE_TOTAL);
  SET ORDENADA;
  BY NOME_REGIAO DATA_VENDA_MES;
  RETAIN QTDE_TOTAL;
  IF FIRST.DATA_VENDA_MES THEN QTDE_TOTAL = 0;
  QTDE_TOTAL + QUANTIDADE;
  IF LAST.DATA_VENDA_MES THEN OUTPUT;
RUN;

* Ordena por data decrescente para selecionar as 12 últimas;
PROC SORT DATA=ROSARIO.VENDAS_AGRUPADAS OUT=VENDAS_ORDENADAS;
  BY NOME_REGIAO DESCENDING DATA_VENDA_MES;
RUN;

* Filtra as 12 últimas ocorrências para cada região;
DATA VENDAS_12_ULTIMAS;
  SET VENDAS_ORDENADAS;
  BY NOME_REGIAO;
  RETAIN CONTADOR;
  IF FIRST.NOME_REGIAO THEN CONTADOR = 0;
  CONTADOR + 1;
  IF CONTADOR <= 12 THEN OUTPUT;
RUN;

* Reordena por data crescente para uso no forecast;
PROC SORT DATA=VENDAS_12_ULTIMAS;
  BY NOME_REGIAO DATA_VENDA_MES;
RUN;

* Aplica forecast exponencial para estimar os próximos 6 meses de vendas;
PROC FORECAST DATA=VENDAS_12_ULTIMAS OUT=ROSARIO.VENDAS_FORECAST LEAD=6 INTERVAL=MONTH METHOD=EXPO;
  ID DATA_VENDA_MES;
  BY NOME_REGIAO;
  VAR QTDE_TOTAL;
RUN;

PROC ARIMA DATA=VENDAS_12_ULTIMAS ;
  BY NOME_REGIAO;
  IDENTIFY VAR=QTDE_TOTAL(1) NLAG=6;
  ESTIMATE P=1 Q=1 METHOD=ML;
  FORECAST LEAD=6 INTERVAL=MONTH ID=DATA_VENDA_MES OUT=ROSARIO.VENDAS_ARIMA;
RUN;
QUIT;

/*
identify var=QTDE_TOTAL(1) : Aplica diferença de primeira ordem (d=1) para tornar a série estacionária.
nlag=6 : Considera até 6 defasagens para autocorrelação e PACF (útil para decidir p e q).
estimate p=1 q=1 : Estima um modelo ARIMA(1,1,1). Você pode ajustar conforme necessário.
forecast lead=6 : Gera previsão para os próximos 6 meses.
interval=month : Define periodicidade da série como mensal.
id=DATA_VENDA_MES : Usa a variável de tempo correta.
out=ROSARIO.VENDAS_ARIMA : Armazena os resultados previstos com limites de confiança.
*/

* Arredonda as previsões para evitar números fracionados;
DATA ROSARIO.VENDAS_FORECAST_INT;
  SET ROSARIO.VENDAS_FORECAST;
  QTDE_TOTAL = ROUND(QTDE_TOTAL, 1);
RUN;

* Exporta a previsão de vendas para arquivo Excel;
PROC EXPORT DATA=ROSARIO.VENDAS_FORECAST_INT
    OUTFILE="/home/u40916726/rosario/VENDAS_FORECAST.xlsx"
    DBMS=XLSX
    REPLACE;
RUN;