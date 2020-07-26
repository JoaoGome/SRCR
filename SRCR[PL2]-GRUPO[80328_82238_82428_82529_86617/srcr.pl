%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3
% => a86617 Gonçalo Nogueira
% => Carlos Afonso
% => Joao Pedro
% => Pedro Lima
% => Joao Gomes

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).


%-----------------------------------------------------------------------------
% SICStus PROLOG: definicoes iniciais

:- op( 900, xfy,'::' ).
:- dynamic adjudicante/4.
:- dynamic adjudicataria/4.
:- dynamic contrato/9.
:- dynamic imprecisoCusto/3.
:- dynamic imprecisoMorada/2.
:- dynamic nuloInterditoVal/1.
% ----------------------------- CONHECIMENTO POSITIVO -------------------------------- %


% adjudicante: #IdAd, Nome, Nif, Morada ↝{𝕍,𝔽,𝔻}
adjudicante(1, 'Municipio de Braga', 506901173, 'Braga').
adjudicante(2, 'Teatro Circo de Braga', 500463964, 'Braga').
adjudicante(3, 'Universidade do Minho', 502011378, 'Braga').
adjudicante(4, 'Centro Hospitalar do Alto Ave', 508080827, 'Guimaraes').
adjudicante(5, 'Tribunal Constitucional', 600014193, 'Lisboa').
adjudicante(7, 'Direcao Geral da Saude', 600037100, 'Lisboa').
adjudicante(8, 'Universidade do Porto',  501413197, 'Porto').
adjudicante(9, 'Instituto Nacional de Estatistica', 502237490, 'Lisboa').
adjudicante(10, 'Municipio de Fafe', 506841561, 'Fafe').


% adjudicataria: #IdAda, Nome, Nif, Morada↝{𝕍,𝔽,𝔻}
adjudicataria(1, 'Soserfis Contabilidade Fiscalidade Gestao Empresarial Lda', 502021209, 'Braga').
adjudicataria(2, 'Bragaconta Gestao Empresarial Lda', 509689930, 'Braga'). 
adjudicataria(3, 'Fafware Informatica Unipessoal Lda', 509861415, 'Fafe'). 
adjudicataria(4, 'Sempreluz Canalizacoes E Electricidade Lda', 500313628, 'Coimbra'). 
adjudicataria(5, 'Pausa Simpatica Lda', 514226854, 'Matosinhos'). 
adjudicataria(6, 'Enigmalecrim Lda', 515912794, 'Faro'). 
adjudicataria(7, 'Atrevomeasorte Lda', 513899545, 'Braga'). 
adjudicataria(8, 'Everything Is New Lda', 507903480, 'Lisboa'). 
adjudicataria(9, 'Diligente Plano Unipessoal Lda', 515785113, 'Aveiro'). 
adjudicataria(10, 'Faftir Transportes Lda', 505404737, 'Fafe'). 



%contrato: #IdAd, #IdAda, TipoDeContrato, TipoDeProcedimento, Descriçao, Valor, Prazo, Local, Data↝{𝕍,𝔽,𝔻}
contrato(1,2, 'Aquisiçao de serviços', 'Consulta Previa', 'Consultoria', 20000, 100, 'Braga', (24,3,2020)).
contrato(3,1, 'Aquisiçao de serviços', 'Ajuste Direto', 'Assessoria juridica', 1999, 90, 'Braga', (30,3,2020)).
contrato(10,10, 'Aquisiçao de serviços', 'Concurso Publico', 'Transporte de mercadoria', 1500, 60, 'Fafe', (24,4,2020)).
contrato(4,3, 'Aquisiçao de bens', 'Ajuste direto', 'Compra de material informatico', 4000, 30, 'Guimaraes', (21,2,2020)).


% ------------------------- CONHECIMENTO NEGATIVO ---------------------------- %


% É falsa a informaçao de que certos adjudicantes/adjudicatarias tenham um contrato.
-adjudicante(11, 'Municipiode Guimaraes', 505948605 , 'Guimaraes').
-adjudicante(12, 'Universidade de Lisboa', 510739024 , 'Lisboa').
-adjudicante(13, 'Universidade de Aveiro', 501461108 , 'Aveiro').


