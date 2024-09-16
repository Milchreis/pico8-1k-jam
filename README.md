# PICO-8 1k-jam

> Make cool things in PICO-8 by using only 1K (1024) Compressed Bytes of code

 * [Game jam page 2024](https://itch.io/jam/pico-1k-2024)
 * [Game jam page 2023](https://itch.io/jam/pico-1k-2023)
 * [Game jam page 2022](https://itch.io/jam/pico-1k-2022)

## September 2024
### 🛠 Helicoptr
> Rescue some boxes with power of a helicopter

![helicoptr_0](https://github.com/user-attachments/assets/22c05953-d4f8-4df3-b7ff-9a265e8e64ab)
 * play it on [itch](https://milchreiz.itch.io/helicoptr-1k)
 * [source code](https://github.com/Milchreis/pico8-1k-jam/blob/main/2024-09-16_helicoptr.p8)


## September 2023
### Let Lasso
> One button catching game

![lasso_3](https://github.com/Milchreis/pico8-1k-jam/assets/544436/6d869490-970e-46ba-a54e-95d685f947d5)
 * play it on [itch](https://milchreiz.itch.io/let-lasso)
 * [source code](https://github.com/Milchreis/pico8-1k-jam/blob/main/2023-09-19_let-lasso.p8)

### Tween library 
> small library to create simple as possible tweens in PICO-8

![screencast_tween](https://github.com/Milchreis/pico8-1k-jam/assets/544436/ddde853f-834d-4b8b-86bd-e248e607bd55)

 * [source code](https://github.com/Milchreis/pico8-1k-jam/blob/main/2023-09-05_tween.p8)
 * [example](https://github.com/Milchreis/pico8-1k-jam/blob/main/2023-09-05_tween_example.p8)

#### Simple example
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

#### API
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

-- easings
tweens.linear
tweens.ease_in_quad
tweens.ease_out_quad
tweens.ease_in_sin
tweens.ease_out_sin
```

## September 2022
### Absorb 
> Osmos inspired game

![logo_small](https://user-images.githubusercontent.com/544436/189542828-eb58956d-6b14-4a8c-b5c5-0c427e04a784.png)

![pico1k_2022_1](https://user-images.githubusercontent.com/544436/189496187-091f3262-a6a4-4e5e-9d23-74f55272b5ec.gif)
 * play it here on [splore](https://www.lexaloffle.com/bbs/?tid=49288)
 * download and play it on [itch](https://milchreiz.itch.io/absorb)
 * [source code](https://github.com/Milchreis/pico8-1k-jam/blob/main/2022-09-absorb.p8)
