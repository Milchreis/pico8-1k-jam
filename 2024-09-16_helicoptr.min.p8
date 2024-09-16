𝘢,𝘤,d,l,e,n,r,s,u,c,o=0,0,0,0,110,110,{0,0},0,0,100,0h,a,i,𝘥,𝘭=e,n,110,{},0for n=1,7do add(𝘥,{rnd(125),rnd(74)+10,3+rnd(3)})end 𝘣={}for n=1,7do add(𝘣,{n*10+n*2,107})end function _update60()cls(1)rectfill(0,95,127,127,13)circ(i,i+1,9,7)circ(i,i+1,11,7)fillp(▒)for n in all(𝘣)do 𝘨,𝘩=m(n[1],n[2],8)rect(n[1],n[2],n[1]+8,n[2]+8,7)if o~=0then p,q=m(o[1],o[2],o[3])if(g(p,q,1,𝘨,𝘩,1))o[4],o=0,0
end end fillp()for n in all(𝘥)do 𝘪=sin(n[1]+t()/2)*.2if(n[2]<95)n[2]+=𝘪
p,q=m(n[1],n[2],n[3])if n[4]==1then n[1]=h-n[3]/2n[2]=a-n[3]/2else if(o==0and g(p,q,n[3],h,a,1))n[4],o=1,n
end rectfill(n[1],n[2],n[1]+n[3],n[2]+n[3],4)end line(e,n,h,a,8)f=4-d*60v(e+u,n+s,3+d*70,6+d*100,9)rectfill(e,n,e,n+20-s-f,9)rectfill(e-2,n+17-f,e+2,n+17-s-f,9)f=2-d*40v(e-u*.02,n-2,6-f-abs(u)/2,7-f,7)v(e-u*.02,n+2,6-f-abs(u)/2,7-f,9)f=3-d*50w,x=j(e-12+f,n,e,n,l)y,z=j(e+12-f,n,e,n,l)line(w,x,y,z,0)w,x=j(e,n-12+f,e,n,l)y,z=j(e,n+12-f,e,n,l)line(w,x,y,z,0)l+=d rectfill(100,2,100+25*(c/100),4,7)rectfill(100,5,100+26*(d*10),5,6)?"⧗"..flr(𝘢),1,1,7
if 𝘤==true then e+=(i-e)*.02n+=(i-n)*.02h,a=e,n if(g(e,n,5,i,i,9))run()
return end 𝘤=c==0or d==0and n<95if(btn(❎))d=min(d+.0005,.1)c=max(0,c-d*2)else d=max(0,d-.0009)
if(d>.02)𝘦(1,➡️,1,⬅️,-1)𝘦(2,⬆️,-1,⬇️,1)
e+=r[1]*d*4r[1]=k(r[1],.02)n+=r[2]*d*4r[2]=k(r[2],.02)s=𝘧(k(s-r[2]/10,.04),-1,2)u=𝘧(k(u-r[1]/10,.04),-2,2)h+=(e-h)*.02a+=(n-a)*.02if(g(e,n,5,i,i,9))c=min(100,c+1)else 𝘢+=1/stat(8)
end function v(n,e,d,f,i)ovalfill(n-d/2,e-f/2,n+d/2,e+f/2,i)end function m(e,d,n)return flr(e+n/2),flr(d+n/2)end function k(e,n)b=e if(b<0)b+=n
if(b>0)b-=n
return b end function 𝘧(n,e,d)return max(e,min(d,n))end function 𝘦(n,e,d,f,i)if(btn(e))r[n]=d
if(btn(f))r[n]=i
end function g(n,e,d,f,i,t)return n+d>=f and n<=f+t and e+d>=i and e<=i+t end function j(e,d,f,i,n)e-=f d-=i 𝘫,𝘬=cos(n)*e-sin(n)*d+f,sin(n)*e+cos(n)*d+i return 𝘫,𝘬 end
