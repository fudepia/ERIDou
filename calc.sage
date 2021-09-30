h, t=var("h t")
hh=h/2
th, tp=var("theta thetaprime")
assume(h, "constant")
assume(h>0)
assume(0<th, th<pi/2)
assume(0<tp, tp<pi/2)

# ∆=(tan(th)+tan(tp))*hh

# x(t)=(t-1)^2*tan(th)*hh*-1+t^2*tan(tp)*hh
# y(t)=(t-1)^2*hh-t^2*hh

y=1/2*h*((h*tan(th) - sqrt(h^2*tan(th)*tan(tp) - 2*(h*tan(th) - h*tan(tp))*x))/(h*tan(th) - h*tan(tp)) - 1)^2 - 1/2*(h*tan(th) - sqrt(h^2*tan(th)*tan(tp) - 2*(h*tan(th) - h*tan(tp))*x))^2*h/(h*tan(th) - h*tan(tp))^2

# dy/dx=h*((h*tan(th) - sqrt(h^2*tan(th)*tan(tp) - 2*(h*tan(th) - h*tan(tp))*x))/(h*tan(th) - h*tan(tpr)) - 1)/sqrt(h^2*tan(th)*tan(tp) - 2*(h*tan(th) - h*tan(tp))*x) - (h*tan(th) - sqrt(h^2*tan(th)*tan(tp) - 2*(h*tan(th) - h*tan(tp))*x))*h/(sqrt(h^2*tan(th)*tan(tp) - 2*(h*tan(th) - h*tan(tp))*x)*(h*tan(th) - h*tan(tp)))

# t=(h*tan(th) - sqrt(h^2*tan(th)*tan(tp) - 2*(h*tan(th) - h*tan(tp))*x))/(h*tan(th) - h*tan(tp))=1/2*(h - 2*y)/h
"""
x, y=var("x y")
assume(tan(th)*hh*-1<=x, x<=tan(tp)*hh)
assume(0<=t, t<=1)
for res in solve((t-1)^2*tan(th)*hh*-1+t^2*tan(tp)*hh==x, t):
    print(res.rhs()(x=tan(th)*hh*-1)(h=2, theta=0.2, thetaprime=0.4))
    print(res.rhs()(x=tan(tp)*hh)(h=2, theta=0.2, thetaprime=0.4))
    print(res)
    print()
"""
# solve((t-1)^2*hh-t^2*hh==y, t)
# print((t-1)^2*tan(th)*hh+t^2*tan(tp)*hh)

#　parametric_plot(((t-1)^2*tan(th)*hh*-1+t^2*tan(tp)*hh,(t-1)^2*hh-t^2*hh),(t,0,1))


print("Left bound=", (-tan(th)*hh)(h=2, theta=0.2, thetaprime=0.4))
print("Right bound=", (tan(tp)*hh)(h=2, theta=0.2, thetaprime=0.4))

conf={
    "tin": 0.4,
    "tout": 0.2,
    "h": 2,
    "lb": 0,
    "rb": 0
}
conf["lb"]=(-tan(th)*hh)(h=conf["h"], theta=conf["tin"], thetaprime=conf["tout"])
conf["rb"]=(tan(tp)*hh)(h=conf["h"], theta=conf["tin"], thetaprime=conf["tout"])

plot(y(h=conf["h"], theta=conf["tin"], thetaprime=conf["tout"]), (x, conf["lb"], conf["rb"]))+plot(tan(pi/2+conf["tin"])*x, (x, conf["lb"], 0), alpha=0.4, color="red")+plot(tan(pi/2+conf["tout"])*x, (x, 0, conf["rb"]), alpha=0.4, color="violet")
