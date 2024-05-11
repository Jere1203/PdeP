-- ¡Excelsior! ¡Encontramos la manera de convertir la tierra en oro mágicamente! O eso creían los alquimistas, aunque en realidad no era magia, 
--si no que era ciencia, química para ser exactos.
--Hoy en día, las sustancias químicas abundan. Es por ello que, para llevar un mejor recuento de las sustancias ya existentes y las nuevas 
--creadas, nos decidimos a hacer un sistema con dicho fin, en Haskell.
--En nuestro análisis, nos encontramos con que las sustancias pueden clasificarse en dos tipos: compuestas o sencillas. 
--Las sustancias sencillas son aquellas que se corresponden directamente a un elemento de la tabla periódica, de allí su otro nombre, elemento. 
--De los elementos conocemos su nombre, símbolo químico y número atómico.
--Las sustancias compuestas, o simplemente compuestos, son aquellas que tienen una serie de componentes. Un componente es un par formado por una 
--sustancia y la cantidad de moléculas de esa sustancia. La sustancia del componente puede ser un elemento o un compuesto. Además, los 
--compuestos, al igual que las sustancias simples, tienen un nombre, pero no número atómico. También poseen un símbolo o fórmula química, la 
--cual no nos interesa conocer en todo momento, ya que es deducible a partir de las sustancias que la componen.
--Ah, nos olvidábamos, también sabemos que todas las sustancias poseen un grupo o especie, que puede ser metal, no metal, halógeno o gas noble.

data Sustancia = 
    Elemento {
        nombreElemento :: String,
        simbolo :: String,
        numeroAtomico :: Int,
        grupo :: Grupo
    }
    | Compuesto {
        nombreCompuesto :: String,
        simboloCompuesto :: String,
        componentes :: [Componente],
        grupo :: Grupo
} deriving(Eq, Show)

data Componente = Componente {
    sustancia :: Sustancia,
    cantMoleculas :: Int
} deriving(Eq, Show)

data Grupo = Metal|NoMetal|Halogeno|GasNoble deriving(Eq, Show)

-- 1.Modelar las siguientes sustancias:
--      El hidrógeno y el oxígeno
--      El agua, sustancia compuesta por 2 hidrógenos y 1 un oxígeno.

hidrogeno :: Sustancia
hidrogeno = Elemento{
    nombreElemento = "Hidrogeno",
    simbolo = "H",
    numeroAtomico = 1,
    grupo = NoMetal
}

oxigeno :: Sustancia
oxigeno = Elemento{
    nombreElemento = "Oxigeno",
    simbolo = "O",
    numeroAtomico = 8,
    grupo = NoMetal
}

agua :: Sustancia
agua = Compuesto {
    nombreCompuesto = "Agua",
    simboloCompuesto = "H2O",
    componentes = [Componente hidrogeno 2, Componente oxigeno 1],
    grupo = NoMetal
}

fluor :: Sustancia
fluor = Elemento{
    nombreElemento = "Fluor",
    simbolo = "F",
    numeroAtomico = 9,
    grupo = Halogeno
}

hierro :: Sustancia
hierro = Elemento{
    nombreElemento = "Hierro",
    simbolo = "Fe",
    numeroAtomico = 26,
    grupo = Metal
}

nitrogeno :: Sustancia
nitrogeno = Elemento{
    nombreElemento = "Nitrogeno",
    simbolo = "Ne",
    numeroAtomico = 7,
    grupo = GasNoble
}

mercurio :: Sustancia
mercurio = Elemento{
    nombreElemento = "Mercurio",
    simbolo = "Hg",
    numeroAtomico = 80,
    grupo = Metal
}

-- 2.Poder saber si una sustancia conduce bien según un criterio. Los criterios actuales son electricidad y calor, pero podría haber más. 
--Los metales conducen bien cualquier criterio, sean compuestos o elementos. Los elementos que sean gases nobles conducen bien la electricidad, 
--y los compuestos halógenos conducen bien el calor. Para el resto, no son buenos conductores.
conduceBienCalor :: Sustancia -> Bool
conduceBienCalor sustancia = grupo sustancia == Halogeno || grupo sustancia == Metal

conduceBienElectricidad :: Sustancia -> Bool
conduceBienElectricidad sustancia = grupo sustancia == GasNoble || grupo sustancia == Metal

--3. Obtener el nombre de unión de un nombre. Esto se logra añadiendo “uro” al final del nombre, pero solo si el nombre termina en consonante. 
--Si termina en vocal, se busca hasta la última consonante y luego sí, se le concatena “uro”. Por ejemplo, el nombre de unión del Fluor es 
-- “fluoruro”, mientras que el nombre de unión del mercurio es “mercururo”.
union :: Sustancia -> String
union sustancia
    | not $ esVocal $ last $ nombreElemento sustancia = nombreElemento sustancia ++ "uro" 
    | otherwise = (++ "uro").filtrarVocal $ sustancia
esVocal :: Char -> Bool
esVocal letra = letra `elem` "aeiou"

filtrarVocal :: Sustancia -> String
filtrarVocal sustancia = reverse.dropWhile esVocal.reverse $ nombreElemento sustancia

-- 4. Combinar 2 nombres. Al nombre de unión del primero lo concatenamos con el segundo, agregando un “ de “ entre 
-- medio. Por ejemplo, si combino “cloro” y “sodio” debería obtener “cloruro de sodio”.
combinar :: Sustancia -> Sustancia -> String
combinar sustancia1 sustancia2 = union sustancia1 ++ " de " ++ nombreElemento sustancia2

-- 5. Mezclar una serie de componentes entre sí. El resultado de dicha mezcla será un compuesto. Sus componentes 
-- serán los componentes mezclados. El nombre se forma de combinar los nombres de la sustancia de cada componente. 
-- La especie será, arbitrariamente, un no metal. agdkhjasdgkjh 