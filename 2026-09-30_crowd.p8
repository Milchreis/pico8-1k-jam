-- crowd by milchreis - pico-1k jam 2026
-- player controls a crowd of soldiers at the bottom of the screen.
-- enemies spawn from the top and move downward. survive as long as possible.
-- power-ups fall from the right; shooting them down recruits new soldiers.

-- cx,cy: crowd center position
-- tmr: frame counter
-- wv: wave number
-- wt: wave timer
-- shk: screen shake frames remaining
cx, cy, tmr, wv, wt, shk = 64, 110, 0, 0, 0, 0

-- unts: player soldiers
-- blts: bullets
-- enms: small enemies
-- pwrs: power-ups
-- prts: particles
unts, blts, enms, pwrs, prts = {}, {}, {}, {}, {}

-- spawn n particles at (x,y) with color c, random spread
function burst(x, y, c, n)
 for i = 1, n do
  add(prts, { x = x + rnd(6) - 3, y = y + rnd(6) - 3, l = 10 + rnd(15), c = c })
 end
end

function col(b, p, r)
 return abs(b.x - p.x) < r and abs(b.y - p.y) < r
end

function sp_e(h, s)
 add(enms, { 
  x = 15 + rnd(30), 
  y = -10, w = rnd(10), 
  f = 0, 
  sp = (.2/h+wv*.005), 
  s = s,
  hp = h
 })
end

-- add n soldiers to the crowd; bot=1 spawns them below screen (power-up recruit)
function add_unts(n, bot)
 r = sqrt(#unts + n) * 2.5
 for i = 1, n do
  -- ox,oy: offset from crowd center
  -- sc: shoot cooldown
  -- jn: 1 while unit is still running into formation
  u = {
   x = cx + rnd(20) - 10,
   y = cy + rnd(20) - 10,
   vx = 0, 
   vy = 0, 
   ox = rnd(r * 2) - r, 
   oy = rnd(r * 1.5) - r * .75, 
   sc = rnd(40) + 10, 
   jn = bot
  }
  if (bot>0) u.y = 135
  add(unts, u)
 end
end

-- initially spawn 4 soldiers
add_unts(4,1)

function _update60()
 -- game over when all soldiers are dead
 if #unts < 1 and not go then go, shk = true, 8 end
 if not go then
  tmr += 1

  -- 1. player input: move crowd left/right
  if (btn(0)) cx -= 1
  if (btn(1)) cx += 1
  cx = mid(10, cx, 118)

  -- 2. crowd movement: each unit steers toward its offset from crowd center
  for u in all(unts) do
   tx, ty = cx + u.ox, cy + u.oy
   -- spring toward target with damping
   u.vx = (u.vx + (tx - u.x) * .03) * .87
   u.vy = (u.vy + (ty - u.y) * .03) * .87
   u.x += u.vx u.y += u.vy
   if u.jn then
    -- recruit: clamp to screen until reached formation spot
    u.x, u.y = mid(1, u.x, 124), mid(1, u.y, 124)
    if (abs(u.x - tx) < 3 and abs(u.y - ty) < 3) u.jn = nil
   end
   -- 3. shooting: each unit fires on its own cooldown
   u.sc -= 1
   if u.sc < 1 then
    add(blts, { x = u.x, y = u.y - 1 }) 
    u.sc = 60
   end
  end

  -- 4. bullets: move up, remove off-screen
  for b in all(blts) do
   b.y -= 2
   if (b.y < 0) del(blts, b)
  end

  -- 5. power-ups: spawn every 6 seconds, fall down
  if tmr % 360 == 0 then
   add(pwrs, { x = 80 + rnd(25), y = -20, hp = 5 + #unts * .7 \ 1 })
  end

  -- power-ups: move down, remove off-screen
  for p in all(pwrs) do
   p.y += .2
   for b in all(blts) do
    if col(b, p, 10) then
     p.hp -= 1 burst(b.x, b.y, 6, 3) del(blts, b)
     if p.hp < 1 then
      -- power-up destroyed: recruit 5 new soldiers from below
      add_unts(5, 1) burst(p.x, p.y, 11, 20) shk = 8 del(pwrs, p) break
     end
    end
   end
   if (p.y > 128) del(pwrs, p)
  end

  -- 6. wave spawning: interval shrinks as waves progress
  wt+=1
  if wt>max(60,140-wv*8) then
   wt,wv=0,wv+1
   ho=wv*.05
   -- random burst of small enemies, count grows with wave
   if rnd()<min(.85,.4+ho) then
    for i=0,10 do sp_e(1+ho,4) end
   end
   -- every 5th wave spawns a boss
   if(wv%5==0) sp_e(10+ho,10)
  end

  -- enemies
  for e in all(enms) do
   e.w += .025
   if (e.f > 0) e.f -= 1
   e.y += e.sp
   e.x += sin(e.w) * .3

   for b in all(blts) do
    if col(b, e, e.s) then
     del(blts, b)
     e.hp -= 1
     e.f = 3
     if e.hp < 1 then
      burst(e.x, e.y, 8, e.s)
      shk = 2
      del(enms, e)
     end
     break
    end
   end

   for u in all(unts) do
    if col(u, e, e.s) then
     burst(u.x, u.y, 11, 6)
     del(unts, u)
     break
    end
   end

   if e.y > 128 then
    -- enemy reached bottom: kill one soldier
    deli(unts)
    del(enms, e)
   end
  end
 end

 -- draw
 cls(1)

 -- screen shake
 if (shk > 0) camera(rnd(3), rnd(3))
 shk = max(0, shk - 1)

 -- power-ups: yellow square + white dot + hp bar
 for p in all(pwrs) do
  rectfill(p.x - 7, p.y - 7, p.x + 7, p.y + 7, 12)
  rect(p.x - 5, p.y - 5, p.x + 5, p.y + 5, 7)
 end

 for e in all(enms) do
  circfill(e.x, e.y, e.s-1, 2)
  circfill(e.x, e.y, e.s-3, e.f > 0 and 15 or 8)
 end

 -- bullets: white tip + cyan pixel above
 for b in all(blts) do
  pset(b.x, b.y, 15)
  pset(b.x, b.y - 1, 10)
 end

 -- soldiers: cyan circle + white center + blue helmet pixel
 for u in all(unts) do
  circfill(u.x, u.y, 2, 7)
  pset(u.x, u.y, 11)
  pset(u.x, u.y - 3, 14)
 end

 -- particles: fade to dark red after half life, then remove
 for p in all(prts) do
  p.l -= 1
  pset(p.x, p.y, p.l > 5 and p.c or 4)
  if (p.l < 1) del(prts, p)
 end

 -- timer display: seconds survived, top center
  if go then
    rectfill(20,48,108,62,0) 
    ?"\f7score:"..(tmr/60\1),50,53
  end
end
