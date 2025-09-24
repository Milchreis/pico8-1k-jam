-- starbyte
-- by milchreis
-- for pico-1k jam in 2025 ♥
-- ---

-- score
points=0
lm={y=-8,dy=0,p=0}

-- ship
x=64
y=118
dx=0
speed=.8
level=1
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
 return (px-cx)^2+(py-cy)^2<=r^2
end

function gg()
 level=0
 explosion(x,y,12,4)
 if level==0 then
  speed=0
  lm.y=y-6
  lm.p=flr(points)
  shake_fps=128
 end
end

function explosion(x,y,c,f)
 for i=1,5*f do
  a=sin(rnd()*6)
  add(particles,{x=x,y=y,dx=a*rnd(2,4),dy=a*rnd(2,4),l=128,c=c})
 end
end

function _update60()
 -- restart game 
 if(btn(5) and speed+shake_fps==0) run()
 
 -- shooting
 shoot_cd=max(0,shoot_cd-1)

 if speed>0 then
  -- update points and landmark
  points=t()*speed
  if points-10>lm.p then
   lm.y=-8
   lm.dy=speed
   lm.p=flr(points)
  else
   lm.y+=lm.dy
  end

  -- spawn enemy
  if rnd()<.01*level then
   add(enemies,{
    x=rnd(128),
    y=-10,
    dx=0,
    dy=1+rnd(.5),
    s=rnd()>.5,
    c=rnd({8,9}),
    l=flr(rnd(level+1))
   })
  end
  
  -- spawn power ups
  if powerup_spw>level*level then
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
  if btn(5) and shoot_cd==0 then
   for i=1,min(level,6) do
    add(bullets,{
      x=x+(i-(level+1)/2)*4,
      y=y-6,
      dx=0,
      dy=-2
    })
    shoot_cd=60/level
   end
  end
 end
   
 -- update bullets
 for b in all(bullets) do
  -- movement
  b.x+=b.dx
  b.y+=b.dy
  if(b.y<0 or b.y>128) del(bullets,b)

  -- collision with ship
  if (point_in_circle(b.x,b.y,x,y,6)) gg() del(bullets,b)
 end
 
 -- update enemies
 for e in all(enemies) do
  -- movement
  e.x+=mid(-.5, (x-e.x)*.02,.5)
  e.y+=e.dy

  -- remove outside
  if(e.y>128) del(enemies,e)
  
  -- is enemy shooting?
  if e.s and abs(e.x-x)<9 then
   add(bullets,{
    x=e.x,
    y=e.y+7,
    dx=0,
    dy=e.dy+1
    })
   e.s=nil
  end

  -- collision with ship
  if point_in_circle(e.x,e.y,x,y,8) then
   del(enemies,e)
   gg()
  end
 
  -- with bullet
  for b in all(bullets) do
   if point_in_circle(b.x,b.y,e.x,e.y,6) then
    del(bullets,b)
    del(enemies,e)
    explosion(e.x,e.y,8,3)
    powerup_spw+=1
    shake_fps=3
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
  p.y+=p.dy+speed/2
  if(p.y>128) del(powerups,p)

  -- collision ship
  if point_in_circle(p.x,p.y,x,y,6) then
   del(powerups,p)
   -- level up
   level+=1
   speed+=level*.04
   explosion(p.x,p.y,3,2)
  end
 end

 -- draw
 ------------------------
 cls()
 
 if(shake_fps>0) camera(rnd(3),rnd(3))
 shake_fps=max(0,shake_fps-1)

 -- points
 print(lm.p,3,lm.y,5)
 line(3,lm.y+7,13,lm.y+7,5)
  
 -- stars 
 for s in all(stars) do
  line(s.x,s.y,s.x,s.y-level/4,5)
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
  circ(x-3,y,1,12)
  circ(x+3,y,1,12)
  
  --  level 3: booster
  if level>1 then
   rect(x-2,y+2,x+2,y+3,8)
  end
  
  --  level 4: large wings
  if level>2 then
   line(x-3,y+2,x-5,y+4,12)
   line(x+3,y+2,x+5,y+4,12)
  end
  
  --  level 5: side booster
  if level>3 then
   rect(x-6,y-1,x-5,y+2,8)
   rect(x+5,y-1,x+6,y+2,8)
  end

  --  level 6
  if level>4 then
    line(x-2,y+5,x-2,y+8,9)
    line(x+2,y+5,x+2,y+8,9)
  end
 
  --  level 7
  if level>5 then
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

  if e.l>1 then
   circ(e.x-3,e.y,1,e.c)
   circ(e.x+3,e.y,1,e.c)
  end

  -- wings
  if e.l>2 then
   line(e.x-3,e.y,e.x-5,e.y-2,e.c)
   line(e.x+3,e.y,e.x+5,e.y-2,e.c)
  end
  
  -- booster
  if(e.l>3) rect(e.x-1,e.y-4,e.x+1,e.y-2,e.c)

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
