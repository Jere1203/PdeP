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

---------------
--EJERCICIO 6--
---------------

hacerUnaTarea :: Tarea -> Heroe -> Heroe
hacerUnaTarea unaTarea unHeroe = unaTarea $ unHeroe

agregarTarea :: Tarea -> Heroe -> Heroe
agregarTarea unaTarea unHeroe = unHeroe {tareas = unaTarea : tareas unHeroe}
---------------
--EJERCICIO 7--
---------------

presumirLogros :: Heroe -> Heroe -> (Heroe,Heroe)
presumirLogros heroeUno heroeDos
    | gana heroeUno heroeDos = (heroeUno, heroeDos)
    | gana heroeDos heroeUno = (heroeDos, heroeUno)
    | otherwise              = presumirLogros (hacerTareasDe heroeUno $ heroeDos) (hacerTareasDe heroeDos $ heroeUno)

hacerTareasDe :: Heroe -> Heroe -> Heroe
hacerTareasDe heroe1 heroe2 = realizarLabores (tareas heroe1) $ heroe2

gana :: Heroe -> Heroe -> Bool
gana heroe1 heroe2 = reconocimiento heroe1 > reconocimiento heroe2 || reconocimiento heroe1 == reconocimiento heroe2 && sumaRarezas heroe1 > sumaRarezas heroe2

sumaRarezas :: Heroe -> Int
sumaRarezas unHeroe = sum . map rareza . artefactos $ unHeroe
---------------
--EJERCICIO 8--
---------------
-- ¿Cuál es el resultado de hacer que presuman dos héroes con reconocimiento 100, ningún artefacto y
-- ninguna tarea realizada?

-- Nunca se sabe el resultado final ya que la función queda en un estado recursivo permanente ya que núnca se aproxima al caso base (permanece comparando reconocimiento y como ninguno tiene ninguna tarea para apliacar nunca cambian sus estados).

---------------
--EJERCICIO 9--
---------------

realizarLabores :: [Tarea] -> Heroe -> Heroe
realizarLabores unasTareas unHeroe = foldl (flip hacerUnaTarea) unHeroe unasTareas

---------------
--EJERCICIO 10--
---------------

-- Si invocamos la función anterior con una labor infinita,
-- ¿se podrá conocer el estado final del héroe? ¿Por qué?

-- No, ya que nunca se llegará a un estado final del héroe ya que haskell solo muestra el estado final una vez aplicada la funcion.