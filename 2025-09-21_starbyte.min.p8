a=0n={e=-8,f=0,t=0}e=64d=118l=0i=.8f=1u=0o={}h={}s={}g={}r=0c={}j=0for n=1,40do add(g,{d=rnd(128),e=rnd(128)})end function b(n,e,d,f,i)return(n-d)^2+(e-f)^2<=i^2end function m()f=0k(e,d,12,4)if(f==0)i=0n.e=d-6n.t=flr(a)r=128
end function k(n,e,d,f)for f=1,5*f do p=sin(rnd(1)*6)add(s,{d=n,e=e,o=p*rnd(2,4),f=p*rnd(2,4),u=128,i=d})end end function _update60()if(btn(5)and i==0and r==0)run()
u=max(u-1,0)if i>0do a=t()*i if(a-10>n.t)n.e=-8n.f=i n.t=flr(a)else n.e+=n.f
if(rnd(1)<.01*f)add(h,{d=rnd(128),e=-10,o=0,f=1+rnd(.5),h=rnd(1)>.5,i=rnd{8,9},r=flr(rnd(f+1))})
if(j>f*f)add(c,{d=rnd(128),e=-10,f=.5})j=0
if(btn(0))l-=i/9
if(btn(1))l+=i/9
l*=.95e=max(3,min(e+l,128))if(btn(5)and u==0)for n=1,min(f,6)do add(o,{d=e+(n-(f+1)/2)*4,e=d-6,o=0,f=-2})u=60/f end
end for n in all(o)do n.d+=n.o n.e+=n.f if(n.e<0or n.e>128)del(o,n)
if(b(n.d,n.e,e,d,6))m()del(o,n)
end for n in all(h)do n.d+=mid(-.5,(e-n.d)*.02,.5)n.e+=n.f if(n.e>128)del(h,n)
if(n.h and abs(n.d-e)<9)add(o,{d=n.d,e=n.e+7,o=0,f=n.f+1})n.h=nil
if(b(n.d,n.e,e,d,8))del(h,n)m()
for e in all(o)do if(b(e.d,e.e,n.d,n.e,6))del(o,e)del(h,n)k(n.d,n.e,8,3)j+=1r=3
end end for n in all(g)do n.e+=i if(n.e>128)n.e=0
end for n in all(s)do n.d+=n.o n.e+=n.f n.u-=1if(n.u<1)del(s,n)
end for n in all(c)do n.e+=n.f+i/2if(n.e>128)del(c,n)
if(b(n.d,n.e,e,d,6))del(c,n)f+=1i+=f*.04k(n.d,n.e,3,2)
end cls()if(r>0)camera(rnd(3),rnd(3))
r=max(0,r-1)?n.t,3,n.e,5
line(3,n.e+7,13,n.e+7,5)for n in all(g)do line(n.d,n.e,n.d,n.e-f/4,5)end for n in all(c)do circ(n.d,n.e,3,3)circfill(n.d,n.e,1,3)end if i>0do circ(e,d,2,12)circ(e-3,d,1,12)circ(e+3,d,1,12)if(f>1)rect(e-2,d+2,e+2,d+3,8)
if(f>2)line(e-3,d+2,e-5,d+4,12)line(e+3,d+2,e+5,d+4,12)
if(f>3)rect(e-6,d-1,e-5,d+2,8)rect(e+5,d-1,e+6,d+2,8)
if(f>4)line(e-2,d+5,e-2,d+8,9)line(e+2,d+5,e+2,d+8,9)
if(f>5)line(e-4,d-2,e-6,d-4,9)line(e+4,d-2,e+6,d-4,9)
if(u==0)circ(e,d-2,1,7)
end for n in all(h)do circ(n.d,n.e,2,n.i)if(n.r>1)circ(n.d-3,n.e,1,n.i)circ(n.d+3,n.e,1,n.i)
if(n.r>2)line(n.d-3,n.e,n.d-5,n.e-2,n.i)line(n.d+3,n.e,n.d+5,n.e-2,n.i)
if(n.r>3)rect(n.d-1,n.e-4,n.d+1,n.e-2,n.i)
if(n.h)circ(n.d,n.e+2,1,7)
end for n in all(o)do circfill(n.d,n.e,1,7)end for n in all(s)do pset(n.d,n.e,n.i)end end
