import Text.Show.Functions
import Data.List

data Atraccion = Atraccion{
    nombre :: String,
    alturaMinima :: Float,
    duracion :: Duracion,
    puntuacion :: Float,
    criticas :: Criticas,
    reparaciones :: Reparaciones
}
type Criticas = [String]
type Duracion = Float
type Reparaciones = [(Tarea, Duracion)]
type Tarea = Atraccion -> Atraccion

-----------
--Punto 1--
-----------

puntuarAtraccion :: Atraccion -> Atraccion
puntuarAtraccion unaAtraccion
    | duracionMayorA 10 unaAtraccion          = asignarPuntuacion 100 $ unaAtraccion
    | menosDe 3 . reparaciones $ unaAtraccion = asignarPuntuacion (longitudNombre * 10 + cantidadOpiniones * 2) $ unaAtraccion
    | otherwise                               = asignarPuntuacion (alturaMinima unaAtraccion * 10) $ unaAtraccion
    where
        longitudNombre = genericLength . nombre $ unaAtraccion
        cantidadOpiniones = genericLength . criticas $ unaAtraccion

duracionMayorA :: Duracion -> Atraccion -> Bool
duracionMayorA unaDuracion = (> unaDuracion) . duracion

menosDe :: Int -> Reparaciones -> Bool
menosDe unaCantidad = (<unaCantidad) . length 

asignarPuntuacion :: Float -> Atraccion -> Atraccion
asignarPuntuacion unaPuntuacion unaAtraccion = unaAtraccion{puntuacion = unaPuntuacion}

-----------
--Punto 2--
-----------

estaEnMantenimiento :: Atraccion -> Bool
estaEnMantenimiento unaAtraccion = not . null . reparaciones $ unaAtraccion

quitarUltimaTarea :: Atraccion -> Atraccion
quitarUltimaTarea = modificarTareas init

modificarTareas :: (Reparaciones -> Reparaciones) -> Atraccion -> Atraccion
modificarTareas reparacion unaAtraccion = unaAtraccion {reparaciones = reparacion $ reparaciones unaAtraccion}

type Mantenimento = Atraccion -> Atraccion

ajustarTornilleria :: Float -> Mantenimento
ajustarTornilleria cantidadTornillos unaAtraccion = modificarDuracion (+ min 10 cantidadTornillos) $ unaAtraccion

modificarDuracion :: (Float -> Float) -> Atraccion -> Atraccion
modificarDuracion cantidadDeDuracion unaAtraccion = unaAtraccion{duracion = cantidadDeDuracion $ duracion unaAtraccion}

realizarEngrase :: Float -> Mantenimento
realizarEngrase gramosDeGrasa unaAtraccion = agregarOpinion "Para Valientes" . modificarAlturaMinima (+alturaPorGramosDeGrasa) $ unaAtraccion

    where
        alturaPorGramosDeGrasa = gramosDeGrasa * 0.1

agregarOpinion :: String -> Atraccion -> Atraccion
agregarOpinion unaOpinion unaAtraccion = unaAtraccion{criticas = unaOpinion : criticas unaAtraccion}

modificarAlturaMinima :: (Float -> Float) -> Atraccion -> Atraccion
modificarAlturaMinima unaAltura unaAtraccion = unaAtraccion{alturaMinima = unaAltura $ alturaMinima unaAtraccion}

mantenimientoElectrico :: Mantenimento
mantenimientoElectrico = modificarCriticas

modificarCriticas :: Atraccion -> Atraccion
modificarCriticas unaAtraccion = unaAtraccion{criticas = reverse . drop todasMenosDos . reverse . criticas $ unaAtraccion}
    where
        todasMenosDos = (length $ criticas unaAtraccion) - 2

mantenimientoBasico :: Mantenimento
mantenimientoBasico = ajustarTornilleria 8 . realizarEngrase 10

realizarMantenimiento :: Mantenimento -> Atraccion -> Atraccion
realizarMantenimiento tareaDeMantenimiento unaAtraccion
    | estaEnMantenimiento unaAtraccion = quitarUltimaTarea . tareaDeMantenimiento $ unaAtraccion
    | otherwise                        = unaAtraccion

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

tieneReparacionesPiolas :: [Mantenimento] -> Atraccion -> Bool
tieneReparacionesPiolas [] _                = False
tieneReparacionesPiolas (x:xs) unaAtraccion = mejorQueAntes && tieneReparacionesPiolas xs unaAtraccion

    where
        mejorQueAntes = (puntuacion . realizarMantenimiento x $ unaAtraccion) > (puntuacion unaAtraccion)

-----------
--Punto 5--
-----------

realizarTrabajosDeMantenimiento :: [Mantenimento] -> Atraccion -> Atraccion
realizarTrabajosDeMantenimiento unasTareas unaAtraccion = foldl (flip realizarMantenimiento) unaAtraccion unasTareas

-----------
--Punto 6--
-----------
-- Si se realizan infinitos trabajos sobre una atraccion no se podrá obtener un resultado final en el punto 4 ya que estará constantemente realizando modificaciones a la atraccion
-- Se podrá arribar a un resultado final en el momento que una de las tareas no cumpla con la condicion que el puntaje sea mayor que en el caso anterior, esto debido a que Haskell funciona
-- bajo el paradigma de Lazy Evaluation, donde no se realizan operaciones que no son solicitadas. En pocas palabras, una vez que arribe aun resultado False dejará de operar y obtendrá ese False como resultado final.