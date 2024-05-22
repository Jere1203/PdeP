data Heroe = Heroe{
    nombreHeroe :: String,
    epiteto :: String,
    reconocimiento :: Int,
    artefactos :: [Artefacto],
    tareas :: [Tarea]
} deriving (Show, Eq)

data Artefacto = Artefacto{
    nombreArtefacto :: String,
    rareza :: Int
} deriving(Show, Eq)

jorge :: Heroe
jorge = Heroe "Jorge" "" 1001 []

luis :: Heroe
luis = Heroe "Luis" "" 850 []

jeremias :: Heroe
jeremias = Heroe "Jeremias" "" 300 []

pedro :: Heroe
pedro = Heroe "Pedro" "" 50 []

lanzaOlimpo :: Artefacto
lanzaOlimpo = (Artefacto "Lanza del Olimpo" 100)
xiphos :: Artefacto
xiphos = (Artefacto "Xiphos" 50)

pasaAHistoria :: Heroe -> Heroe 
pasaAHistoria (Heroe nombreHeroe epiteto reconocimiento artefactos tareas)
    |reconocimiento > 1000 = (Heroe nombreHeroe "El mitico" reconocimiento artefactos tareas) --No recibe artefacto
    |reconocimiento >= 500 = (Heroe nombreHeroe "El magnifico" reconocimiento (lanzaOlimpo : artefactos) tareas)
    |reconocimiento >  100 = (Heroe nombreHeroe "Hoplita" reconocimiento (xiphos : artefactos) tareas)
    |otherwise             = (Heroe nombreHeroe epiteto reconocimiento artefactos tareas)



-- Tareas --

type Tarea = Heroe -> Heroe

encontrarArtefacto :: Artefacto -> Tarea
    encontrarArtefacto unArtefacto (Heroe _ _ reconocimiento artefactos _) = (Heroe (aumentarReconocimiento rareza unArtefacto) (unArtefacto : artefactos))

aumentarReconocimiento :: Int -> Heroe -> Heroe
aumentarReconocimiento cantidad (Heroe _ _ reconocimiento _ _) = reconocimiento + cantidad

escalarElOlimpo :: Tarea
escalarElOlimpo (Heroe _ _ reconocimiento artefactos _) = (Heroe aumentarReconocimiento 500 triplicarRarezaArtefactos (relampagoDeZeus : artefactos))

triplicarRarezaArtefactos :: Heroe -> Heroe
triplicarRarezaArtefactos (Heroe _ _ _ artefactos _) = map (*3) rareza.artefactos