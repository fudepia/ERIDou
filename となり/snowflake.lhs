> import System.Environment
> import System.Exit
> import Geometric
> import Calculate
> import Data.List

> main::IO()
> main = dump snowflake 4 12

main = getArgs >>= parse

> parse ["-h"] = usage   >> exit
> parse ["--help"] = usage   >> exit
> parse ["--approach"] = sequence_ (map (\x -> print(tellIfApproach.(res snowflake 12)$x)) [1..])
> parse ["--approach", s] = do {putStrLn("# dr\nval, approach-ness");sequence_ (map (\x -> putStrLn((intercalate ", ").(map show)$[
>         (last.(res snowflake 12)$x),
>         (tellIfApproach.(res snowflake 12)$x)]
>     )) [1..n])}
>     where n = read s :: Double
> parse [n]     = mainCode n

> usage   = putStrLn "Usage: ./calculate [--approach] n\nAdd --approach flag to print out in csv format with the additional approach-ness data."

> exit    = exitWith ExitSuccess
> die     = exitWith (ExitFailure 1)

> mainCode::String->IO()
> mainCode s =do
>     print(last.(res snowflake 12)$x)
>     --print(tellIfApproach.(res snowflake)$x)
>     where x=read s :: Double

---

First we'll create function that returns coordinate for Koch's Snowflake

> vonKoch::Int->[(Double, Double)]
> vonKoch(0)=[(0,0), (1,0)]
> vonKoch(1)=[(0,0), (1/3, 0), (1/2, sqrt(3)/6), (2/3, 0), (1, 0)]
> vonKoch(n)= concat [sc (vonKoch(n-1)),trs0.sc.rcc$vonKoch(n-1), trs1.sc.rcw$vonKoch(n-1), trs2.sc$vonKoch(n-1)]

> snowflake::Int->[(Double, Double)]
> snowflake n = translate (-1/2, sqrt(3)/6) (concat [vonKoch n, (translate (1,0)).rcw.rcw.vonKoch$n, (translate (1/2, -sqrt(3)/2)).rcc.rcc.vonKoch$n])

Where both takes depth as argument and vonKoch returns the single side with endpoint at (0,0) and (1,0), whereas snowflake returns the whole snowflake centered at origin.

---
