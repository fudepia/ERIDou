Module Calculate

> module Calculate where

> import Control.Parallel.Strategies
> import Data.List
> import System.IO

---

Now our analysis will plot (x,y,z)=(radius, points, fractalDepth), with x-y plane facing us and z-Axis pointing into the screen.

> encapPoints::Double->[(Double, Double)]->Int
> encapPoints r n=sum $ map fromEnum ((map (\(x,y)->(x*x+y*y)<(r*r)) n) `using` parList rdeepseq)
> calculate::Double->[(Double, Double)]->Double
> calculate r pts = fromIntegral(encapPoints r pts)/r

---

So we know when 
  - r=>Infty, result=>0
  - depth=>Infty, result=>Infty
  - depth::Int, r::Double
  - suppose infinite average converges
  - Then we could integrate it, otherwise we'll have to flip workflow



> resPreManip::(Int->[(Double, Double)])->Int->Double->[Double]
> resPreManip f depth r=calcAvg ((map ((calculate r).f) [1..depth]) `using` parList rdeepseq)
> resManip::Int->Double->Double->Double
> resManip depth r x = depth `root` x
> res::(Int->[(Double, Double)])->Int->Double->[Double]
> res f depth r = (map (resManip depth r) (resPreManip f depth r)) `using` parList rdeepseq

Where `f` is a fractal generating function which takes `depth` as argument.

> tellIfApproach::[Double]->Double
> tellIfApproach = last.diff

---

Outputing data

dump snowflake   12          12
     ^generator  ^maxDepth   ^maxRadius

> dumpDepth:: (Int->[(Double, Double)])->Int->Double->[String]
> dumpDepth f depth mr = do {
>         (map (\r -> 
>             (
>                 (show depth)++", "++(show r)++", "++
>                 (show.last.(res f depth)$r)
>             )
>         ) [1..mr])
> }
> dump:: (Int->[(Double, Double)])->Int->Double->IO()
> dump f mDepth mr = do {
>     hSetBuffering stdout LineBuffering;
>     putStrLn("# snowflake");
>     putStrLn("depth, r, res");
>     sequence_ (map (putStrLn.(intercalate "\n"))
>         ((map (\d -> 
>             dumpDepth f d mr
>         ) [1..mDepth]))
>     );
> }
> resumeDump:: (Int->[(Double, Double)])->Int->Int->Double->IO()
> resumeDump f rd mDepth mr = do {
>     --hSetBuffering stdout LineBuffering;
>     hSetBuffering stdout NoBuffering;
>     sequence_ (map (putStrLn.(intercalate "\n"))
>         ((map (\d -> 
>             dumpDepth f d mr
>         ) [rd..mDepth]))
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

> root::Int->Double->Double
> n `root` x = x**(recip.fromIntegral$n)
