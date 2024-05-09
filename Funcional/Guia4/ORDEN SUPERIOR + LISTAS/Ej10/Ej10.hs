--Definir la función aplicarFunciones/2, que dadas una lista de funciones y un valor cualquiera, 
--devuelve la lista del resultado de aplicar las funciones al valor.
aplicarFunciones :: [a->a] -> a -> [a]
aplicarFunciones f num = map($ num)f