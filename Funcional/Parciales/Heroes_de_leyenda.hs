import Text.Show.Functions
---------------
--EJERCICIO 1--
---------------
data Heroe = Heroe{
    epiteto :: String,
    reconocimiento :: Int,
    artefactos :: [Artefacto],
    tareas :: [Tarea]
} deriving (Show)

type Tarea = Heroe -> Heroe

data Artefacto = Artefacto{
    nombre :: String,
    rareza :: Int
} deriving (Show)

jere :: Heroe
jere = Heroe {
    epiteto = "",
    reconocimiento = 1200,
    artefactos = [],
    tareas = []
}

pedro :: Heroe
pedro = Heroe {
    epiteto = "",
    reconocimiento = 600,
    artefactos = [],
    tareas = []
}


---------------
--EJERCICIO 2--
---------------

pasaAHistoria :: Heroe -> Heroe 
pasaAHistoria unHeroe
    | (>1000) . reconocimiento $ unHeroe = cambioEpiteto "El mitico" unHeroe
    | (>=500) . reconocimiento $ unHeroe = cambioEpiteto "El magnifico" . agregarArtefacto lanzaOlimpo $ unHeroe
    | (>100)  . reconocimiento $ unHeroe = cambioEpiteto "Hoplita" . agregarArtefacto xiphos $ unHeroe
    | otherwise                          = unHeroe

cambioEpiteto :: String -> Heroe -> Heroe
cambioEpiteto unEpiteto unHeroe = unHeroe {epiteto = unEpiteto}
agregarArtefacto :: Artefacto -> Heroe -> Heroe
agregarArtefacto unArtefacto unHeroe = unHeroe {artefactos = unArtefacto : artefactos unHeroe}

lanzaOlimpo :: Artefacto
lanzaOlimpo = (Artefacto "Lanza del Olimpo" 100)

xiphos :: Artefacto
xiphos = (Artefacto "Xiphos" 50)

encontrarArtefacto :: Artefacto -> Tarea
encontrarArtefacto unArtefacto unHeroe = modificarReconocimiento (rareza unArtefacto) . agregarArtefacto unArtefacto $ unHeroe

modificarReconocimiento :: Int -> Heroe -> Heroe
modificarReconocimiento incremento unHeroe = unHeroe {reconocimiento = reconocimiento unHeroe + incremento}

--escalarElOlimpo unHeroe = modificarReconocimiento 500 . filtrarMenoresAMil . triplicarRarezaArtefactos . agregarArtefacto relampagoDeZeus $ unHeroe

filtrarMenoresAMil :: [Artefacto] -> [Artefacto]
filtrarMenoresAMil artefactos = filter ((<1000) . rareza) artefactos



---------------
--EJERCICIO 3--
---------------