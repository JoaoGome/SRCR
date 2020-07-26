
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Trabalho individual - A82238

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:-[baseConhecimento].


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% ---------PERCURSO POR CIDADES APENAS MINOR-------------

caminhoMinor(A,B,P) :- caminho1Minor(A,[B],P).
caminho1Minor(A,[A|P1],[A|P1]).
caminho1Minor(A,[Y|P1],P) :- arco(X,Y,_), \+ memberchk(X,[Y|P1]), cidade(X,_,_,_,_,'minor',_,_),
							 caminho1Minor(A,[X,Y|P1],P).

profundidadeMinor(A,B,P) :- resolve_pp(A,B,P), verificaMinor(P).

estrelaMinor(A,B,P) :- resolve_estrela(A,B,P/_), verificaMinor(P).

gulosaMinor(A,B,P) :- resolve_gulosa(A,B,P/_), verificaMinor(P).

% funcao que verifica se o percurso só passa por cidades minor
verificaMinor([]).
verificaMinor([X|T]) :- cidade(X,_,_,_,_,'minor',_,_), verificaMinor(T).

% ---------PERCURSO POR CIDADES COM MAR-----------------

caminhoMar(A,B,P) :- caminho1Mar(A,[B],P).
caminho1Mar(A,[A|P1],[A|P1]).
caminho1Mar(A,[Y|P1],P) :- arco(X,Y,_), \+ memberchk(X,[Y|P1]), cidade(X,_,_,_,_,_,'Yes',_),
							 caminho1Mar(A,[X,Y|P1],P).

profundidadeMar(A,B,P) :- resolve_pp(A,B,P), verificaMar(P).

estrelaMar(A,B,P) :- resolve_estrela(A,B,P/_), verificaMar(P).

gulosaMar(A,B,P) :- resolve_gulosa(A,B,P/_), verificaMar(P).

% funçao que verifica se o percurso só passa por cidades com mar
verificaMar([]).
verificaMar([X|T]) :- cidade(X,_,_,_,_,_,'Yes',_), verificaMar(T).

% ----------PERCURSO POR CIDADES COM MONUMENTOS HISTORICOS---------

caminhoMonumentos(A,B,P) :- caminho1Monumentos(A,[B],P).
caminho1Monumentos(A,[A|P1],[A|P1]).
caminho1Monumentos(A,[Y|P1],P) :- arco(X,Y,_), \+ memberchk(X,[Y|P1]), cidade(X,_,_,_,_,_,_,"Yes"),
							 caminho1Monumentos(A,[X,Y|P1],P).

profundidadeMonu(A,B,P) :- resolve_pp(A,B,P), verificaMonu(P).

estrelaMonu(A,B,P) :- resolve_estrela(A,B,P/_), verificaMonu(P).

gulosaMonu(A,B,P) :- resolve_gulosa(A,B,P/_), verificaMonu(P).

% funçao que verifica se o percurso só passa por cidades com monumentos
verificaMonu([]).
verificaMonu([X|T]) :- cidade(X,_,_,_,_,_,_,'Yes'), verificaMonu(T).

% --------- PERCURSO POR CIDADES COM DETERMINADAS CARACTERISTICAS ---------

caminhoCaracteristicas(A,B,P,D,I,O,M) :- caminho(A,B,P), verifica(P,D,I,O,M).

profundidadeCaracteristicas(A,B,P,D,I,O,M) :- resolve_pp(A,B,P), verifica(P,D,I,O,M).

estrelaCaracteristicas(A,B,P,D,I,O,M) :- resolve_estrela(A,B,P/_), verifica(P,D,I,O,M).

gulosaMarMonu(A,B,P,D,I,O,M) :- resolve_gulosa(A,B,P/_), verifica(P,D,I,O,M).

% funcao que verifica se o percurso passa por cidades com caracteristicas especificas
verifica([],D,I,O,M).
verifica([X|T],D,I,O,M) :- cidade(X,_,_,_,D,I,O,M), verifica(T,D,I,O,M).

% ----------- PERCURSO QUE EXCLUI CIDADES COM CERTAS CARACTERISTICAS

caminhoExclui(A,B,P,D,I,O,M) :- caminho(A,B,P), exclui(P,D,I,O,M).

profundidadeExclui(A,B,P,D,I,O,M) :- resolve_pp(A,B,P), exclui(P,D,I,O,M).

estrelaExclui(A,B,P,D,I,O,M) :- resolve_estrela(A,B,P/_), exclui(P,D,I,O,M).

