-- starbyte
-- by milchreis
-- for pico-1k jam in 2025 ♥
-- ---

points=0
lm={y=-8,dy=0,p=0}

-- ship
x=64
y=110
dx=0
speed=.7
level=2
shoot_cd=0

-- fighting
bullets={}
enemies={}
particles={}

-- effects
stars={}
shake_fps=0

-- buff
powerups={}
powerup_spw=0

-- spawn stars
for i=1,40 do
 add(stars,{
  x=rnd(128),
  y=rnd(128)
 })
end

function point_in_circle(px,py,cx,cy,r)
 return ((px-cx)^2+(py-cy)^2)<=r^2
end

function gg()
 level-=1
 spawn_explosion(x,y,8)
 spawn_explosion(x,y,12)
 shake_fps=5
 if level<1 then
  speed=0
  lm.y=y-6
  lm.p=flr(points)
  shake_fps=128
 end
end

function spawn_explosion(x,y,c)
  for i=1,5 do
    a=sin(rnd(1)*6)
    add(particles,{x=x,y=y,dx=a*rnd(2,4),dy=a*rnd(2,4),l=128,c=c})
  end
end

function _update60()
 -- restart game 
 if(btnp(4)) run() 
 
 -- shooting
 shoot_cd=max(shoot_cd-1,0)

 -- update points and landmark
 points=time()*speed
 if flr(points)-9>lm.p then
  lm.y=-8
  lm.dy=speed
  lm.p=flr(points)
 else
  lm.y+=lm.dy
 end
 
 if(lm.y>130)lm.dy=0
 
 -- spawn enemy
 if rnd(1)<.01*level then
  add(enemies,{
   x=rnd(128),
   y=-10,
   dx=0,
   dy=1+rnd(.5),
   s=rnd(1)>.5,
   c=rnd({8,9}),
   lvl=flr(rnd(level+1))
  })
 end
 
 -- spawn power ups
 if powerup_spw>3*level then
  add(powerups,{
    x=rnd(128),
    y=-10,
    dy=.5
   })
  powerup_spw=0
 end 

 -- ship controls
 if(btn(0))dx-=speed/9
 if(btn(1))dx+=speed/9
 dx*=.95
 x=max(3,min(x+dx,128))

 -- fire
 if btn(5) and shoot_cd==0 and speed>0 then
  add(bullets,{
    x=x,
    y=y-4,
    dx=0,
    dy=-2
  })
  shoot_cd=20/level*2
 end
   
 -- update bullets
 for b in all(bullets) do
  -- movment
  b.x+=b.dx
  b.y+=b.dy
  if(b.y<0 or b.y>128) del(bullets,b)

  -- collision with ship
  if (point_in_circle(x,y,b.x,b.y,3)) gg() del(bullets,b)
 end
 
 -- update enemies
 for e in all(enemies) do
  -- movement
  e.x+=mid(-.5, (x-e.x)*.02,.5)
  e.y+=e.dy

  -- remove outside
  if(e.y>130) del(enemies,e)
  
  -- is enemy shooting?
  if e.s and abs(e.x-x)<3 then
   add(bullets,{
     x=e.x,
     y=e.y+6,
     dx=0,
     dy=e.dy+1
    })
   e.s=nil
  end

  -- collision with ship
  if point_in_circle(x,y,e.x,e.y,8) then
   del(enemies,e)
   gg()
  end
 
  -- with bullet
  for b in all(bullets) do
   if point_in_circle(b.x,b.y,e.x,e.y,5) then
    e.lvl-=1
    del(bullets,b)
    if e.lvl<1 then
     del(enemies,e)
     spawn_explosion(e.x,e.y,8)
     powerup_spw+=1
    end
    break
   end
  end
 end
 
 -- update stars
 for s in all(stars) do
  s.y+=speed
  if (s.y>128) s.y=0
 end

 -- update all particles 
 for p in all(particles) do
  p.x+=p.dx
  p.y+=p.dy
  p.l-=1
  if(p.l<1) del(particles,p)
 end
 
 -- update power ups
 for p in all(powerups) do
  p.y+=p.dy
  if(p.y>128) del(powerups,p)

  -- collision ship
  if point_in_circle(x,y,p.x,p.y,6) then
   del(powerups,p)
   -- level up
   level+=1
   speed+=level*.02
   spawn_explosion(p.x,p.y,3)
  end
 end

 -- draw
 ------------------------
 cls() 

 if(shake_fps>0) camera(rnd(3),rnd(3))
 shake_fps=max(0,shake_fps-1)

 -- points
 print(lm.p,2,lm.y,5)
 line(2,lm.y+7,12,lm.y+7,5)
  
 -- stars 
 for s in all(stars) do
  pset(s.x,s.y,5)
 end
 
 -- power ups
 for p in all(powerups) do
  circ(p.x,p.y,3,3)
  circfill(p.x,p.y,1,3)
 end
 
 -- ship
 if speed>0 then
  -- level 1: base
  circ(x,y,2,12)
 
  --  level 2: small wings
  if level>1 then
   circ(x-3,y,1,12)
   circ(x+3,y,1,12)
  end
  
  --  level 3: booster
  if level>2 then
   rect(x-2,y+2,x+2,y+3,8)
  end
  
  --  level 4: large wings
  if level>3 then
   line(x-3,y+2,x-5,y+4,12)
   line(x+3,y+2,x+5,y+4,12)
  end
  
  --  level 5: side booster
  if level>4 then
   rect(x-6,y-1,x-5,y+2,8)
   rect(x+5,y-1,x+6,y+2,8)
  end

  --  level 6
  if level>5 then
    line(x-2,y+5,x-2,y+8,9)
    line(x+2,y+5,x+2,y+8,9)
  end
 
  --  level 7
  if level>6 then
    line(x-4,y-2,x-6,y-4,9)
    line(x+4,y-2,x+6,y-4,9)
  end
  
  -- fire is ready
  if (shoot_cd==0) circ(x,y-2,1,7)
 end

 -- draw enemy 
 for e in all(enemies) do
  -- base
  circ(e.x,e.y,2,e.c)

  if level>1 then
   circ(e.x-3,e.y,1,e.c)
   circ(e.x+3,e.y,1,e.c)
  end

  -- wings
  if e.lvl>2 then
   line(e.x-3,e.y,e.x-5,e.y-2,e.c)
   line(e.x+3,e.y,e.x+5,e.y-2,e.c)
  end
  
  -- booster
  if(e.lvl>3) rect(e.x-1,e.y-4,e.x+1,e.y-2,e.c)

  -- can shoot?
  if (e.s) circ(e.x,e.y+2,1,7)
 end
 
 -- draw bullets
 for b in all(bullets) do
  circfill(b.x,b.y,1,7)
 end
 
 -- draw particles
 for p in all(particles) do
  pset(p.x,p.y,p.c)
 end
end
