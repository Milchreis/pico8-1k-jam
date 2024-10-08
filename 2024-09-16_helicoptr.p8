-- helicoptr
-- by milchreis
-- for pico-1k jam in 2024 ♥

-- game
past_time=0
over=0

-- heli data
accel=0
a=0
x=110
y=110
dir={0,0} -- direction[x,y]
voff=0
hoff=0
fuel=100
box=0

-- rope data
rope_x=x
rope_y=y

-- heliport position
hp_x=110

-- boxes
boxes={}
catched_boxes=0
for i=1,7 do
 add(boxes,{
  -- x
  rnd(125),
  -- y
  rnd(74)+10,
  -- width
  3+rnd(3)
  -- catched
  })
end

-- box save areas
areas={
 -- x,y
}
for i=1,7 do
 add(areas,{i*10+i*2,107})
end

function _update60()
 -- draw bg
 cls(1)

 -- heliport
 rectfill(0,95,127,127,13)
 circ(hp_x,hp_x+1,9,7)
 circ(hp_x,hp_x+1,11,7)

 -- box save areas
 fillp(▒)
 for a in all(areas) do
  ax,ay=rmid(a[1],a[2],8)
    
  rect(
   a[1],a[2],
   a[1]+8,a[2]+8,
   7)
   
  -- is catched box in area?
  if box!=0 then
   bx,by=rmid(
    box[1],
    box[2],
    box[3])

   if col(bx,by,1,ax,ay,1) then
    box[4]=0
    box=0
   end
  end
 end
 fillp()

 -- boxes
 for b in all(boxes) do
  -- swing box in water area
  wave_off=sin(b[1]+t()/2)*.2

  if(b[2]<95) b[2]+=wave_off
  
  bx,by=rmid(b[1],b[2],b[3])
    
  if b[4]==1 then
   b[1]=rope_x-b[3]/2
   b[2]=rope_y-b[3]/2
  else
   if box==0 and col(bx,by,b[3],rope_x,rope_y,1) then
    b[4]=1
    box=b
   end
  end 
 
  rectfill(
   b[1],b[2],
   b[1]+b[3],
   b[2]+b[3],4)
 end
 
 -- carry rope
 line(x,y,rope_x,rope_y,8)

 -- body
 shorten=4-accel*60
 ovf(
  x+hoff,
  y+voff,
  3+(accel*70),  -- max 10
  6+(accel*100), -- max 16
  9)
  
 rectfill(
  x,y,
  x,y+20-voff-shorten,
  9)
  
 rectfill(x-2,
  y+17-shorten,
  x+2,
  y+17-voff-shorten,9)

 -- cockpit 
 shorten=2-accel*40
 ovf(
  x-hoff*.02,
  y-2,
  -- width
  6-shorten-abs(hoff)/2,
  7-shorten,
  7)
 ovf(
  x-hoff*.02,
  y+2,
  -- width
  6-shorten-abs(hoff)/2,
  7-shorten,
  9)

 -- rotor 1
 shorten=3-accel*50
 rx1,ry1=rot(x-12+shorten,y,x,y,a)
 rx2,ry2=rot(x+12-shorten,y,x,y,a)
 line(rx1,ry1,rx2,ry2,0)

 -- rotor 2
 rx1,ry1=rot(x,y-12+shorten,x,y,a)
 rx2,ry2=rot(x,y+12-shorten,x,y,a)
 line(rx1,ry1,rx2,ry2,0)

 a+=accel
  
 -- fuel
 rectfill(
 	100,2,
 	100+25*(fuel/100),4,
 	7)
 
 -- acceleration
 rectfill(
 	100,5,
 	100+26*(accel*10),5,
 	6)
  
 -- time
 ?"⧗"..flr(past_time),1,1,7
  
 -- debug
 -- print(placed)

 -- gameover
 if over==true then
  x+=(hp_x-x)*.02
  y+=(hp_x-y)*.02
  rope_x=x
  rope_y=y
  if(col(x,y,5,hp_x,hp_x,9)) run()
  return
 end
 
 -- check for gameover
 -- empty fuel tank or landing on water
 over=fuel==0 or (accel==0 and y<95)
  
 -- speed
 if btn(❎) then
  accel=min(accel+.0005,.1)
  fuel=max(0,fuel-accel*2)
 else
  accel=max(0,accel-.0009)
 end
  
 -- movement
 if accel>.02 then
  keys(1,➡️,1,⬅️,-1)
  keys(2,⬆️,-1,⬇️,1)
 end
 
 -- update movement and squishy controls
 -- direction * current acceleration and a speed factor
 x+=dir[1]*accel*4
 dir[1]=to_null(dir[1],.02)
 
 y+=dir[2]*accel*4
 dir[2]=to_null(dir[2],.02)
 
 -- update tilt and shift offset
 voff=clamp(to_null(voff-dir[2]/10,.04),-1,2)
 hoff=clamp(to_null(hoff-dir[1]/10,.04),-2,2)
 
 -- update rope end-point
 rope_x+=(x-rope_x)*.02
 rope_y+=(y-rope_y)*.02

 -- is on heliport?
 if col(x,y,5,hp_x,hp_x,9) then
  -- refuel
  fuel=min(100,fuel+1)
 else
  -- count time
  past_time+=1/stat(8)
 end
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
