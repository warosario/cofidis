/*
Exercício 11 - TRANSLATE
Substituir caracteres específicos em uma string por outros caracteres correspondentesTRANSLATE(texto,de,para);
*/

DATA exerc_translate;
	nome='William Rosario';
	nome_traduzido=TRANSLATE(NOME,'Y','i');
RUN;