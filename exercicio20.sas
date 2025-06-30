/*
Exercício 20 - DATEPART
Extrai a parte de data de um datetime.DATEPART();
*/

DATA exerc_datepart;
	dt='09JUN2025:15:20:00'dt;
	DATASOMENTE=DATEPART(dt);
	FORMAT dt datetime20. datasomente date9. ;
RUN;