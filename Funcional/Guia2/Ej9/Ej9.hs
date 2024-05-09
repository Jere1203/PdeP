--Definir una función incrementMCuadradoN, que invocándola con 2 números m y n, incrementa un valor m al cuadrado de n
incrementMCuadradoN :: (Num a, Integral a) => a -> a -> a
incrementMCuadradoN m n = ((n+).(^2)) m