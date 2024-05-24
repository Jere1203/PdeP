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
} deriving (Show, Eq)

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
lanzaOlimpo = Artefacto "Lanza del Olimpo" 100

xiphos :: Artefacto
xiphos = Artefacto "Xiphos" 50
---------------
--EJERCICIO 3--
---------------

encontrarArtefacto :: Artefacto -> Tarea
encontrarArtefacto unArtefacto unHeroe = modificarReconocimiento (rareza unArtefacto) . agregarArtefacto unArtefacto $ unHeroe

modificarReconocimiento :: Int -> Heroe -> Heroe
modificarReconocimiento incremento unHeroe = unHeroe {reconocimiento = reconocimiento unHeroe + incremento}

modificarArtefacto :: ([Artefacto] -> [Artefacto]) -> Heroe -> Heroe
modificarArtefacto f unHeroe = unHeroe {artefactos = f $ artefactos unHeroe}

relampagoDeZeus :: Artefacto
relampagoDeZeus = Artefacto "Relampago de Zeus" 500

escalarElOlimpo :: Tarea
escalarElOlimpo unHeroe = modificarReconocimiento 500 . desecharArtefactos . triplicarRarezaArtefactos . agregarArtefacto relampagoDeZeus $ unHeroe

desecharArtefactos :: Heroe -> Heroe
desecharArtefactos unHeroe = modificarArtefacto (filtrarMenoresAMil) unHeroe

filtrarMenoresAMil :: [Artefacto] -> [Artefacto]
filtrarMenoresAMil artefactos = filter ((>1000) . rareza) artefactos

triplicarRarezaArtefactos :: Heroe -> Heroe
triplicarRarezaArtefactos unHeroe = modificarArtefacto (map triplicarRareza) $ unHeroe

triplicarRareza :: Artefacto -> Artefacto
triplicarRareza unArtefacto = unArtefacto {rareza = (*3) . rareza $ unArtefacto}

ayudarACruzarLaCalle :: Int -> Heroe -> Heroe
ayudarACruzarLaCalle cantCuadras unHeroe = unHeroe {epiteto = "Gros" ++ replicate cantCuadras 'o'}

matarUnaBestia :: Bestia -> Heroe -> Heroe
matarUnaBestia unaBestia unHeroe
    | debilidad unaBestia $ unHeroe = cambioEpiteto ("El asesino de " ++ nombreBestia unaBestia) $ unHeroe
    | otherwise                              = cambioEpiteto "El cobarde" . modificarArtefacto (drop 1) $ unHeroe

data Bestia = Bestia{
    nombreBestia :: String,
    debilidad :: Debilidad
} deriving (Show)

type Debilidad = Heroe -> Bool

---------------
--EJERCICIO 4--
---------------

heracles :: Heroe
heracles = Heroe{
    epiteto = "Guardian del Olimpo",
    reconocimiento = 700,
    artefactos = [pistolaGriega, relampagoDeZeus],
    tareas = []
}

pistolaGriega :: Artefacto
pistolaGriega = Artefacto{
    nombre = "Pistola griega",
    rareza = 1000
}

---------------
--EJERCICIO 5--
---------------

matarLeonDeMemea :: Tarea
matarLeonDeMemea unHeroe = matarUnaBestia (leonDeMemea) $ unHeroe

leonDeMemea :: Bestia
leonDeMemea = Bestia{
    nombreBestia = "Leon de Memea",
    debilidad = (>=20) . length . epiteto 
}