> main::IO()
> main=do
>     last.res$4
>     tellIfApproach.res$4

Generic Geometric Functions

> translate::(Double, Double)->[(Double, Double)]->[(Double, Double)]
> translate d n = map(\(x,y) -> (fst d+x, snd d+y)) n
> trs0 = translate (1/3, 0)
> trs1 = translate (1/2, sqrt(3)/6)
> trs2 = translate (2/3, 0)

Rotation base on Origin

> rotate::Double->[(Double, Double)]->[(Double, Double)]
> rotate d n = map(\(x,y) -> (x*cos(d)-y*sin(d), x*sin(d)+y*cos(d))) n
> rcw = rotate (-pi/3)
> rcc = rotate (pi/3)

> mirror::[(Double, Double)]->[(Double, Double)]
> mirror n = map (\(x,y)->(x,-y)) n

> scale::Double->[(Double, Double)]->[(Double, Double)]
> scale r n = map(\(x, y)->(r*x, r*y)) n
> sc = scale (1/3)


> avg::[Double]->Double
> avg n=(sum n)/(fromIntegral . length $ n)


> diff::[Double]->[Double]
> diff n = init.(map (\(cur,nxt)->nxt-cur))$(zip n ((tail n)++[head n]))

> calcAvg::[Double]->Double
> calcAvg = (map (\(i, s)->s/i)).attachId1.(scanl1 (+))
> attachId1 = zip [1..]

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

Now our analysis will plot (x,y,z)=(radius, points, fractalDepth), with x-y plane facing us and z-Axis pointing into the screen.

> encapPoints::Double->[(Double, Double)]->Int
> encapPoints r n=sum $ map fromEnum (map (\(x,y)->(x*x+y*y)<(r*r)) n)
> calculate::Double->[(Double, Double)]->Double
> calculate r n = (encapPoints r n)/r

---


So we know when 
  - r=>Infty, result=>0
  - depth=>Infty, result=>Infty
  - depth::Int, r::Double
  - suppose infinite average converges
  - Then we could integrate it, otherwise we'll have to flip workflow



> res::Double->[Double]
> res r=calcAvg (map ((calculate r).snowflake) [2..4])

> tellIfApproach::[Double]->Double
> tellIfApproach = last.diff



