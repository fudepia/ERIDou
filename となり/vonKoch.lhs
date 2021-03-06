> import System.Environment
> import System.Exit
> import Geometric
> import Calculate
> import Data.List

> main::IO()

> main = getArgs >>= parse

> parse ["-h"] = usage   >> exit
> parse ["--help"] = usage   >> exit
> parse ["--plot", depthStr] = print(vonKoch depth) where depth = read depthStr::Int
> parse ["--approach"] = sequence_ (map (\x -> print(tellIfApproach.(res vonKoch 12)$x)) [1..])

parse ["--approach", s] = do {putStrLn("# dr\nval, approach-ness");sequence_ (map (\x -> putStrLn((intercalate ", ").(map show)$[
        (last.(res vonKoch 12)$x),
        (tellIfApproach.(res vonKoch 12)$x)]
    )) [1..n])}
    where n = read s :: Double

> parse ["--approach", mrS] = dump vonKoch 12 mr where mr = read mrS::Double
> parse ["--approach", mdS, mrS]= dump vonKoch md mr where {mr = read mrS::Double; md=read mdS::Int}
> parse ["--approach", mdS, mrS, "--resume", rdS]= resumeDump vonKoch rd md mr where {mr = read mrS::Double; md=read mdS::Int; rd=read rdS::Int}
> parse [d, r] = mainCode d r
> parse [r]     = mainCode "4" r

> usage   = putStrLn "Usage: ./vonKoch [--approach] n\nAdd --approach flag to print out in csv format with the additional approach-ness data."

> exit    = exitWith ExitSuccess
> die     = exitWith (ExitFailure 1)

> mainCode::String->String->IO()
> mainCode ds rs =do
>     print("Default depth=4")
>     print(last.(res vonKoch d)$r)
>     --print(tellIfApproach.(res vonKoch)$x)
>     where {r=read rs :: Double; d=read ds :: Int}

---

First we'll create function that returns coordinate for Koch's Snowflake

> vonKoch::Int->[(Double, Double)]
> vonKoch(0)=[(0,0), (1,0)]
> vonKoch(1)=[(0,0), (1/3, 0), (1/2, sqrt(3)/6), (2/3, 0), (1, 0)]
> vonKoch(n)= concat [sc (vonKoch(n-1)),trs0.sc.rcc$vonKoch(n-1), trs1.sc.rcw$vonKoch(n-1), trs2.sc$vonKoch(n-1)]

Where both takes depth as argument and vonKoch returns the single side with endpoint at (0,0) and (1,0), whereas vonKoch returns the whole vonKoch centered at origin.

---
