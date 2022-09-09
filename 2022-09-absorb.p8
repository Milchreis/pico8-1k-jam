-- pico-8 1k 2022
-- milchreis

c=circ
cf=circfill
fp=fillp
b=btn
r=rnd
w=800
h=800

p={
	x=64,
	y=64,
	r=3,
	p=▒,
	s=.015,
	v={0,0},
	d={0,0}
}

e={}
s={}
pat={▒,█,░,▤,▥}

-- spawn stars
for i=1,1000do
	add(s, {x=r(w),y=r(h)})
end

function dst(n,m)
	dx=n.x-m.x
	dy=n.y-m.y
	if abs(dy)>=99or abs(dx)>=99 then return 32767
 else return sqrt(sqr(dx)+sqr(dy))
 end
end

function sqr(x) return x*x end

function col(n,m)
	return dst(n,m)<=(n.r)+(m.r)
end

pd={-1,-.7,-.3,-.5,0,.3,.5,.7,1}
function spawn()
	add(e,{
		x=r(w),
		y=r(h),
		d={r(pd),r(pd)},
		v={0,0},
		s=.003+(t()*.00001),
		c=r({6,14}),
		r=min(p.r-3+r(p.r+3),10),
		p=pat[r({1,2,3,4,5})]
	})
end

for i=1,99 do
	spawn()
end

function keys(i,k,o,v,n)
	p.d[i]=0
	if(b(k))p.d[i]=o
	if(b(v))p.d[i]=n
end

function move(i)
	i.v[1]=(i.v[1]+i.d[1]*i.s)*.98
	i.v[2]=(i.v[2]+i.d[2]*i.s)*.98

	i.x+=i.v[1]
	i.y+=i.v[2]
end

function _update60()	
	keys(1,➡️,1,⬅️,-1)
	keys(2,⬆️,-1,⬇️,1)
		
	move(p)
	
 cam_x=p.x-60
 cam_y=p.y-60
 cam_x=mid(0,cam_x,w-128)
 cam_y=mid(0,cam_y,h-128)
	camera(cam_x,cam_y)
	
	foreach(e,move)
	
	-- init
	if(t()%1==0.0) spawn()
	
	cl={}
	inc=.3
	for t in all(e) do
		if t.c!=6then
			d=dst(t,p)
			t.d={(p.x-t.x)/d,(p.y-t.y)/d}
		end
	
		if(t.r<=0or t.x+t.r*2<0or t.x-t.r*2>w or t.y-t.r*2>w) del(e,t)
		if t.r>0and col(t,p)then
			if p.r>t.r and t.c==6then
				p.r+=inc
				t.r=max(0,t.r-inc)
				?"\ai7v2ceg"				
			elseif p.r>0.6then
				p.r=max(.6,p.r-inc)
				t.r=min(35,t.r+inc)
				?"\ai7v2c1g0"
			end
		end
	end

	-- draw
	cls()
	o=sin(t()*1.1)+1

	-- starfield
	for t in all(s)do
		c(t.x,t.y,0,1)
	end
		
	-- enemys
	for t in all(e)do
		fp(t.p)
		cf(t.x,t.y,t.r+o-2,t.c)
		fp()
		c(t.x,t.y,t.r+o,t.c)
	end

	-- player
	if p.d[1]!=0or p.d[2]!=0then
		fp(░)
		cf(p.x-p.r*p.d[1],p.y-p.r*p.d[2],p.r/2,1)
	end
	cf(p.x,p.y,p.r+o-2,0)
	fp(p.p)
	cf(p.x,p.y,p.r+o-2,1)
	fp()
	c(p.x,p.y,p.r+o,12)
end
