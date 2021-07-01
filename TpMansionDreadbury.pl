% TP1 INDIVIDUAL LOGICO VENCE %

% BASE DE CONOCIMIENTOS

% viveEnLaMansion(nombre)

viveEnLaMansion(agatha).
viveEnLaMansion(charles).
viveEnLaMansion(mayordomo).

% odia(Persona, OtraPersona)

% tia Agatha

odia(agatha, OtraPersona):-
    viveEnLaMansion(OtraPersona),
    mayordomo\=OtraPersona.

% Charles

odia(charles, OtraPersona):-
    viveEnLaMansion(OtraPersona),
    not(odia(agatha, OtraPersona)).

% el Mayordomo

odia(mayordomo, OtraPersona):-
    odia(agatha, OtraPersona).

% esMasRico

esMasRico(UnaPersona, agatha):-
    viveEnLaMansion(UnaPersona),
    not(odia(mayordomo, UnaPersona)).


%   PUNTO 1    %

% mata (Asesino, Victima)

mata(Asesino, Victima):-
    viveEnLaMansion(Asesino),
    odia(Asesino, Victima),
    not(esMasRico(Asesino, Victima)).
