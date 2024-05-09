--Definir una función cambiarHabilidad/2, que reciba una función f y una lista de habilidades, y devuelva el resultado 
--de aplicar f con las garantías de rango que da flimitada. P.ej. 
--Main> cambiarHabilidad (*2) [2,4,6,8,10] 
--[4,8,12,12,12] 
--
--Usar cambiarHabilidad/2 para llevar a 4 a los que tenían menos de 4, dejando como estaban al resto. P.ej. 
--Main> cambiarHabilidad ... [2,4,5,3,8] 
--[4,4,5,4,8] 
--Lo que hay que escribir es completar donde están los puntitos.

cambiarHablidad :: (a->a) -> [a] -> [a]
cambiarHablidad f lista = map(min 12 . $ lista)f

--aplicarFunciones :: [a->a] -> a -> [a]
--aplicarFunciones f num = map($ num)f