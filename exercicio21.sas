/*
Exercício 21 - TIMEPART
Extrai a parte de data de um datetime.TIMEPART();
*/

DATA exerc_datepart;
	dt='09JUN2025:15:20:00'dt;
	HORASOMENTE=TIMEPART(dt);
	FORMAT dt datetime20. HORASOMENTE time8. ;
RUN;