/*
Exercício 23 - INTNX
Avança ou recua datas por interval.INTNX();
INTNX(intervalo, data_inicial, número, <alinhamento>, <método>)
intervalo: 'month', 'year', etc.
	•	data_inicial: data de referência.
	•	número: quantos intervalos você quer avançar (+) ou recuar (−).
	•	<alinhamento> (opcional): 'BEGINNING' (padrão), 'MIDDLE', 'END', 'SAME'
*/
DATA exerc_intnx;
	dnasc = '26JUL1984'd;
    nova_dnasc = INTNX('month',dnasc,12,'SAME');
	FORMAT dnasc nova_dnasc date9.;
RUN;