gulosaExclui(A,B,P,D,I,O,M) :- resolve_gulosa(A,B,P/_), exclui(P,D,I,O,M).

% funcao que verifica se o percurso passa por cidades com caracteristicas a excluir
exclui([],D,I,O,M).
exclui([X|T],D,I,O,M) :- \+ cidade(X,_,_,_,D,I,O,M), exclui(T,D,I,O,M).


% -------------MENOR PERCURSO -> MENOR NUMERO DE CIDADES----------

caminho_MenorNCidades(A,B,P) :- findall(T,caminho(A,B,T),L), menor(L,P).

profundidade_MenorNCidades(A,B,P) :- findall(T,resolve_pp(A,B,T),L), menor(L,P).

estrela_MenorNCidades(A,B,P) :- findall(T,resolve_estrela(A,B,T/_),L), menor(L,P).

gulosa_MenorNCidades(A,B,P) :- findall(T,resolve_gulosa(A,B,T/_),L), menor(L,P).

% calcula o menor elemento de uma lista
menor([X],X).
menor([X,Y|T], M) :- length(X,N1), length(Y,N2), N1<N2, menor([X|T],M).
menor([X,Y|T], M) :- length(X,N1), length(Y,N2), N1 >= N2,menor([Y|T],M).


% ---------------PERCURSO MAIS RAPIDO -> DISTANCIA-----------------

caminho_MaisRapido(A,B,P) :- findall(T,caminho(A,B,T),L), distancia(L,P).

profundidade_MaisRapido(A,B,P) :- findall(T,resolve_pp(A,B,T),L), distancia(L,P).

estrela_MaisRapido(A,B,P) :- findall(T,resolve_estrela(A,B,T/_),L), distancia(L,P).

gulosa_MaisRapido(A,B,P) :- findall(T,resolve_gulosa(A,B,T/_),L), distancia(L,P).

%calcula o tamnho/distancia de uma lista/percurso
tamanho([X],0).
tamanho([X,Y|T],P) :- cidade(X,_,LAT1,LONG1,_,_,_,_), cidade(Y,_,LAT2,LONG2,_,_,_,_),
                          dist(LAT1,LONG1,LAT2,LONG2,D), tamanho([Y|T], P1), P = D + P1.

%fica com a lista de menor distancia
distancia([X],X).
distancia([X,Y|T],P) :- tamanho(X,D1), tamanho(Y,D2), D1 <  D2, distancia([X|T],P).
distancia([X,Y|T],P) :- tamanho(X,D1), tamanho(Y,D2), D1 >= D2,  distancia([Y|T],P).


% ---------------DETERMINAR CIDADE COM MAIOR NUMERO DE LIGAÇÕES-----------

maisLigacoes([X],X).
maisLigacoes([X,Z|T],R) :- findall(Y,arco(X,Y,_),L1), findall(J,arco(Z,J,_),L2),
							length(L1,N1), length(L2,N2), N1 > N2, maisLigacoes([X|T],R).
maisLigacoes([X,Z|T],R) :- findall(Y,arco(X,Y,_),L1), findall(J,arco(Z,J,_),L2),
							length(L1,N1), length(L2,N2), N1 =< N2, maisLigacoes([Z|T],R).

% --------------- PERCURSO QUE PASSA POR CIDADES OBRIGATORIAMENTE

caminho_Obrigatorio(A,B,P,C) :- caminho(A,B,P), intermedio(C,P).

profundidade_Obrigatorio(A,B,P,C) :- resolve_pp(A,B,P), intermedio(C,P).

estrela_Obrigatorio(A,B,P,C) :- resolve_estrela(A,B,P/_), intermedio(C,P).

gulosa_Obrigatorio(A,B,P,C) :- resolve_gulosa(A,B,P/_), intermedio(C,P).

% funcao que verifica se o percurso passa pelas cidades obrigatorias
intermedio([],C).
intermedio([X|T],C) :- memberchk(X,C), intermedio(T,C).

% --------------- Algoritmos Base -----------------------

% 	CAMINHO

caminho(A,B,P) :- caminho1(A,[B],P).
caminho1(A,[A|P1],[A|P1]).
caminho1(A,[Y],P):- arco(X,Y,_), caminho1(A,[X,Y],P).
caminho1(A,[Y|P1],P) :-
     arco(X,Y,_), \+ memberchk(X,[Y|P1]), caminho1(A,[X,Y|P1],P).

% 	PROFUNDIDADE PRIMEIRO

