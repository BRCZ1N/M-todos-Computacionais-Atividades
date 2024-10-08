function lista6Questao1GaussEliminacaoSP()
  % Sistema de equações:
  % 1*x1 + 6*x2 + 2*x3 + 4*x4 = 8
  % 3*x1 + 19*x2 + 4*x3 + 15*x4 = 25
  % 1*x1 + 4*x2 + 8*x3 - 12*x4 = 18
  % 5*x1 + 33*x2 + 9*x3 + 3*x4 = 72

  % Matriz de coeficientes
  A = [ 1 , 6  , 2 , 4;
        3 , 19 , 4 , 15;
        1 , 4  , 8 , -12;
        5 , 33 , 9 , 3];

  % Matriz de valores independentes
  b = [8;25;18;72];
  x = [];  % Inicializa vetor de soluções

  n = 4;  % Número de equações

  if(det(A))  % Verifica se o determinante é diferente de zero
    [mAGauss, mbGauss] = gaussEliminacao(A, b, n);  % Eliminação de Gauss
    debug(mAGauss, mbGauss, n);  % Exibe a matriz aumentada após eliminação
    x = gaussSubstituicao(mAGauss, mbGauss, n);  % Substituição reversa
    debugRaizes(x, n);  % Exibe as soluções
  endif
endfunction

function [A, b] = gaussEliminacao(A, b, n)
  % Realiza a eliminação de Gauss
  for k = 1: n-1
    for i = k + 1 : n
      fator = A(i, k) / A(k, k);  % Calcula o fator de eliminação
      for j = k: n
        A(i, j) = A(i, j) - fator * A(k, j);  % Atualiza a linha i
      endfor
      b(i) = b(i) - fator * b(k);  % Atualiza o vetor b
    endfor
  endfor
endfunction

function debug(A, b, n)
  % Imprime a matriz aumentada para depuração
  for i = 1:n
    for j = 1:n
      fprintf('%d,', A(i, j));  % Exibe coeficientes
    endfor
    fprintf('= %d\n', b(i));  % Exibe o valor independente
  endfor
endfunction

function debugRaizes(x, n)
  % Imprime as raízes encontradas
  for i = 1:n
    fprintf('= %d\n', x(i));  % Exibe cada raiz
  endfor
endfunction

function [x] = gaussSubstituicao(A, b, n)
  % Realiza a substituição reversa para encontrar as soluções
  x(n) = b(n) / A(n, n);  % Solução para a última variável
  for i = n-1:-1:1
    soma = b(i);  % Inicia a soma com o valor correspondente em b
    for j = i+1 : n
      soma = soma - A(i, j) * x(j);  % Subtrai contribuições das variáveis já resolvidas
    endfor
    x(i) = soma / A(i, i);  % Calcula a solução para a variável i
  endfor
endfunction

% Chama a função principal
lista6Questao1GaussEliminacaoSP();

