/*
Exercício 33 - MDY
Cria uma data a partir de mês, dia e ano.MDY(mes,dia,ano);
*/

DATA exerc_mdy;
  mes = 7;
  dia = 26;
  ano = 1984;
  data_nasc = MDY(mes,dia,ano);
  FORMAT data_nasc DDMMYY10.;
RUN;