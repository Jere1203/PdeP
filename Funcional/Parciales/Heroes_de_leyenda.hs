data Heroe = Heroe{
    nombreHeroe :: String,
    epiteto :: String,
    reconocimiento :: Int,
    artefactos :: [Artefacto]
} deriving (Show, Eq)

data Artefacto = Artefacto{
    nombreArtefacto :: String,
    rareza :: Int
} deriving(Show, Eq)

jorge = (Heroe "Jorge" "" 1001 [])
luis = (Heroe "Luis" "" 850 [])
jeremias = (Heroe "Jeremias" "" 300 [])
pedro = (Heroe "Pedro" "" 50 [])

lanzaOlimpo = (Artefacto "Lanza del Olimpo" 100)
xiphos = (Artefacto "Xiphos" 50)

pasaAHistoria :: Heroe -> Heroe 
pasaAHistoria (Heroe nombreHeroe epiteto reconocimiento artefactos)
    |reconocimiento > 1000 = (Heroe nombreHeroe (epiteto ++ "El mitico") reconocimiento artefactos) --No recibe artefacto
    |reconocimiento >= 500 && reconocimiento <= 1000 = (Heroe nombreHeroe (epiteto ++ "El magnifico") reconocimiento (lanzaOlimpo : artefactos))
    |reconocimiento < 500 && reconocimiento > 100 = (Heroe nombreHeroe (epiteto ++ "Hoplita") reconocimiento (xiphos : artefactos))
    |otherwise = (Heroe nombreHeroe epiteto reconocimiento artefactos)