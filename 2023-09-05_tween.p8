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
