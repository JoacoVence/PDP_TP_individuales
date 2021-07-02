
% TP1 INDIVIDUAL LÓGICO VENCE %

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

%   Consultas pedidas en la consigna de los puntos 1 y 2 %

% Quien mata a Agatha?

% 1 ?- mata(Asesino, agatha).
% Asesino = agatha .

% A quien odia cada personaje?

% 2 ?- odia(charles, Persona).
% Persona = mayordomo.

% 3 ?- odia(agatha, Persona).
% Persona = agatha .

% 4 ?- odia(mayordomo, Persona).
% Persona = agatha .

% Alguien odia a Milhouse?

% 5 ?- odia(Persona, milhouse).
% false.
