> import System.Environment
> import System.Exit
> import Geometric
> import Calculate(res)


> main = getArgs >>= parse
> parse ["-h"] = usage   >> exit
> parse [n]     = mainCode n

> usage   = putStrLn "Usage: ./calculate [-vh] n"

parse ["-v"] = version >> exit
version = putStrLn "Haskell tac 0.1"

> exit    = exitWith ExitSuccess
> die     = exitWith (ExitFailure 1)

> mainCode::String->IO()
> mainCode s =do
>     print(last.(res snowflake)$x)
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
