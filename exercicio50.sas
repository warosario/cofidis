/*
Exercício 50
PROC SGSCATTER – Criar uma matriz de dispersão para analisar relação entre idade, experiência e salário dos empregados
*/

proc sgscatter data=formacao.empregados;
  matrix idade experiencia salario;
run;

data _null_;
  file print;
  put "Estrutura da Matriz";
  put "Diagonais principais: Cada célula da diagonal mostra o nome da variável (idade, experiencia, salario).";
  put "Não há gráfico nesses quadrantes, pois não faz sentido plotar uma variável contra ela mesma.";
  put;
  put "Quadrantes fora da diagonal: Cada quadrante mostra um gráfico de dispersão entre duas variáveis diferentes.";
  put;
  put "Interpretação de Cada Quadrante";
  put "1. Quadrantes acima e abaixo da diagonal";
  put "Esses quadrantes mostram a mesma relação, mas invertendo os eixos X e Y. Por exemplo:";
  put "Quadrante (linha: idade, coluna: experiencia): idade no eixo Y, experiencia no eixo X.";
  put "Quadrante (linha: experiencia, coluna: idade): experiencia no eixo Y, idade no eixo X.";
  put;
  put "2. Relações específicas";
  put "Quadrante idade × experiencia = Mostra como a experiência dos empregados varia em função da idade.";
  put "Normalmente, espera-se uma correlação positiva: quanto maior a idade, maior a experiência, embora o padrão exato dependa dos dados da empresa.";
  put "Quadrante idade × salario = Mostra a relação entre idade e salário.";
  put "É possível identificar se empregados mais velhos tendem a ter salários maiores, ou se não há relação clara.";
  put "Quadrante experiencia × salario = Mostra a relação entre experiência e salário.";
  put "Geralmente, espera-se que mais experiência resulte em salários mais altos, mas o gráfico pode revelar se isso ocorre de fato.";
  put;
  put "Como Ler Cada Quadrante";
  put "Pontos alinhados em diagonal ascendente: Indica correlação positiva entre as variáveis (quando uma aumenta, a outra também tende a aumentar).";
  put "Pontos alinhados em diagonal descendente: Indica correlação negativa (quando uma aumenta, a outra tende a diminuir).";
  put "Pontos dispersos sem padrão: Indica pouca ou nenhuma correlação linear entre as variáveis.";
  put;
  put "Exemplo Visual";
  put "Quadrante entre idade e experiencia: Os pontos formam uma faixa diagonal, indicando que, quanto maior a idade, maior a experiência, o que é esperado.";
  put "Quadrante entre idade e salario: Os pontos estão mais dispersos, sugerindo que não há uma relação linear forte entre idade e salário.";
  put "Quadrante entre experiencia e salario: Também apresenta dispersão, indicando baixa correlação linear entre experiência e salário.";
  put;
  put "Resumo";
  put "Cada quadrante fora da diagonal mostra a relação entre um par de variáveis.";
  put "A análise visual permite identificar padrões, tendências e possíveis correlações entre idade, experiência e salário dos empregados,";
  put "auxiliando na compreensão do perfil dos funcionários e em decisões de gestão de pessoas.";
run;

