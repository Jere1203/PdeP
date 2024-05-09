--Definir una función esResultadoPar/2, que invocándola con número n y otro m, 
--devuelve true si el resultado de elevar n a m es par.
esResultadoPar :: (Num a, Ord a, Integral a) => a -> a -> Bool
esResultadoPar n m = (even.(^m))n