module Geometric where

-- Generic Geometric Functions

translate::(Double, Double)->[(Double, Double)]->[(Double, Double)]
translate d n = map(\(x,y) -> (fst d+x, snd d+y)) n
trs0 = translate (1/3, 0)
trs1 = translate (1/2, sqrt(3)/6)
trs2 = translate (2/3, 0)

-- Rotation base on Origin

rotate::Double->[(Double, Double)]->[(Double, Double)]
rotate d n = map(\(x,y) -> (x*cos(d)-y*sin(d), x*sin(d)+y*cos(d))) n
rcw = rotate (-pi/3)
rcc = rotate (pi/3)

mirror::[(Double, Double)]->[(Double, Double)]
mirror n = map (\(x,y)->(x,-y)) n

scale::Double->[(Double, Double)]->[(Double, Double)]
scale r n = map(\(x, y)->(r*x, r*y)) n
sc = scale (1/3)
