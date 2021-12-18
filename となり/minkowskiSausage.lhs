> import System.Environment
> import System.Exit
> import Geometric
> import Calculate
> import Data.List

> main::IO()

> main = getArgs >>= parse

> parse ["-h"] = usage   >> exit
> parse ["--help"] = usage   >> exit
> parse ["--plot", depthStr] = print(minkowski depth) where depth = read depthStr::Int
> parse ["--approach"] = sequence_ (map (\x -> print(tellIfApproach.(res minkowski 12)$x)) [1..])

parse ["--approach", s] = do {putStrLn("# dr\nval, approach-ness");sequence_ (map (\x -> putStrLn((intercalate ", ").(map show)$[
        (last.(res minkowski 12)$x),
        (tellIfApproach.(res minkowski 12)$x)]
    )) [1..n])}
    where n = read s :: Double

> parse ["--approach", mrS] = dump minkowski 12 mr where mr = read mrS::Double
> parse ["--approach", mdS, mrS]= dump minkowski md mr where {mr = read mrS::Double; md=read mdS::Int}
> parse ["--approach", mdS, mrS, "--resume", rdS]= resumeDump minkowski rd md mr where {mr = read mrS::Double; md=read mdS::Int; rd=read rdS::Int}
> parse [d, r] = mainCode d r
> parse [r]     = mainCode "4" r

> usage   = putStrLn "Usage: ./minkowski [--approach] n\nAdd --approach flag to print out in csv format with the additional approach-ness data."

> exit    = exitWith ExitSuccess
> die     = exitWith (ExitFailure 1)

> mainCode::String->String->IO()
> mainCode ds rs =do
>     print("Default depth=4")
>     print(last.(res minkowski d)$r)
>     --print(tellIfApproach.(res minkowski)$x)
>     where {r=read rs :: Double; d=read ds :: Int}

---

> minkowski::Int->[(Double, Double)]
> minkowski 0 = [(-1,0),(1,0)]
> minkowski n = concat (map extend (leftShift (minkowski (n-1))))

> extend::((Double, Double), (Double, Double))->[(Double, Double)]
> extend ((a,b),(c,d)) = map (addVec (a,b)) [(0,0), ud, addVec ud rud, addVec ud2 rud, ud2, addVec ud2 nrud, addVec (addVec ud2 nrud) ud, addVec ud2 ud, addVec ud2 ud2]
>     where ud=((c-a)/4, (d-b)/4)
>           ud2=((c-a)/2, (d-b)/2)
>           rud=(-(d-b)/4, (c-a)/4)
>           nrud=((d-b)/4, -(c-a)/4)

> addVec::(Double, Double)->(Double, Double)->(Double, Double)
> addVec (a,b) (c,d) = (a+c, b+d)

> leftShift n = zip n (tail n++[head n])
