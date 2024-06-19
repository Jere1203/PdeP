import Text.Show.Functions
import Data.List(genericLength)
--
-- * genericLength :: Num i => [a] -> i
-- -- Esta función es exactamente igual que length,
-- -- con la única diferencia que no devuelve un Int, sino un número
-- -- fácil de operar con otro número que pueden o no ser enteros.
-- --
-- -- -- ghci> length "Luigi Mario" / 2
-- -- -- error:
-- -- --     • No instance for (Fractional Int) arising from a use of ‘/’
-- -- --     • In the expression: length "Luigi Mario" / 2
-- -- --       In an equation for ‘it’: it = length "Luigi Mario" / 2
-- -- -- ghci> genericLength "Luigi Mario" / 2
-- -- -- 5.5
