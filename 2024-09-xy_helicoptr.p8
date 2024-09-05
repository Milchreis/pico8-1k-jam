-- helicoptr
-- by milchreis
-- for pico-1k jam in 2024 ♥

-- todos
--  - powerups after box saved
--  - gameover after running out of fuel
--  - win screen
--  - bug: multiple boxes carried
--  - compress to 1024 bytes

-- game
over=false
past_time=0

-- heli data
accel=0
a=0
x=110
y=110
dir={0,0} -- direction[x,y]
voff=0
hoff=0
speed=3
fuel=100
box=false

-- rope data
rope_x=x
rope_y=y
rope_speed=.02

-- heliport position
hp_x=110

-- boxes
boxes={}
for i=1,7 do
	add(boxes,{
		rnd(125),
		rnd(90),
		3+rnd(3),
		false})
end

-- box save areas
areas={}
for i=1,7 do
	add(areas,{i*10+i*2,107,false})
end

function _update60()

 -- speed
 if btn(❎) then
 	accel=min(accel+.0005,.1)
  fuel=max(0,fuel-.1)
 else
	 accel=max(0,accel-.0009) 
 end
  
 -- movement
 if accel>.05 then
 	keys(1,➡️,1,⬅️,-1)
	 keys(2,⬆️,-1,⬇️,1)
	end
	
	x+=dir[1]*accel*speed
	dir[1]=to_null(dir[1],.02)
	
	y+=dir[2]*accel*speed
	dir[2]=to_null(dir[2],.02)
	
	-- update tilt and shift offset
	voff=clamp(to_null(voff-dir[2]/10,.04),-1,2)
 hoff=clamp(to_null(hoff-dir[1]/10,.04),-2,2)
	
	-- update rope end-point
 rope_x+=(x-rope_x)*rope_speed
 rope_y+=(y-rope_y)*rope_speed

 -- refuel
 if col(x,y,5,hp_x,hp_x,9) then
 	fuel=min(100,fuel+1)
 else
  -- count time
  past_time+=1/stat(8)
 end
 
 -- draw
	cls(3)

 -- heliport
 circ(hp_x,hp_x+1,9,7)
 circ(hp_x,hp_x+1,11,7)
-- ?"\^w\^th",hp_x-3,hp_x-3,7

 -- place area
	for a in all(areas) do
		ax,ay=rmid(a[1],a[2],8)
		
		fillp(▒)
		rect(a[1],a[2],a[1]+8,a[2]+8,7)
  fillp()
  
  -- is box in area?
 	if box then
 		bx,by=rmid(box[1],box[2],box[3])
 	 if col(bx,by,1,ax,ay,1) then
 			box[4]=false
 			speed=3
 		end
 	end
 end

	-- boxes
	for b in all(boxes) do
		bx,by=rmid(b[1],b[2],b[3])
		rx=flr(rope_x)
		ry=flr(rope_y)
		 
	 if b[4] then
	 	b[1]=rx-b[3]/2
	 	b[2]=ry-b[3]/2
	 else
	 	if col(bx,by,1,rx,ry,1) then
	  	b[4]=true
	  	box=b
		 	speed=2.5
		 end
	 end 
 
	 rectfill(
	 	b[1],b[2],
	 	b[1]+b[3],
	 	b[2]+b[3],4)
--	 rectfill(
--	 	bx,by,
--	 	bx,by,
--	  8)
  
	end

 -- carry rope
 line(x,y,rope_x,rope_y,8)

	-- body
	shorten=4-flr(accel*40)
 ovf(
  x+hoff,
  y+voff,
  3+(flr(accel*50)), -- max=8
  6+(flr(accel*80)), -- max 14
  5)
  
 rectfill(
  x,y,
  x,y+20-voff-shorten,
  5)
 rectfill(x-2,
 	y+17-shorten,
 	x+2,
 	y+17-voff-shorten,5)

 -- cockpit 
	shorten=2-flr(accel*20)
 ovf(
  x-hoff*.01,
  y-2,
  -- width
  6-shorten-abs(hoff)*.5,
  7-shorten,
  1)
 ovf(
  x-hoff*.01,
  y+2,
  -- width
  6-shorten-abs(hoff)*.5,
  7-shorten,
  5)

	-- rotor 1
	shorten=3-flr(accel*30)
	rx1,ry1=rot(x-12+shorten,y,x,y,a)
	rx2,ry2=rot(x+12-shorten,y,x,y,a)
	line(rx1,ry1,rx2,ry2,0)

	-- rotor 2
	rx1,ry1=rot(x,y-12+shorten,x,y,a)
	rx2,ry2=rot(x,y+12-shorten,x,y,a)
	line(rx1,ry1,rx2,ry2,0)

 a+=accel
 
 -- fuel
 rectfill(100,2,100+25*(fuel/100),4,7)
 rect(100,2,125,4,7)
 
 -- time
 ?"⧗"..flr(past_time),1,1,7
  
 -- debug
 -- print(a)
 -- print(accel)
 --	print(hoff,1)

end

function ovf(x,y,w,h,c)
 ovalfill(
 	x-w/2,
  y-h/2,
  x+w/2,
  y+h/2,
  c)
end

function rmid(x,y,w)
	return flr(x+w/2),flr(y+w/2)
end

function to_null(v,step)
 va=v
	if(va<0) va+=step
	if(va>0) va-=step
	if(abs(va)<=step) va=0
	return va
end

function clamp(v,mn,mx)
	return max(mn,min(mx,v))
end

function keys(i,k,o,v,n)
	if(btn(k)) dir[i]=o
	if(btn(v)) dir[i]=n
end

function col(r1x,r1y,r1,r2x,r2y,r2)
 return 
  r1x+r1>=r2x and
  r1x<=r2x+r2 and
  r1y+r1>=r2y and
  r1y<=r2y+r2
end

function rot(x,y,cx,cy,angle)
	x-=cx
	y-=cy
 rotx=(cos(angle)*x-sin(angle)*y)+cx
 roty=(sin(angle)*x+cos(angle)*y)+cy
 return rotx,roty
end