-adjudicataria(11, 'Kyaia Solucoes Informaticas Lda', 509934870, 'Guimaraes').
-adjudicataria(12, 'Ipj Texteis Lda', 502752394, 'Braga').
-adjudicataria(13, 'Convenient Flavour Lda', 514418230, 'Braga').



%nao podem existir contratos neste dia por ser feriado.
-contrato(_, _, _, _, _, _, _, _, (1,1,2020)).


% Nao pode ser adjudicante se for adjudicataria
% adjudicante : N -> {V,F,D}
-adjudicante(_, Nome, Nif, Morada) :- adjudicataria(ID, Nome, Nif, Morada).


% adjudicataria : N -> {V,F,D}
-adjudicataria(_, Nome, Nif, Morada) :- adjudicante(ID, Nome, Nif, Morada).


% ------------------------ CONHECIMENTO IMPERFEITO --------------------------- %

% --------- CONHECIMENTO INCERTO

% Deu entrada uma Entidade adjudicante com nif desconhecido
adjudicante(14, 'Municipio de Braganca', incNIF1, 'Braganca').
excecao(adjudicante(IdAd, Nome, NIF, Morada)) :- adjudicante(IdAd, Nome, incNIF1, Morada).

% Deu entrada uma Entidade adjudicante com morada desconhecida
adjudicante(15, 'Instituto do Emprego e da Formaçao Profissional', 501442600, incMorada1).
excecao(adjudicante(IdAd, Nome, NIF, Morada)) :- adjudicante(IdAd, Nome, NIF, incMorada1).


% Deu entrada uma Entidade adjudicataria com nif desconhecido
adjudicataria(14, 'Topgim Material Desportivo e Lazer Lda', incNIF1, 'Sintra').
excecao(adjudicataria(IdAda, Nome, NIF, Morada)) :- adjudicataria(IdAda, Nome, incNIF1, Morada).


% Deu entrada uma Entidade adjudicataria com morada desconhecida
adjudicataria(15, 'Otiselevadores Lda', 500069824, incMorada1).
excecao(adjudicataria(IdAd, Nome, NIF, Morada)) :- adjudicataria(IdAd, Nome, NIF, incMorada1).


% O contrato tem um valor desconhecido
contrato(1, 6, 'Aquisiçao de serviços', 'Consulta Prévia', 'Assessoria juridica', incValor1, '300 dias', 'Braga',(11-02-2020)).
excecao(contrato(IdAd, IdAda, TipoDeContrato, TipoDeProcedimento, Descricao, Valor, Prazo, Local, Data)) :- contrato(IdAd, IdAda, TipoDeContrato, TipoDeProcedimento, Descricao, incValor1, Prazo, Local, Data).


% O contrato tem um prazo desconhecido
contrato(10, 3, 'Aquisiçao de serviços', 'Ajuste Direto Regime Geral', 'Assessoria juridica', 13599, incPrazo1, 'Fafe', 02-02-2020).
excecao(contrato(IdAd, IdAda, TipoDeContrato, TipoDeProcedimento, Descricao, Valor, Prazo, Local, Data)) :- contrato(IdAd, IdAda, TipoDeContrato, TipoDeProcedimento, Descricao, Valor, incPrazo1, Local, Data).



% --------- CONHECIMENTO IMPRECISO

% O valor do contrato X encontra-se entre 5000 e 6000 euros
excecao(contrato(3, 9, 'Aquisiçao de serviços', 'Ajuste Direto Regime Geral', 'Assessoria juridica', X, '500 dias', 'Braga', (21-01-2020))) :- X > 5000, X < 6000.
imprecisoCusto(3,9,(21-01-2020)).

% O valor da morada X pode ser Faro ou Portimao
excecao(adjudicataria(13, 'Papelaria Gomes Lda', 526355224, 'Portimao')).
excecao(adjudicataria(13, 'Papelaria Gomes Lda', 526355224, 'Faro')).
imprecisoMorada(13,526355224).


% --------- CONHECIMENTO INTERDITO


