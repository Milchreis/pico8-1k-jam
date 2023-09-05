pico-8 cartridge // http://www.pico-8.com
version 37
__lua__
pg={
 x=10,
 y=60,
 p=0,
 v=1
}

dia={
 x=20,
 w=80,
 y=130,
 h=50,
 cont=true
}

function _init()
 tweens
  .create()
  .add(pg,"p",1.0,1.3,tweens.ease_in_quad)
  .on_finish(blink)
  .start()
end

function blink()
 tweens
  .create()
  .add(pg,"v",0,0.3)
  .add(pg,"v",1,0.3)
  .add(pg,"v",0,0.3)
  .on_finish(open_dialog)
  .start()
end

function open_dialog()
 tweens
  .create()
  .add(dia,"y",29,0.5,tweens.ease_in_quad)
  .add(dia,"y",32,0.1,tweens.ease_in_quad)
  .add(dia,"y",29,0.05,tweens.ease_in_quad)
  .add(dia,"y",30,0.05,tweens.ease_in_quad)
  .delay(2)
  .on_finish(close_dialog)
  .start()
end

function close_dialog()
 tweens
  .create()
  .parallel()
  .add(dia,"cont",false,0.2)
  .add(dia,"y",130,0.5,tweens.ease_in_quad)
  .add(dia,"h",11,0.3,tweens.ease_in_quad)
  .start()
end

function _update60()
 cls(1)
 -- progressbar
 if pg.v>=0.5 then
  rectfill(
   pg.x,pg.y,
   pg.x+108*pg.p,pg.y+10,
   7)
  print("progress",pg.x+1,pg.y+1,1)
  print("100%",pg.x+93,pg.y+1,1)
 end
 
 -- dialog
 rectfill(
  dia.x,dia.y,
  dia.x+dia.w,dia.y+dia.h,
  8)
 rectfill(
  dia.x+1,dia.y+10,
  dia.x+dia.w-1,dia.y+dia.h-1,
  1)
 if dia.cont then
  print("▤ dialog",dia.x+2,dia.y+2,7)
  print("incoming data",dia.x+4,dia.y+15,7)
 end
 
 tweens.update()
end
-->8
tweens = {
 t = {},
 linear = function(t) return t end,
 ease_in_quad = function(t) return t * t end,
 ease_out_quad = function(t) return t * (2 - t) end,
 ease_in_sin = function(t) return 1 + sin(.5 * t - .5) end,
 ease_out_sin = function(t) return 1 + sin(.5 * t) end
}

tweens.create = function()
 local tween = {
  start = nil,
  motions = {},
  active = false,
  is_pause = false,
  current_motion = 1,
  finish_listener = nil,
  is_parallel = false
 }

 tween.parallel = function()
  tween.is_parallel = true
  return tween
 end

 tween.delay = function(duration)
  tween.add({d=1},"d",nil,duration)
  return tween
 end

 tween.add = function(obj, key, target, duration, easing)
  if tween.is_parallel and count(tween.motions) > 0 then
   local motion = tween.motions[count(tween.motions)]
   add(
    motion.actions, {
     obj = obj,
     key = key,
     target = target,
     duration = duration,
     left_time = 0
    }
   )
  else
   add(
    tween.motions, {
     actions = {
      {
       obj = obj,
       key = key,
       target = target,
       duration = duration,
       left_time = 0
      }
     },
     easing = easing or tweens.linear
    }
   )
  end
  return tween
 end

 tween.update = function()
  if not tween.active or tween.is_paused then return end
  local motion = tween.motions[tween.current_motion]
  local dt = 1 / stat(8)

  for a in all(motion.actions) do
   if a.left_time == 0 then a.start = a.obj[a.key] end
   if a.key and type(a.target) == "boolean" then
    if min(a.left_time / a.duration, 1.0) == 1.0 then
     a.obj[a.key] = a.target
    end
   end
   if a.key and type(a.target) == "number" then
    local pg = min(a.left_time / a.duration, 1.0)
    a.obj[a.key] = motion.easing(pg) * (a.target - a.start) + a.start
   end
   if a.left_time > a.duration then
    del(motion.actions, a)
   end
   a.left_time += dt
  end

  if count(motion.actions) == 0 then
   tween.current_motion += 1
   if tween.current_motion > count(tween.motions) then
    tween.active = false
    del(tweens.t, tween)
    if tween.finish_listener != nil then
     tween.finish_listener(tween)
    end
    return
   end
  end
 end

 tween.stop = function()
  tween.active = false
  return tween
 end

 tween.start = function()
  tween.active = true
  return tween
 end

 tween.on_finish = function(listener)
  tween.finish_listener = listener
  return tween
 end

 add(tweens.t, tween)
 return tween
end

tweens.update = function()
 for t in all(tweens.t) do
  t.update()
 end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
