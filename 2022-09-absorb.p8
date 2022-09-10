-- pico-8 1k 2022
-- milchreis
w=800
h=800
p={}
e={}
s={}
pat={▒,█,░,▤,▥}
f=0

function _init()
	p={
		x=64,
		y=64,
		r=3,
		c=12,
		p=▒,
		s=.015,
		sk=.001,
		v={0,0},
		d={0,0},
		a=0,
		t={}
	}
	
	e={}
	s={}

	-- spawn stars
	for i=0,999do
		add(s,{x=rnd(w),y=rnd(h)})
	end
	
	for i=1,199do
		spawn()
	end
end

function dst(n,m)
	dx=n.x-m.x
	dy=n.y-m.y
	if(abs(dy)>=99or abs(dx)>=99) return 32767
	return sqrt(dx*dx+dy*dy)
end

function col(n,m)
	return dst(n,m)<=(n.r)+(m.r)
end

function spawn()
	add(e,{
		x=rnd(w),
		y=rnd(h),
		d={rnd({-1,1})*rnd(1),rnd({-1,1})*rnd(1)},
		v={0,0},
		s=.001*rnd(10),
		sk=.004,
		c=rnd({6,14}),
		r=min(p.r-3+rnd(p.r+3),10),
		p=pat[rnd(5)\1],
		t={}
	})
end

function keys(i,k,o,v,n)
	p.d[i]=0
	if(btn(k))p.d[i]=o
	if(btn(v))p.d[i]=n
end

function move(i)
	if(dst(i,p)<200and#i.t<50and f%8==0)add(i.t,{x=i.x,y=i.y,r=i.r})
	
	i.v[1]=(i.v[1]+i.d[1]*i.s)*.98
	i.v[2]=(i.v[2]+i.d[2]*i.s)*.98

	i.x+=i.v[1]
	i.y+=i.v[2]
	
	i.r-=(abs(i.v[1])+abs(i.v[2]))*i.sk
end

function trace(o,c,s)
	for l in all(o.t)do
		l.r*=s
		fillp(░)
		circfill(l.x,l.y,l.r,c)
		if(l.r<=1)del(o.t,l)
	end
end

function dot(t,o,a)
		circfill(t.x,t.y,t.r,0)
		fillp(t.p)
		circfill(t.x,t.y,t.r+o-2,a)
		fillp()
		circ(t.x,t.y,t.r+o,t.c)
end

function _update60()
	f+=1	
	keys(1,➡️,1,⬅️,-1)
	keys(2,⬆️,-1,⬇️,1)
		
	if(p.r>0.6)move(p)
	
	cmx=mid(p.x-64,w-128)
	cmy=mid(p.y-64,h-128)
	camera(cmx,cmy)
	
	foreach(e,move)
	
	-- init
	p.p=▒
	for t in all(e)do
		if t.c!=6then
			d=dst(t,p)
			t.d={(p.x-t.x)/d,(p.y-t.y)/d}
		end
		if(t.r<=0.3or t.x+t.r*2<0or t.x-t.r*2>w or t.y-t.r*2>h) del(e,t) spawn()
		if t.r>0and col(t,p)then
			if p.r>=t.r and t.c==6then
				p.p=♥
				p.r+=.3
				t.r=max(0,t.r-.3)
				?"\ai7x1v2c1e1g1"
			elseif p.r>0.6then
				p.p=ˇ
				p.r=max(.6,p.r-.3)
				t.r=min(35,t.r+.3)
				camera(cmx+rnd(3),cmy+rnd(3))
				?"\ai7v2c1g0"
			end
		end
	end

	-- draw
	cls()
	o=sin(t()*1.1)+1

	-- starfield
	foreach(s,function(t)circ(t.x,t.y,0,1)end)
	trace(p,1,.995)

	-- enemys
	for t in all(e)do
		trace(t,1,.99)
		if(t.c==6)dot(t,o,6)
		if(t.c!=6)dot(t,o,2)
	end

	-- player
	if p.r>0.6then
		p.a=t()\1
		dot(p,o,1)		
	else
		?"age "..p.a.." ❎",p.x-27,p.y+10,6
		if(btn(❎))_init()
	end
end
