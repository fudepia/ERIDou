h, t=var("h t")
hh=h/2
theta, phi=var("theta phi")
assume(h, "constant")
assume(h>0)
assume(0<theta, theta<pi/2)
assume(0<phi, phi<pi/2)

# ∆=(tan(theta)+tan(phi))*hh

# x(t)=(t-1)^2*tan(theta)*hh*-1+t^2*tan(phi)*hh
y=(t-1)^2*hh-t^2*hh

# y=1/2*h*((h*tan(theta) - sqrt(h^2*tan(theta)*tan(phi) - 2*(h*tan(theta) - h*tan(phi))*x))/(h*tan(theta) - h*tan(phi)) - 1)^2 - 1/2*(h*tan(theta) - sqrt(h^2*tan(theta)*tan(phi) - 2*(h*tan(theta) - h*tan(phi))*x))^2*h/(h*tan(theta) - h*tan(phi))^2

# dy/dx=h*((h*tan(theta) - sqrt(h^2*tan(theta)*tan(phi) - 2*(h*tan(theta) - h*tan(phi))*x))/(h*tan(theta) - h*tan(phir)) - 1)/sqrt(h^2*tan(theta)*tan(phi) - 2*(h*tan(theta) - h*tan(phi))*x) - (h*tan(theta) - sqrt(h^2*tan(theta)*tan(phi) - 2*(h*tan(theta) - h*tan(phi))*x))*h/(sqrt(h^2*tan(theta)*tan(phi) - 2*(h*tan(theta) - h*tan(phi))*x)*(h*tan(theta) - h*tan(phi)))

# t=(h*tan(theta) - sqrt(h^2*tan(theta)*tan(phi) - 2*(h*tan(theta) - h*tan(phi))*x))/(h*tan(theta) - h*tan(phi))=1/2*(h - 2*y)/h

x=var("x")
# y=var("y")
assume(tan(theta)*hh*-1<=x, x<=tan(phi)*hh)
assume(0<=t, t<=1)

for res in solve((t-1)^2*tan(theta)*hh*-1+t^2*tan(phi)*hh==x, t):
    print(res.rhs()(x=tan(theta)*hh*-1)(h=2, theta=0.2, phi=0.4))
    print(res.rhs()(x=tan(phi)*hh)(h=2, theta=0.2, phi=0.4))
    print(res)
    print()
result=[]    
[((abs(res.rhs()(x=tan(theta)*hh*-1)(h=2, theta=0.2, phi=0.4))<1e-12 and abs(res.rhs()(x=tan(phi)*hh)(h=2, theta=0.2, phi=0.4)-1)<1e-12) and result.append(res)) for res in solve((t-1)^2*tan(theta)*hh*-1+t^2*tan(phi)*hh==x, t)]
tx=result[0].rhs() if len(result)==1 else None
show(result[0])

# solve((t-1)^2*hh-t^2*hh==y, t)
# print((t-1)^2*tan(theta)*hh+t^2*tan(phi)*hh)

#　parametric_plot(((t-1)^2*tan(theta)*hh*-1+t^2*tan(phi)*hh,(t-1)^2*hh-t^2*hh),(t,0,1))


print("Left bound=", (-tan(theta)*hh)(h=2, theta=0.2, phi=0.4))
print("Right bound=", (tan(phi)*hh)(h=2, theta=0.2, phi=0.4))

conf={
    "tin": 0.4,
    "tout": 0.2,
    "h": 2,
    "lb": 0,
    "rb": 0
}
conf["lb"]=(-tan(theta)*hh)(h=conf["h"], theta=conf["tin"], phi=conf["tout"])
conf["rb"]=(tan(phi)*hh)(h=conf["h"], theta=conf["tin"], phi=conf["tout"])
show(y(t=tx)(h=conf["h"], theta=conf["tin"], phi=conf["tout"]))
plot(y(t=tx)(h=conf["h"], theta=conf["tin"], phi=conf["tout"]), (x, conf["lb"], conf["rb"]))+plot(tan(pi/2+conf["tin"])*x, (x, conf["lb"], 0), alpha=0.4, color="red")+plot(tan(pi/2+conf["tout"])*x, (x, 0, conf["rb"]), alpha=0.4, color="violet")
