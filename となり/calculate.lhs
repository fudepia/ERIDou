> main::IO()
> main=
>  print (calculate 0.4 (snowflake 2))

Generic Geometric Functions

> translate::(Double, Double)->[(Double, Double)]->[(Double, Double)]
> translate d n = map(\(x,y) -> (fst d+x, snd d+y)) n
> trs0 n = translate (1/3, 0) n
> trs1 n = translate (1/2, sqrt(3)/6) n
> trs2 n = translate (2/3, 0) n

Rotation base on Origin

> rotate::Double->[(Double, Double)]->[(Double, Double)]
> rotate d n = map(\(x,y) -> (x*cos(d)-y*sin(d), x*sin(d)+y*cos(d))) n
> rcw::[(Double, Double)]->[(Double, Double)]
> rcw n = rotate (-pi/3) n
> rcc::[(Double, Double)]->[(Double, Double)]
> rcc n = rotate (pi/3) n

> mirror::[(Double, Double)]->[(Double, Double)]
> mirror n = map (\(x,y)->(x,-y)) n

> scale::Double->[(Double, Double)]->[(Double, Double)]
> scale r n = map(\(x, y)->(r*x, r*y)) n
> sc::[(Double, Double)]->[(Double, Double)]
> sc n = scale (1/3) n

place::(Double, Double)->(Double, Double)->[(Double, Double)]->[(Double, Double)]

---

First we'll create function that returns coordinate for Koch's Snowflake

> vonKoch::Int->[(Double, Double)]
> vonKoch(0)=[(0,0), (1,0)]
> vonKoch(1)=[(0,0), (1/3, 0), (1/2, sqrt(3)/6), (2/3, 0), (1, 0)]
> vonKoch(n)= concat [sc (vonKoch(n-1)),trs0.sc.rcc$vonKoch(n-1), trs1.sc.rcw$vonKoch(n-1), trs2.sc$vonKoch(n-1)]

> snowflake::Int->[(Double, Double)]
> snowflake n = translate (-1/2, sqrt(3)/6) (concat [vonKoch n, translate (1,0) (rcw.rcw.vonKoch$n), translate (1/2, -sqrt(3)/2) (rcc.rcc.vonKoch$n)])

Where both takes depth as argument and vonKoch returns the single side with endpoint at (0,0) and (1,0), whereas snowflake returns the whole snowflake centered at origin.

---

Now our analysis will plot (x,y,z)=(radius, points, fractalDepth), with x-y plane facing us and z-Axis pointing into the screen.

> calculate::Double->[(Double, Double)]->Int
> calculate r n=sum $ map fromEnum (map (\(x,y)->(x*x+y*y)<(r*r)) n)