% Por questões de confidencialidade nao se pode saber:
%         - valor
nuloInterditoVal(nuloValor1).
% Impossibilidade de saber o valor correspondente a um determinado contrato.
excecao(contrato(IdAd, IdAda, TipoDeContrato, TipoDeProcedimento, Descricao, Valor, Prazo, Local, Data)) :-
       contrato(IdAd, IdAda, TipoDeContrato, TipoDeProcedimento, Descricao, nuloValor1, Prazo, Local, Data).                         
contrato(16, 16, 'Empreitadas de obras publicas', 
                 'Ajuste Direto Regime Geral',
                 'Reposiçao do pavimento de valas da rede de agua na EN 207-1, em Barrosas St.º Estêvao', nuloValor1, '20 dias', 'Lousada', (15-03-2020)).



% Invariante para impedir a evoluçao do caso do contrato anterior com interdiçao no valor.
+contrato(Id,Id2,TC,TP,D,V,P,L,DT) ::(
       findall( excecao(contrato(Id,Id2,TC,TP,D,N,P,L,DT)),
       (excecao(contrato(Id,Id2,TC,TP,D, N, P, L, DT),
       nao(nuloInterditoVal(N))), S),
       comprimento(S,N),
                  N==0)).

% ------------------------ Adoçao do pressuposto do dominio fechado --------------------------- %

% Negação por falha

% Adoçao do pressuposto do dominio fechado -> adjudicante
-adjudicante(IdAd, Nome, NIF, Morada) :- nao(adjudicante(IdAd, Nome, NIF, Morada)),
                                         nao(excecao(adjudicante(IdAd, Nome, NIF, Morada))).



% Adoçao do pressuposto do dominio fechado -> adjudicataria
-adjudicataria(IdAda, Nome, NIF, Morada) :- nao(adjudicataria(IdAda, Nome, NIF, Morada)),
                                            nao(excecao(adjudicataria(IdAda, Nome, NIF, Morada))).


% Adoçao do pressuposto do dominio fechado -> contrato
-contrato(IdAd, IdAda, TipoDeContrato, TipoDeProcedimento, Descricao, Valor, Prazo, Local, Data) :- nao(contrato(IdAd, IdAda, TipoDeContrato, TipoDeProcedimento, Descricao, Valor, Prazo, Local, Data)),
nao(excecao(contrato(IdAd, IdAda, TipoDeContrato, TipoDeProcedimento, Descricao, Valor, Prazo, Local, Data))).




% ------------------------- Construçao do Caso Prático ---------------------- 
%
% Registar adjudicantes, adjudicatarias e contratos

% Invariante Estrutural: Nao podem existir adjudicantes repetidos (com o mesmo ID).
+adjudicante( IdAd, _, _, _) :: ( integer(IdAd),
                               findall(IdAd, adjudicante(IdAd, Nome, Nif, Morada), S),
                               comprimento( S, N ), N == 1 ).

% Invariante Referencial: Nif valido
+adjudicante( _, _, Nif, _) :: ( integer(Nif),
                                 Nif >= 100000000, Nif =< 999999999).

% Invariante Estrutural: Nao podem existir adjudicatarias repetidas (com o mesmo ID).
+adjudicataria( IdAda, _, _, _) :: ( integer(IdAda),
                               findall(IdAda, adjudicataria(IdAda, Nome, Nif, Morada), S),
                               comprimento( S, N ), N == 1 ).


% Invariante Referencial: Nif valido
+adjudicataria( _, _, Nif, _) :: ( integer(Nif),
                                 Nif >= 100000000, Nif =< 999999999).



% Invariante Referencial: Só se pode adicionar um contrato se o adjudicante e a adjudicataria existir.
+contrato(IdAd, IdAda, _, _, _, _, _, _, _) :: ( findall( IdAd, adjudicante(IdAd, Nome, Nif, Morada), L), comprimento(L,S), S == 1,
                                        findall( IdAda, adjudicataria(IdAda, Nome, Nif, Morada), X), comprimento(X,C), C == 1 ).




%
% ------------------------------------------------------------------------ %
%
%                      Remover adjudicantes, adjudicatarias e contratos


% Invariante Estrutural: Só se pode eliminar se existir o ID existir na Base de Conhecimento.
-adjudicante( IdAd, _, _, _) :: ( integer(IdAd),
                               findall(IdAd, adjudicante(IdAd, Nome, Nif, Morada), S),
                               comprimento( S, N ), N == 0 ).

