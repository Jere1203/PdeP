--Un programador Haskell está haciendo las cuentas para un juego de fútbol virtual (como el Hattrick o el ManagerZone). 
--En un momento le llega la información sobre la habilidad de cada jugador de un equipo, que es un número entre 0 y 12, 
--y la orden de subir la forma de todos los jugadores en un número entero; p.ej., subirle 2 la forma a cada jugador. 
--Ahora, ningún jugador puede tener más de 12 de habilidad; si un jugador tiene 11 y la orden es subir 2, pasa a 12, 
--no a 13; si estaba en 12 se queda en 12. 
--Escribir una función subirHabilidad/2 que reciba un número (que se supone positivo sin validar) y una lista de números, 
--y le suba la habilidad a cada jugador cuidando que ninguno se pase de 12.

subirHabilidad :: Int -> [Int] -> [Int]
subirHabilidad nro = map (min 12.(+)nro)