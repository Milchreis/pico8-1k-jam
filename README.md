# pico8-1k-jam

 * Make cool things in PICO-8 by using only 1K (1024) Compressed Bytes of code
 * [Game jam page](https://itch.io/jam/pico-1k-2022)

## September 2022
**Absorb** 
> Osmos inspired game

![logo_small](https://user-images.githubusercontent.com/544436/189542828-eb58956d-6b14-4a8c-b5c5-0c427e04a784.png)

![pico1k_2022_1](https://user-images.githubusercontent.com/544436/189496187-091f3262-a6a4-4e5e-9d23-74f55272b5ec.gif)
 * play it here on [splore](https://www.lexaloffle.com/bbs/?tid=49288)
 * download and play it on [itch](https://milchreiz.itch.io/absorb)

## September 2023
**Tween library** 
> small library to create simple as possible tweens in PICO-8

![screencast_tween](https://github.com/Milchreis/pico8-1k-jam/assets/544436/ddde853f-834d-4b8b-86bd-e248e607bd55)

 * [source code](https://github.com/Milchreis/pico8-1k-jam/blob/main/2023-09-05_tween.p8)
 * [example](https://github.com/Milchreis/pico8-1k-jam/blob/main/2023-09-05_tween_example.p8)

### Simple example
```lua
-- some object
t={x=1, y=2}

function _init()
 -- create a new tween
 tweens.create()
  -- add a motion for t[x] and move it to x=10 in 3s (linear)
  .add(t, "x", 10, 3)
  -- stay for 1s
  .delay(1)
  .start()
end

function _update60()
 -- update all tweens in each frame
 tweens.update()
end
```

### API
```lua
tweens.create()
  -- all motions will played in parallel
  .parallel()
  -- adds a new motion for obj[key] to bring it to target in duration in seconds
  .add(obj, key, target, duration, easing)
  -- stay for a duration in seconds
  .delay()
  -- set a listener for finished tweens. It will call listener(tween)
  .on_finish(some_function)
  -- starts the tween
  .start()
  -- stops the tween
  .stop()
```
