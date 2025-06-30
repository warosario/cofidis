libname COFIDIS BASE '/home/u40916726/tabelas';

proc print data=COFIDIS.DEPARTAMENTOS;
run;

/*SQL SERVER*/
libname minha_sql odbc 
  dsn="meu_dsn_sqlserver" 
  user=meu_usuario 
  password=minha_senha;
  
libname minha_sql oledb 
  provider="SQLOLEDB" 
  datasource="IP_DO_SERVIDOR" 
  properties=("Initial Catalog"="NOME_DO_BANCO")
  user=meu_usuario 
  password=minha_senha;
  
proc sql;
  connect to odbc (dsn="meu_dsn_sqlserver" user=meu_usuario password=minha_senha);
  create table resultado as
  select * from connection to odbc (
    select top 10 * from dbo.Clientes
  );
  disconnect from odbc;
quit;


/*ORACLE*/
libname minha_ora odbc 
  dsn="meu_dsn_oracle" 
  user=meu_usuario 
  password=minha_senha;
  
libname minha_ora oracle 
  path="meu_tns" 
  user=meu_usuario 
  password=minha_senha;
  
proc sql;
  connect to oracle (user=meu_usuario password=minha_senha path=meu_tns);
  create table resultado as
  select * from connection to oracle (
    select nome, data_nascimento from pessoas where rownum <= 10
  );
  disconnect from oracle;
quit;




%macro conectar_sql(dsn=, user=, pass=, query=, out=);
  proc sql;
    connect to odbc (dsn="&dsn." user="&user." password="&pass.");
    create table &out. as
    select * from connection to odbc (
      &query.
    );
    disconnect from odbc;
  quit;
%mend;


%conectar_sql(
  dsn=MEU_DSN_SQL,
  user=meu_usuario,
  pass=minha_senha,
  query=%str(
    select top 100 * from dbo.clientes where cidade = 'São Paulo'
  ),
  out=formacao.clientes_sp
);



%macro conectar_oracle(user=, pass=, path=, query=, out=);
  proc sql;
    connect to oracle (user="&user." password="&pass." path="&path.");
    create table &out. as
    select * from connection to oracle (
      &query.
    );
    disconnect from oracle;
  quit;
%mend;

%conectar_oracle(
  user=meu_usuario,
  pass=minha_senha,
  path=MEU_TNS,
  query=%str(
    select nome, to_char(data_nascimento, 'YYYY-MM-DD') as nascimento
    from pessoas where rownum <= 20
  ),
  out=pessoas_teste
);      