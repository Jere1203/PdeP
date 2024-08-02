import Data.List
import Text.Show.Functions

-----------
--Punto 1--
-----------

data Chico = Chico{
    nombre :: String,
    edad :: Int,
    habilidades :: Habilidades,
    deseos :: Deseos
} deriving(Show)

type Habilidades = [String]
type Habilidad = String
type Deseos = [Deseo]
type Deseo = Chico -> Chico

timmy = Chico "Timmy" 10 ["mirar television", "jugar en la pc"] [serMayor]

aprenderHabilidades :: Habilidades -> Deseo
aprenderHabilidades habilidades = agregarHabilidades habilidades --Aplicacion parcial para ganar expresividad

agregarHabilidades :: [String] -> Chico -> Chico
agregarHabilidades habilidades = modificarHabilidades (habilidades ++) --Aplicacion parcial para ganar expresividad

modificarHabilidades :: ([String] -> [String]) -> Chico -> Chico --Orden superior ya que recibe una funcion de lista de strings por parámetro
modificarHabilidades unaFuncion unChico = unChico {habilidades = unaFuncion $ habilidades unChico} 

serGrosoEnNeedForSpeed :: Deseo
serGrosoEnNeedForSpeed =  agregarHabilidades . map serGrosoNVeces $ [1..]
--Lista infinita para agregar infinitas habilidades de "jugar need for speed" y composicion para ganar expresividad
--Si llamamos a la funcion "serGrosoEnNeedForSpeed" con un chico como argumento la misma nos generara otro chico con las habilidades "jugar need for speed 1" hasta infinitos "jugar need for speed x", siendo x el numero siguiente
--Se utilizo la lista infinita para ayudar a agregar las habilidades de jugar todos los need for speed anteriores y posteriores.
--De esta lista de infinitos "jugar need for speed" podriamos operar sobre ella para obtener n cantidad de elementos y/u obtener un elemento n de la lista, ya que haskell utiliza Lazy Evaluation, motivo por el cual no tendríamos
--mayor inconveniente al realizar la operación ya que lo que no considera necesario no lo evalúa.
--No podríamos pedirle la longitud de la lista ya que nunca se llegaría a un resultado final.

serGrosoNVeces :: Int -> String
serGrosoNVeces n = "jugar need for speed " ++ show n

serMayor :: Deseo
serMayor = modificarEdad (const 18) --Aplicacion parcial para ganar expresividad

modificarEdad :: (Int -> Int) -> Chico -> Chico --Orden superior ya que recibe una funcion que va de enteros a enteros por parámetro
modificarEdad unaFuncion unChico = unChico {edad = unaFuncion $ edad unChico} 

wanda :: Chico -> Chico
wanda  = hacerMadurar . cumplirPrimerDeseo --Aplicacion parcial y composicion para ganar expresividad

cumplirPrimerDeseo :: Chico -> Chico
cumplirPrimerDeseo unChico = cumplirDeseo (primerDeseo unChico) unChico

primerDeseo :: Chico -> Deseo
primerDeseo = head . deseos --Aplicacion parcial y composicion para ganar expresividad

cumplirDeseo :: Deseo -> Chico -> Chico
cumplirDeseo unDeseo = unDeseo --Aplicacion parcial para ganar expresividad

hacerMadurar :: Chico -> Chico
hacerMadurar = modificarEdad (+1) --Aplicacion parcial para ganar expresividad

cosmo :: Chico -> Chico
cosmo = hacerDesmadurar --Aplicacion parcial para ganar expresividad

hacerDesmadurar :: Chico -> Chico
hacerDesmadurar = modificarEdad (flip div 2) --Aplicacion parcial para ganar expresividad

muffinMagico :: Chico -> Chico
muffinMagico = cumplirDeseos --Aplicacion parcial

cumplirDeseos :: Chico -> Chico
cumplirDeseos unChico = foldl (flip cumplirDeseo) unChico (deseos unChico) --Orden superior, ya que la funcion "foldl" recibe otra funcion por parámetro

-- ==================================================Parte B========================================

-----------
--Punto 1--
-----------

tieneHabilidad :: Habilidad -> Chico -> Bool
tieneHabilidad unaHabilidad = any (== unaHabilidad) . habilidades --Composicion y aplicacion parcial

esSuperMaduro :: Chico -> Bool
esSuperMaduro unChico = edad unChico > 18 && sabeManejar unChico

sabeManejar :: Chico -> Bool
sabeManejar = any (== "manejar") . habilidades --Aplicacion parcial y composicion

-----------
--Punto 2--
-----------

data Chica = Chica{
    nombreChica :: String,
    condicion :: Condicion
} deriving (Show)

type Condicion = Chico -> Bool

trixie = Chica "Trixie Tang" noEsTimmy

vicky = Chica "Vicky" condicionVicky

condicionVicky :: Condicion
condicionVicky = tieneHabilidad "ser un supermodelo noruego" -- Aplicacion parcial

noEsTimmy :: Chico -> Bool
noEsTimmy unChico = nombre unChico /= "Timmy"

quienConquistaA :: Chica -> [Chico] -> Chico
quienConquistaA unaChica losPretendientes
    | quedaUnUnicoPretendiente                         = last losPretendientes
    | cumpleConLaCondicion unaChica primerPretendiente = primerPretendiente
    | otherwise                                        = quienConquistaA unaChica (tail losPretendientes)
    where
        primerPretendiente = head losPretendientes
        quedaUnUnicoPretendiente = length losPretendientes == 1

cumpleConLaCondicion :: Chica -> Chico -> Bool
cumpleConLaCondicion unaChica = condicion unaChica --Aplicacion parcial
    
ejemplo = Chica "Ejemplo" sabeCocinar

-- quienConquistaA ejemplo [timmy] = timmy, ya que a pesar de no cumplir con la condicion es el unico chico en la lista.
--quienConquistaA ejemplo [timmy,ejemplo2] = ejemplo2, ya que entre sus habilidades se encuentra "cocinar"

sabeCocinar :: Condicion
sabeCocinar = any (== "cocinar") . habilidades --Aplicacion parcial y composicion

-- =======================================================PARTE C=======================================================0

-----------
--Punto 1--
-----------

ejemplo2 = Chico "Ejemplo 2" 10 ["cocinar","jugar need for speed","ver la tele","jugar a la pc","hablar ingles","ser un supermodelo noruego"] [dominarElMundo]

dominarElMundo :: Deseo
dominarElMundo = agregarHabilidades ["dominar el mundo"] --Aplicacion parcial

infractoresDeDaRules :: [Chico] -> [Chico]
infractoresDeDaRules chicos = filter (tieneDeseoProhibido) chicos

tieneDeseoProhibido :: Chico -> Bool
tieneDeseoProhibido = hayHabilidadProhibida . primerasCincoHabilidades . cumplirDeseos --Composicion y aplicacion parcial

hayHabilidadProhibida :: Chico -> Bool
hayHabilidadProhibida unChico = tieneHabilidad "enamorar" unChico || tieneHabilidad "matar" unChico || tieneHabilidad "dominar el mundo" unChico

primerasCincoHabilidades :: Chico -> Chico
primerasCincoHabilidades = modificarHabilidades (take 5) --Aplicacion parcial