resolve_pp(Nodo, Destino, [Nodo|Caminho]) :-
    profundidadeprimeiro(Nodo, Destino, Caminho,8).

profundidadeprimeiro(Nodo, Destino,[],MAX) :- MAX > 0, Nodo == Destino, !.


profundidadeprimeiro(Nodo, Destino,[ProxNodo|Caminho],MAX) :- MAX > 0, DEC is MAX - 1, !,
    arco(Nodo, ProxNodo,_),
    profundidadeprimeiro(ProxNodo, Destino,Caminho,DEC).


%	ESTRELA

resolve_estrela(Nodo, Destino, Caminho/Custo) :-
        tamanho([Nodo,Destino],Estima),
        estrela([[Nodo]/0/Estima], InvCaminho/Custo/_, Destino,40),
        inverso(InvCaminho, Caminho),!.

estrela(Caminhos, Caminho, Destino,LIMIT) :- LIMIT>0,
        obtem_melhor(Caminhos, Caminho),
        Caminho = [Nodo|_]/_/_,
        Nodo==Destino.

estrela(Caminhos, SolucaoCaminho, Destino, LIMIT) :-
        LIMIT>0, DEC is LIMIT - 1, !,
        obtem_melhor(Caminhos, MelhorCaminho),
        seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
        expande_estrela(Destino,MelhorCaminho, ExpCaminhos),
        append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
        estrela(NovoCaminhos, SolucaoCaminho, Destino,DEC).


obtem_melhor([Caminho], Caminho) :- !.

obtem_melhor([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho) :-
        Custo1 + Est1 =< Custo2 + Est2, !,
        obtem_melhor([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).

obtem_melhor([_|Caminhos], MelhorCaminho) :-
        obtem_melhor(Caminhos, MelhorCaminho).

expande_estrela(Destino, Caminho, ExpCaminhos) :- !,
        findall(NovoCaminho, adjacente(Destino,Caminho,NovoCaminho), ExpCaminhos).

adjacente(Destino,[Nodo|Caminho]/Custo/_, [ProxNodo,Nodo|Caminho]/NovoCusto/Est) :-
        arco(Nodo, ProxNodo,_),\+ member(ProxNodo, Caminho),
        tamanho([Nodo,ProxNodo],PassoCusto),
        NovoCusto is Custo + PassoCusto,
        tamanho([ProxNodo,Destino],Est).


%   GULOSA
resolve_gulosa(Nodo, Destino,Caminho/Custo) :-
    tamanho([Nodo,Destino],Estima),
    gulosa([[Nodo]/0/Estima], Destino, InvCaminho/Custo/_),
    inverso(InvCaminho, Caminho).

gulosa(Caminhos, Destino, Caminho) :-
    obtem_melhor_g(Caminhos, Caminho),
    Caminho = [Nodo|_]/_/_,
    Nodo == Destino.

gulosa(Caminhos, Destino,  SolucaoCaminho) :-
    obtem_melhor_g(Caminhos, MelhorCaminho),
    seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
    expande_gulosa(MelhorCaminho, Destino, ExpCaminhos),
    append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
        gulosa(NovoCaminhos, Destino, SolucaoCaminho).


obtem_melhor_g([Caminho], Caminho) :- !.

obtem_melhor_g([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho) :-
    Est1 =< Est2, !,
    obtem_melhor_g([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).

obtem_melhor_g([_|Caminhos], MelhorCaminho) :-
    obtem_melhor_g(Caminhos, MelhorCaminho).

expande_gulosa(Caminho, Destino, ExpCaminhos) :-
    findall(NovoCaminho, adjacente(Destino, Caminho,NovoCaminho), ExpCaminhos).

%- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%#     Funções auxiliares
%- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
inverso(Xs, Ys):-
	inverso(Xs, [], Ys).

inverso([], Xs, Xs).
inverso([X|Xs],Ys, Zs):-
	inverso(Xs, [X|Ys], Zs).

seleciona(E, [E|Xs], Xs).
seleciona(E, [X|Xs], [X|Ys]) :- seleciona(E, Xs, Ys).

adicionar([],X,[X]).
adicionar([H|T],X,[H|T]) :- pertence(X, [H|T]).
adicionar([H|T],X, [X|[H|T]]) :- nao(pertence(X,[H|T])).

%função responsável por calcular a distância entre duas cidades
dist(Lat1,Long1,Lat2,Long2,D):- D is (sqrt((Lat1-Lat2)^2 + (Long1-Long2)^2)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).
