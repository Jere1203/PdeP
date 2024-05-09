
--Dispersión
--Trabajamos con tres números que imaginamos como el nivel del río Paraná a la altura de Corrientes medido en tres días consecutivos; cada medición es un entero que representa una cantidad de cm. 
--P.ej. medí los días 1, 2 y 3, las mediciones son: 322 cm, 283 cm, y 294 cm. 
--A partir de estos tres números, podemos obtener algunas conclusiones. 
--Definir estas funciones: 
--
--dispersion, que toma los tres valores y devuelve la diferencia entre el más alto y el más bajo. Ayuda: extender max y min a tres argumentos, usando las versiones de dos elementos. De esa forma se puede definir dispersión sin escribir ninguna guarda (las guardas están en max y min, que estamos usando). 
--
--diasParejos, diasLocos y diasNormales reciben los valores de los tres días. Se dice que son días parejos si la dispersión es chica, que son días locos si la dispersión es grande, y que son días normales si no son ni parejos ni locos. Una dispersión se considera chica si es de menos de 30 cm, y grande si es de más de un metro. 
--Nota: Definir diasNormales a partir de las otras dos, no volver a hacer las cuentas.

mayor :: Ord a => a -> a -> a -> a
mayor x y z = x `max` y `max` z

menor :: Ord a => a -> a -> a -> a
menor x y z = x `min` y `min` z

dispersion :: (Num a, Ord a) => a -> a -> a -> a
dispersion x y z = mayor x y z - menor x y z

diasParejos :: (Num a, Ord a, Fractional a) => a -> a -> a ->Bool --si la dispersion es < 30 centimetros
diasParejos x y z = dispersion x y z < 30

diasLocos :: (Num a, Ord a) => a -> a -> a -> Bool --Si dispersion > 1m
diasLocos x y z = dispersion x y z > 100

diasNormales :: (Num a, Ord a, Fractional a) => a -> a -> a -> Bool --No es parejo ni loco
diasNormales x y z = not(diasLocos x y z ) && not(diasParejos x y z)