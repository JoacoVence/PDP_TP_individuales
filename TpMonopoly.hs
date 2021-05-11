-- Trabajo Práctico Monopoly Joaquín Vence --

import Text.Show.Functions ()

data Jugador = UnJugador
  { nombre :: Nombre,
    dinero :: Dinero,
    tactica :: Tactica,
    propiedades :: [Propiedades],
    acciones :: [Accion]
  }
  deriving (Show)

data Propiedades = UnaPropiedad
  { nombrePropiedad :: String,
    costo :: Int
  }
  deriving (Show, Eq)

type Nombre = String

type Dinero = Int

type Tactica = String

type Accion = Jugador -> Jugador

-- JUGADORES --

carolina :: Jugador
carolina =
  UnJugador
    { nombre = "Carolina",
      dinero = 500,
      tactica = "Accionista",
      propiedades = [],
      acciones = [pasarPorElBanco, pagarAAccionistas]
    }

manuel :: Jugador
manuel =
  UnJugador
    { nombre = "Manuel",
      dinero = 500,
      tactica = "Oferente singular",
      propiedades = [],
      acciones = [pasarPorElBanco, enojarse]
    }

-- ACCIONES --

pasarPorElBanco :: Accion
pasarPorElBanco = cambiarDinero (+ 40) . cambiarTactica (const "Comprador impulsivo")

enojarse :: Accion
enojarse = cambiarDinero (+ 50) . agregarAccion gritar

gritar :: Accion
gritar = cambiarNombre ("AHHHH" ++)

subastar :: Propiedades -> Accion
subastar unaPropiedad unJugador
  | cumpleUnaDeLasTacticas unJugador = comprarPropiedad unaPropiedad unJugador
  | otherwise = unJugador

cobrarAlquileres :: Accion
cobrarAlquileres unJugador = cambiarDinero ((+) . totalDeIngresosPorAlquiler $ unJugador) unJugador

pagarAAccionistas :: Accion
pagarAAccionistas unJugador
  | esAccionista unJugador = cambiarDinero (+ 200) unJugador
  | otherwise = cambiarDinero (subtract 100) unJugador

hacerBerrinchePor :: Jugador -> Propiedades -> Jugador
hacerBerrinchePor unJugador unaPropiedad
  | esMayor (costo unaPropiedad) (dinero unJugador) = cambiarDinero (+ 10) . gritar $ unJugador
  | otherwise = comprarPropiedad unaPropiedad unJugador

ultimaRonda :: Jugador -> Accion
ultimaRonda unJugador = foldl1 (.) $ acciones unJugador

juegoFinal :: Jugador -> Jugador -> String
juegoFinal jugadorUno jugadorDos
  | esMayor (elDineroQueTiene jugadorUno) (elDineroQueTiene jugadorDos) = nombre jugadorUno
  | otherwise = nombre jugadorDos

-- FUNCIONES AUXILIARES --

cambiarNombre :: (String -> String) -> Jugador -> Jugador
cambiarNombre fn unJugador = unJugador {nombre = fn . nombre $ unJugador}

cambiarDinero :: (Int -> Int) -> Jugador -> Jugador
cambiarDinero fn unJugador = unJugador {dinero = fn . dinero $ unJugador}

cambiarTactica :: (String -> String) -> Jugador -> Jugador
cambiarTactica fn unJugador = unJugador {tactica = fn . tactica $ unJugador}

agregarAccion :: Accion -> Jugador -> Jugador
agregarAccion accion unJugador = unJugador {acciones = (accion :) . acciones $ unJugador}

agregarPropiedad :: Propiedades -> Jugador -> Jugador
agregarPropiedad propiedad unJugador = unJugador {propiedades = (propiedad :) . propiedades $ unJugador}

cumpleUnaDeLasTacticas :: Jugador -> Bool
cumpleUnaDeLasTacticas unJugador = (tactica $ unJugador) == "Oferente singular" || (tactica $ unJugador) == "Accionista"

comprarPropiedad :: Propiedades -> Jugador -> Jugador
comprarPropiedad unaPropiedad = agregarPropiedad unaPropiedad . cambiarDinero (subtract . costo $ unaPropiedad)

esPropiedadBarata :: Propiedades -> Bool
esPropiedadBarata unaPropiedad
  | (< 150) . costo $ unaPropiedad = True
  | otherwise = False

costosDeLosAlquileres :: Propiedades -> Int
costosDeLosAlquileres unaPropiedad
  | esPropiedadBarata unaPropiedad = 10
  | otherwise = 20

totalDeIngresosPorAlquiler :: Jugador -> Int
totalDeIngresosPorAlquiler = sum . map costosDeLosAlquileres . propiedades

esAccionista :: Jugador -> Bool
esAccionista unJugador = (tactica $ unJugador) == "Accionista"

elDineroQueTiene :: Jugador -> Int
elDineroQueTiene = dinero

esMayor :: Int -> Int -> Bool
esMayor unNumero = (> unNumero)
