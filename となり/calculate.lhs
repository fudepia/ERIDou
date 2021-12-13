> module Calculate (res) where

---

Now our analysis will plot (x,y,z)=(radius, points, fractalDepth), with x-y plane facing us and z-Axis pointing into the screen.

> encapPoints::Double->[(Double, Double)]->Int
> encapPoints r n=sum $ map fromEnum (map (\(x,y)->(x*x+y*y)<(r*r)) n)
> calculate::Double->[(Double, Double)]->Double
> calculate r n = fromIntegral(encapPoints r n)/r

---

So we know when 
  - r=>Infty, result=>0
  - depth=>Infty, result=>Infty
  - depth::Int, r::Double
  - suppose infinite average converges
  - Then we could integrate it, otherwise we'll have to flip workflow



> res::(Int->[(Double, Double)])->Double->[Double]
> res f r=calcAvg (map ((calculate r).f) [2..4])

> tellIfApproach::[Double]->Double
> tellIfApproach = last.diff

---

Analytic Functions

> avg::[Double]->Double
> avg n=(sum n)/(fromIntegral . length $ n)


> diff::[Double]->[Double]
> diff n = init.(map (\(cur,nxt)->nxt-cur))$(zip n ((tail n)++[head n]))

> calcAvg::[Double]->[Double]
> calcAvg = (map (\(i, s)->s/i)).attachId1.(scanl1 (+))
> attachId1 = zip [1..]