% Invariante Referencial: Só se pode eliminar adjudicante se nao existirem contratos com esta entidade.
-adjudicante( IdAd, _, _, _) :: ( findall( IdAd, contrato(IdAd, IdAda, TipoDeContrato, TipoDeProcedimento, Descricao, Valor, Prazo, Local, Data), L),
                                 comprimento( L, N),
                                 N == 0 ).

% Invariante Estrutural: Só se pode eliminar se o ID existir na Base de Conhecimento.
-adjudicataria( IdAda, _, _, _) :: ( integer(IdAda),
                               findall(IdAda, adjudicataria(IdAda, Nome, Nif, Morada), S),
                               comprimento( S, N ), N == 0 ).

% Invariante Referencial: Só se pode eliminar adjudicatarias se nao existirem contratos com esta entidade.
-adjudicataria( IdAda, _, _, _) :: ( findall( IdAda, contrato(IdAd, IdAda, TipoDeContrato, TipoDeProcedimento, Descricao, Valor, Prazo, Local, Data), L),
                                 comprimento( L, N),
                                 N == 0 ).



% Nao se pode adicionar um excecao se for para conhecimento perfeito.
+excecao(T) :: nao(T).


% -------------------------- Predicados Auxiliares -------------------------- %

% Extensao do Predicado comprimento: ListaElem, Comp -> {V,F}
comprimento([],0).
comprimento([X|L], C) :- comprimento(L, N), C is 1+N.

% Extensao do predicado sum: X, R -> {V, F}, faz o somatório de uma lista.
sum([], 0).
sum([X|L], R) :- sum(L, R1), R is X + R1.

% Extensao do predicado apagaReps: L, R -> {V, F}
% Apaga diversos elementos repetidos numa lista.
apagaReps([], []).
apagaReps([H|T], [H|L]) :- apagaT(H, T, X),
                           apagaReps(X, L).

% Extensao do predicado apagaT: X, L, R -> {V, F}
% Apaga todas as ocorrências repetidas de um elemento numa lista.
apagaT(X, [], []).
apagaT(X,[X|L1],L2) :- apagaT(X,L1,L2).
apagaT(X,[Y|L1],[Y|L2]) :- apagaT(X,L1,L2).

% Extensao do predicado concatenar : L1,L2,R -> {V,F}
concatenar([],L,L).
concatenar([X|L1],L2,[X|L3]) :- concatenar(L1,L2,L3).

% Extensao do predicado concListList: LLs, L -> {V, F}
% Utilizando o predicado auxiliar concatenar, concatena listas dentro de uma lista.
concListList([], []).
concListList([H|T], L) :- concListList(T, L1),
                          concatenar(H, L1, L).

% insercao: T -> {V,F}
insercao(T) :- assert(T).
insercao(T) :- retract(T), !, fail.

% remocao: T -> {V,F}
remocao(T) :- retract(T).
remocao(T) :- assert(T), !, fail.

% teste: L -> {V,F}
teste( [] ).
teste( [I|Is] ) :- I, teste(Is).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Evoluçao do CONHECIMENTO PERFEITO POSITIVO

% evolucao: T -> {V,F}
evolucao(T) :- findall(I,+T::I,Li),
		       insercao(T),
		       teste(Li).

% involucao: T -> {V,F}
involucao(T) :- T,
                findall(I,-T::I,Li),
                remocao(T),
                teste(Li).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Evoluçao do CONHECIMENTO PERFEITO NEGATIVO
evolucaoNeg(T) :- findall(I,+(-T)::I,Li),
                  teste(Li),
                  assert(-T).

involucaoNeg(T) :- findall(I,+(-T)::I,Li),
                   teste(Li),
                   retract(-T).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Questao,Resposta -> {V,F}
demo( Questao,verdadeiro ) :-
          Questao.
demo( Questao,falso ) :-
          -Questao.
demo( Questao,desconhecido ) :-
          nao( Questao ),
          nao( -Questao ).
 
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}
nao( Questao ) :-
      Questao, !, fail.
nao( Questao ).
