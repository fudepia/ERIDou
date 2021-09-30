h, t=var("h t")
hh=h/2
theta, thetaprime=var("theta thetaprime")
assume(h, "constant")
assume(h>0)
assume(0<theta, theta<pi/2)
assume(0<thetaprime, thetaprime<pi/2)

# ∆=(tan(theta)+tan(thetaprime))*hh

# x(t)=(t-1)^2*tan(theta)*hh*-1+t^2*tan(thetaprime)*hh
y=(t-1)^2*hh-t^2*hh

# y=1/2*h*((h*tan(theta) - sqrt(h^2*tan(theta)*tan(thetaprime) - 2*(h*tan(theta) - h*tan(thetaprime))*x))/(h*tan(theta) - h*tan(thetaprime)) - 1)^2 - 1/2*(h*tan(theta) - sqrt(h^2*tan(theta)*tan(thetaprime) - 2*(h*tan(theta) - h*tan(thetaprime))*x))^2*h/(h*tan(theta) - h*tan(thetaprime))^2

# dy/dx=h*((h*tan(theta) - sqrt(h^2*tan(theta)*tan(thetaprime) - 2*(h*tan(theta) - h*tan(thetaprime))*x))/(h*tan(theta) - h*tan(thetaprimer)) - 1)/sqrt(h^2*tan(theta)*tan(thetaprime) - 2*(h*tan(theta) - h*tan(thetaprime))*x) - (h*tan(theta) - sqrt(h^2*tan(theta)*tan(thetaprime) - 2*(h*tan(theta) - h*tan(thetaprime))*x))*h/(sqrt(h^2*tan(theta)*tan(thetaprime) - 2*(h*tan(theta) - h*tan(thetaprime))*x)*(h*tan(theta) - h*tan(thetaprime)))

# t=(h*tan(theta) - sqrt(h^2*tan(theta)*tan(thetaprime) - 2*(h*tan(theta) - h*tan(thetaprime))*x))/(h*tan(theta) - h*tan(thetaprime))=1/2*(h - 2*y)/h

x=var("x")
# y=var("y")
assume(tan(theta)*hh*-1<=x, x<=tan(thetaprime)*hh)
assume(0<=t, t<=1)
tx=solve((t-1)^2*tan(theta)*hh*-1+t^2*tan(thetaprime)*hh==x, t)[0].rhs()
"""
for res in solve((t-1)^2*tan(theta)*hh*-1+t^2*tan(thetaprime)*hh==x, t):
    print(res.rhs()(x=tan(theta)*hh*-1)(h=2, theta=0.2, thetaprime=0.4))
    print(res.rhs()(x=tan(thetaprime)*hh)(h=2, theta=0.2, thetaprime=0.4))
    print(res)
    print()
"""
# solve((t-1)^2*hh-t^2*hh==y, t)
# print((t-1)^2*tan(theta)*hh+t^2*tan(thetaprime)*hh)

#　parametric_plot(((t-1)^2*tan(theta)*hh*-1+t^2*tan(thetaprime)*hh,(t-1)^2*hh-t^2*hh),(t,0,1))


print("Left bound=", (-tan(theta)*hh)(h=2, theta=0.2, thetaprime=0.4))
print("Right bound=", (tan(thetaprime)*hh)(h=2, theta=0.2, thetaprime=0.4))

conf={
    "tin": 0.4,
    "tout": 0.2,
    "h": 2,
    "lb": 0,
    "rb": 0
}
conf["lb"]=(-tan(theta)*hh)(h=conf["h"], theta=conf["tin"], thetaprime=conf["tout"])
conf["rb"]=(tan(thetaprime)*hh)(h=conf["h"], theta=conf["tin"], thetaprime=conf["tout"])
show(y(t=tx)(h=conf["h"], theta=conf["tin"], thetaprime=conf["tout"]))
plot(y(t=tx)(h=conf["h"], theta=conf["tin"], thetaprime=conf["tout"]), (x, conf["lb"], conf["rb"]))+plot(tan(pi/2+conf["tin"])*x, (x, conf["lb"], 0), alpha=0.4, color="red")+plot(tan(pi/2+conf["tout"])*x, (x, 0, conf["rb"]), alpha=0.4, color="violet")
