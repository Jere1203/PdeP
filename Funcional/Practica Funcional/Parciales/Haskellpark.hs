import Text.Show.Functions
import Data.List

data Atraccion = Atraccion{
    nombre :: String,
    alturaMinima :: Float,
    duracion :: Duracion,
    criticas :: Criticas,
    reparaciones :: Reparaciones,
    mantenimiento :: Bool
} deriving(Show,Eq)

type Criticas = [String]
type Duracion = Float
type Reparaciones = [(Tarea, Duracion)]
type Tarea = Atraccion -> Atraccion

-----------
--Punto 1--
-----------

puntuarAtraccion :: Atraccion -> Float
puntuarAtraccion unaAtraccion
    | duracionMayorA 10 unaAtraccion                       = 100
    | menosDeNReparaciones 3 . reparaciones $ unaAtraccion = (longitudNombre * 10 + cantidadOpiniones * 2)
    | otherwise                                            = (alturaMinima unaAtraccion * 10)
    where
        longitudNombre    = genericLength . nombre $ unaAtraccion
        cantidadOpiniones = genericLength . criticas $ unaAtraccion

duracionMayorA :: Duracion -> Atraccion -> Bool
duracionMayorA unaDuracion = (> unaDuracion) . duracion

menosDeNReparaciones :: Int -> Reparaciones -> Bool
menosDeNReparaciones unaCantidad = (<unaCantidad) . length 

-----------
--Punto 2--
-----------

quitarUltimaTarea :: Atraccion -> Atraccion
quitarUltimaTarea = modificarTareas init

modificarTareas :: (Reparaciones -> Reparaciones) -> Atraccion -> Atraccion
modificarTareas unaTarea unaAtraccion = unaAtraccion {reparaciones = unaTarea $ reparaciones unaAtraccion}

ajustarTornilleria :: Float -> Tarea
ajustarTornilleria cantidadTornillos unaAtraccion = modificarDuracion (min 10 . (+) cantidadTornillos) $ unaAtraccion

modificarDuracion :: (Float -> Float) -> Atraccion -> Atraccion
modificarDuracion cantidadDeDuracion unaAtraccion = unaAtraccion{duracion = cantidadDeDuracion $ duracion unaAtraccion}

realizarEngrase :: Float -> Tarea
realizarEngrase gramosDeGrasa unaAtraccion = agregarOpinion "Para Valientes" . modificarAlturaMinima (+alturaPorGramosDeGrasa) $ unaAtraccion

    where
        alturaPorGramosDeGrasa = gramosDeGrasa * 0.1

agregarOpinion :: String -> Atraccion -> Atraccion
agregarOpinion unaOpinion unaAtraccion = unaAtraccion{criticas = unaOpinion : criticas unaAtraccion}

modificarAlturaMinima :: (Float -> Float) -> Atraccion -> Atraccion
modificarAlturaMinima unaAltura unaAtraccion = unaAtraccion{alturaMinima = unaAltura $ alturaMinima unaAtraccion}

mantenimientoElectrico :: Tarea
mantenimientoElectrico unaAtraccion = unaAtraccion{criticas = take 2 . criticas $ unaAtraccion}

mantenimientoBasico :: Tarea
mantenimientoBasico = ajustarTornilleria 8 . realizarEngrase 10

realizarMantenimiento :: Tarea -> Atraccion -> Atraccion
realizarMantenimiento tareaDeMantenimiento unaAtraccion
    | estaEnMantenimiento unaAtraccion = quitarUltimaTarea . tareaDeMantenimiento $ unaAtraccion
    | otherwise                        = unaAtraccion

estaEnMantenimiento :: Atraccion -> Bool
estaEnMantenimiento = (==True) . mantenimiento

-----------
--Punto 3--
-----------

meDaMiedito :: Atraccion -> Bool
meDaMiedito = any (>4) . tiemposDeReparacion

tiemposDeReparacion :: Atraccion -> [Duracion]
tiemposDeReparacion = map snd . reparaciones

cierraAtraccion :: Atraccion -> Bool
cierraAtraccion = (>7) . sum . tiemposDeReparacion 

type Parque = [Atraccion]

disneyNoEsistis :: Parque -> Bool --Tiene nombre cheto && no tiene reparaciones pendientes (SOLO CON COMPOSICION Y APLICACION PARCIAL)
disneyNoEsistis = all (null . reparaciones) . filter ((>5) . genericLength . nombre)

-----------
--Punto 4--
-----------

tieneReparacionesPiolas :: Atraccion -> Bool
tieneReparacionesPiolas unaAtraccion
    | not . null . reparaciones $ unaAtraccion = mejorQueAntes && tieneReparacionesPiolas (modificarTareas (drop 1) unaAtraccion)
    | otherwise                                = True

    where
        mejorQueAntes = (puntuarAtraccion . realizarMantenimiento (head . listaDeTareas $ unaAtraccion) $ unaAtraccion) > (puntuarAtraccion unaAtraccion)

listaDeTareas :: Atraccion -> [Tarea]
listaDeTareas = map fst . reparaciones

-----------
--Punto 5--
-----------

realizarTrabajosDeMantenimiento :: Atraccion -> Atraccion
realizarTrabajosDeMantenimiento unaAtraccion = foldl (flip realizarMantenimiento) unaAtraccion (listaDeTareas unaAtraccion)

-----------
--Punto 6--
-----------
-- Si se realizan infinitos trabajos sobre una atraccion no se podrá obtener un resultado final en el punto 4 ya que estará constantemente realizando modificaciones a la atraccion
-- Se podrá arribar a un resultado final en el momento que una de las tareas no cumpla con la condicion que el puntaje sea mayor que en el caso anterior, esto debido a que Haskell funciona
-- bajo el paradigma de Lazy Evaluation, donde no se realizan operaciones que no son solicitadas. En pocas palabras, una vez que arribe aun resultado False dejará de operar y obtendrá ese False como resultado final.