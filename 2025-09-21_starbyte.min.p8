a=0n={e=-8,f=0,t=0}e=64d=110l=0i=.7f=2r=0o={}h={}s={}g={}u=0c={}j=0for n=1,40do add(g,{d=rnd(128),e=rnd(128)})end function b(n,e,d,f,i)return(n-d)^2+(e-f)^2<=i^2end function m()f-=1k(e,d,8)k(e,d,12)u=5if(f<1)i=0n.e=d-6n.t=flr(a)u=128
end function k(n,e,d)for f=1,5do p=sin(rnd(1)*6)add(s,{d=n,e=e,o=p*rnd(2,4),f=p*rnd(2,4),u=128,i=d})end end function _update60()if(btnp(4))run()
r=max(r-1,0)a=time()*i if(flr(a)-9>n.t)n.e=-8n.f=i n.t=flr(a)else n.e+=n.f
if(n.e>130)n.f=0
if i>0do if(rnd(1)<.01*f)add(h,{d=rnd(128),e=-10,o=0,f=1+rnd(.5),r=rnd(1)>.5,i=rnd{8,9},h=flr(rnd(f+1))})
if(j>3*f)add(c,{d=rnd(128),e=-10,f=.5})j=0
if(btn(0))l-=i/9
if(btn(1))l+=i/9
l*=.95e=max(3,min(e+l,128))if(btn(5)and r==0)add(o,{d=e,e=d-4,o=0,f=-2})r=20/f*2
end for n in all(o)do n.d+=n.o n.e+=n.f if(n.e<0or n.e>128)del(o,n)
if(b(e,d,n.d,n.e,3))m()del(o,n)
end for n in all(h)do n.d+=mid(-.5,(e-n.d)*.02,.5)n.e+=n.f if(n.e>130)del(h,n)
if(n.r and abs(n.d-e)<3)add(o,{d=n.d,e=n.e+6,o=0,f=n.f+1})n.r=nil
if(b(e,d,n.d,n.e,8))del(h,n)m()
for e in all(o)do if b(e.d,e.e,n.d,n.e,5)do n.h-=1del(o,e)if(n.h<1)del(h,n)k(n.d,n.e,8)j+=1
break end end end for n in all(g)do n.e+=i if(n.e>128)n.e=0
end for n in all(s)do n.d+=n.o n.e+=n.f n.u-=1if(n.u<1)del(s,n)
end for n in all(c)do n.e+=n.f if(n.e>128)del(c,n)
if(b(e,d,n.d,n.e,6))del(c,n)f+=1i+=f*.02k(n.d,n.e,3)
end cls()if(u>0)camera(rnd(3),rnd(3))
u=max(0,u-1)?n.t,2,n.e,5
line(2,n.e+7,12,n.e+7,5)for n in all(g)do pset(n.d,n.e,5)end for n in all(c)do circ(n.d,n.e,3,3)circfill(n.d,n.e,1,3)end if i>0do circ(e,d,2,12)if(f>1)circ(e-3,d,1,12)circ(e+3,d,1,12)
if(f>2)rect(e-2,d+2,e+2,d+3,8)
if(f>3)line(e-3,d+2,e-5,d+4,12)line(e+3,d+2,e+5,d+4,12)
if(f>4)rect(e-6,d-1,e-5,d+2,8)rect(e+5,d-1,e+6,d+2,8)
if(f>5)line(e-2,d+5,e-2,d+8,9)line(e+2,d+5,e+2,d+8,9)
if(f>6)line(e-4,d-2,e-6,d-4,9)line(e+4,d-2,e+6,d-4,9)
if(r==0)circ(e,d-2,1,7)
end for n in all(h)do circ(n.d,n.e,2,n.i)if(f>1)circ(n.d-3,n.e,1,n.i)circ(n.d+3,n.e,1,n.i)
if(n.h>2)line(n.d-3,n.e,n.d-5,n.e-2,n.i)line(n.d+3,n.e,n.d+5,n.e-2,n.i)
if(n.h>3)rect(n.d-1,n.e-4,n.d+1,n.e-2,n.i)
if(n.r)circ(n.d,n.e+2,1,7)
end for n in all(o)do circfill(n.d,n.e,1,7)end for n in all(s)do pset(n.d,n.e,n.i)end end
