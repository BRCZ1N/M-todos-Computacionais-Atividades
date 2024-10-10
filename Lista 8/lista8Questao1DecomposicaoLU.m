function lista8Questao1GaussJordanP()
  % Sistema de equações a ser resolvido:
  % 1*x1 + 6*x2 + 2*x3 + 4*x4 = 8
  % 3*x1 + 19*x2 + 4*x3 + 15*x4 = 25
  % 1*x1 + 4*x2 + 8*x3 - 12*x4 = 18
  % 5*x1 + 33*x2 + 9*x3 + 3*x4 = 72

  % Exibe o sistema de equações
  disp('Sistema de Equações:');
  disp('1*x1 + 6*x2 + 2*x3 + 4*x4 = 8');
  disp('3*x1 + 19*x2 + 4*x3 + 15*x4 = 25');
  disp('1*x1 + 4*x2 + 8*x3 - 12*x4 = 18');
  disp('5*x1 + 33*x2 + 9*x3 + 3*x4 = 72');
  disp(' ');

  % Matriz de coeficientes do sistema
  A = [ 1 , 6  , 2 , 4;
        3 , 19 , 4 , 15;
        1 , 4  , 8 , -12;
        5 , 33 , 9 , 3];

  % Matriz de termos independentes
  b = [8; 25; 18; 72];

  % Criação da matriz aumentada [A | b]
  %Ab = [A b];

  n = size(A, 1);  % Obtém o número de equações

  U = A;
  L = eye(n);
  P = eye(n);

  if (det(A) != 0)  % Verifica se a matriz é não singular

    [U,L] = gaussEliminacao(U,L,P,n);  % Executa a eliminação de Gauss Triangular Superior

    % Exibe a matriz aumentada após a eliminação
    %disp('Matriz aumentada após eliminação de Gauss com Pivoteamento:');
    %debug(Ab, n);
    resSistema(P, b, L, U, n);  % Resolve o sistema por substituição
    %disp('Soluções:');
    %debugRaizes(x, n);  % Exibe as soluções das variáveis
  else
    disp('A matriz é singular, não há solução única.');  % Mensagem de erro
  end
endfunction

function [U,L] = gaussEliminacao(U,L,P,n)
  % Realiza a eliminação de Gauss
  for k = 1:n-1  % Para cada coluna, exceto a última
    [U,P] = gaussPivotagem(U, P, n, k);  % Aplica pivotagem
    for i = k+1:n  % Para cada linha abaixo da linha k
       fator = U(i, k) / U(k, k);  % Calcula o fator de eliminação
       fprintf('Fator de eliminação (linha %d): %.2f\n', i, fator);  % Mostra o fator com 2 casas decimais
       U(i, k:n) = U(i, k:n) - fator * U(k, k:n);  % Atualiza a linha
       L(i,k) = fator;
       disp('Matriz L:');
       debug(L,n);
       disp('Matriz U:');
       debug(U,n);
       disp('Matriz P:');
       debug(P,n);
    end
  end
endfunction

function debug(M, n)
  % Exibe a matriz aumentada em formato de matriz estendida
  for i = 1:n

    for j = 1:n  % Para as colunas da matriz A

      fprintf('%.2f\t', M(i, j));  % Formatação para duas casas decimais

    end

    fprintf('\n');  % Exibe o valor do termo independente

  end

endfunction

function [U,P] = gaussPivotagem(U,P,n,k)
  % Aplica a pivotagem para melhorar a estabilidade numérica
  [maior, i] = max(abs(U(k:n, k)));  % Encontra o índice do maior elemento
  ipr = i + k - 1;  % Ajusta o índice
  if ipr ~= k
      disp(['Troca de linha: ', num2str(k), ' com ', num2str(ipr)]);  % Mostra a troca de linha
      U([k, ipr], :) = U([ipr, k], :);
      P([k, ipr], :) = P([ipr, k], :);  % Troca as linha
  end
endfunction

function x = resSistema(P,b,L,U,n)
  % Resolve o sistema usando substituição regressiva
  bT = P*b;
  y = zeros(n, 1);  % Inicializa o vetor de soluções
  y(n) = A(n, n+1) / A(n, n);  % Calcula a última variável
  %for i = n-1:-1:1  % Retrocede para calcular as outras variáveis
    %x(i) = (A(i, n+1) - A(i, i+1:n) * x(i+1:n)) / A(i, i);
  %end
endfunction

function debugRaizes(x, n)
  % Exibe as raízes encontradas
  for i = 1:n
    fprintf('x%d = %.2f\n', i, x(i));  % Exibe cada raiz com o índice
  end
endfunction

% Chama a função principal
lista8Questao1GaussJordanP();

