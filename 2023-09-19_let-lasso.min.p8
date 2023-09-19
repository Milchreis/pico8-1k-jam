r,l,f,u,a,s,w,i,c,h,o,n=62,100,10,0,0,0,0,0,0,{},{},{{5},{10,62,62},{10,62,30,30,100,94,100},{8,62,22,62,55,62,72},{10,30,30,94,94,30,94,94,30},{12,30,90,45,60,75,60,90,90,60,30},{10,5,64,20,64,35,64,50,64,65,64,80,64,95,64,110,64},{9,20,20,40,40,60,60,80,80,100,100}}function x(n,e,t,f,d,o,i,a)return n+t>=d and n<=d+i and e+f>=o and e<=o+a end function d()if btn(❎)then i,c=1,0_init()end end function p(n,e,d,o,t)for o=-1,1,1do for f=-1,1,1do?n,e+o,d+f,t
end end?n,e,d,o
end function _init()if i>#n or i==0then return end local n=n[i]f=10srand(#n)for n=1,n[1]do add(h,{e=10+rnd(110),d=10+rnd(80),f=rnd(2)-1,i=rnd(2)-1,o=false,t=1})end for e=2,#n,2do add(o,{n[e],n[e+1]})end end function _update60()cls(15)if i==0then p("⁶w⁶tlet lasso",10,46,7,8)?"catch 'em all",10,59,8
?"press ❎",10,70+sin(t()*2),8
d()return end local e=n[i]if i>#n then p("⁶w⁶tyou won",10,46,7,8)?"⧗"..c.." s",10,60,0
?"press ❎",10,70+sin(t()*2),8
d()return end a=max(a-1,0)camera(0,0)if s>0then camera(rnd(3),rnd(3))s-=1end for n=2,#e,2do?"✽",e[n],e[n+1],5
end local d,o,n=r+f*cos(u),l+f*sin(u),0if w>0then n=sin(t()*5)+1w-=1end?"웃",r,l-2+n,0
line(r+3,l-1+n,r+3,l-1+n,7)if a==0then u-=.008+f/6000end for n in all(h)do n.e+=n.f*.05*n.t n.d+=n.i*.05*n.t if n.e<1or n.e>122then n.f*=-1end if n.d<2or n.d>124then n.i*=-1end local t=15if n.o then t=7end p("🐱",n.e,n.d-2,8,t)?"웃",n.e,n.d,8
if a==0and not n.o and x(d-4,o-3,8,3,n.e-1,n.d-3,8,8)then n.o=true n.t+=.5?"⁷s9x3c1"
end for d=2,#e,2do if n.o and x(e[d],e[d+1],6,4,n.e-1,n.d-3,8,8)then n.o,a,s=false,30,4?"⁷i7v2c1g0"
end end if n.o then n.e,n.d=d,o if f==10then del(h,n)w+=30?"⁷i7x1v2c1e1g1"
if#h==0then i+=1?"⁷i7c7"
_init()end end end end oval(d-4,o-3,d+4,o,4)line(d,o,r,l,4)if a==0and btn(❎)then f=min(f+1,120)else f=max(f-2,10)end c+=1/stat(8)?"⧗"..flr(c),1,1,7
rectfill(109,2,109+(i-1)*2,4,7)rect(109,2,125,4,7)end