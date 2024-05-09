--Definir las funciones fst3, snd3, trd3, que dada una tupla de 3 elementos devuelva el elemento
-- correspondiente
fst3 :: (a,b,c) -> a
fst3 (a,_,_) = a

snd3 :: (a,b,c) -> b
snd3 (_,b,_) = b

trd3 :: (a,b,c) -> c
trd3 (_,_,c) = c