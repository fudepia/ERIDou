Module Calculate

> module Calculate where

> import Control.Parallel.Strategies
> import Data.List

---

Now our analysis will plot (x,y,z)=(radius, points, fractalDepth), with x-y plane facing us and z-Axis pointing into the screen.

> encapPoints::Double->[(Double, Double)]->Int
> encapPoints r n=sum $ map fromEnum (map (\(x,y)->(x*x+y*y)<(r*r)) n)
> calculate::Double->[(Double, Double)]->Double
> calculate r pts = fromIntegral(encapPoints r pts)/r

---

So we know when 
  - r=>Infty, result=>0
  - depth=>Infty, result=>Infty
  - depth::Int, r::Double
  - suppose infinite average converges
  - Then we could integrate it, otherwise we'll have to flip workflow



> res::(Int->[(Double, Double)])->Int->Double->[Double]
> res f depth r=calcAvg (map ((calculate r).f) [1..depth])

Where `f` is a fractal generating function which takes `depth` as argument.

> tellIfApproach::[Double]->Double
> tellIfApproach = last.diff

---

Outputing data

dump snowflake   12          12
     ^generator  ^maxDepth   ^max radius

> dumpDepth:: (Int->[(Double, Double)])->Double->Int->[String]
> dumpDepth f mr depth = do {
>         (map (\r -> 
>             (
>                 (show depth)++", "++(show r)++", "++
>                 (show.last.(res f depth)$r)
>             )
>         ) [1..mr])
> }
> dump:: (Int->[(Double, Double)])->Double->Int->IO()
> dump f mr mDepth = do {
>     putStrLn("# snowflake");
>     putStrLn("depth, r, res");
>     sequence_ (map (putStrLn.(intercalate "\n"))
>         ((map (\d -> 
>             dumpDepth f mr d
>         ) [1..mDepth]) `using` parList rdeepseq)
>     );
> }

---

Analytic Functions

> avg::[Double]->Double
> avg n=(sum n)/(fromIntegral . length $ n)


> diff::[Double]->[Double]
> diff n = init.(map (\(cur,nxt)->nxt-cur))$(zip n ((tail n)++[head n]))

> calcAvg::[Double]->[Double]
> calcAvg = (map (\(i, s)->s/i)).attachId1.(scanl1 (+))
> attachId1 = zip [1..]
