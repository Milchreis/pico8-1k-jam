-- let lasso
-- by milchreis
-- for pico1k jam in 2023

x=62
y=100
d=10

angle=0
stp=0

shake_fps=0
jump_fps=0
cur_l=0
total_t=0

e={}
r={}
l={
 -- l1
	{5},
	-- l2
	{10, 62,62},
	-- l3
	{10, 62,30, 30,100, 94,100},
	-- l4
	{8,  62,22, 62,55, 62,72},
	-- l5
	{10, 30,30, 94,94, 30,94, 94,30},
	-- l6
	{12, 30,90, 45,60, 75,60, 90,90, 60,30},
	-- l7
	{10,  5,64, 20,64, 35,64, 50,64, 65,64, 80,64, 95,64, 110,64},
	-- l8
	{9, 20,20, 40,40, 60,60, 80,80, 100,100},
}

function col(r1x,r1y,r1w,r1h,r2x,r2y,r2w,r2h)
	 return 
	 	r1x+r1w>=r2x and
   r1x<=r2x+r2w and
   r1y+r1h>=r2y and
   r1y<=r2y+r2h
end

function check_start()
	if btn(❎) then
		cur_l=1
		total_t=0
		_init()
	end
end

function conture(txt,x,y,c1,c2)
	for i=-1,1,1 do
		for j=-1,1,1 do
			?txt,x+i,y+j,c2
		end
	end
	?txt,x,y,c1
end

function _init()
	-- on menu stop init
	if cur_l>#l or cur_l==0 then return end
	
	local lvl=l[cur_l]
	d=10

 -- set seed for rnd to respawn
 -- enemies on same place
 -- it's neccessary to make the
 -- game speed-run ready
	srand(#lvl)
	
	-- create enemies
	for i=1,lvl[1] do
		add(e,{
			x=10+rnd(110),
			y=10+rnd(80),
			dx=rnd(2)-1,
			dy=rnd(2)-1,
			-- current state of catched
			catched=false,
			-- no. of catches
			-- will increased by 0.5,
			-- otherwise the value is to high
			-- and there was no space for calc.
			cc=1
		})
	end
	
	-- create rocks
	for i=2,#lvl,2 do
		add(r,{lvl[i],lvl[i+1]})
	end
end

function _update60()
	cls(15)
	
	if cur_l==0 then
		conture(
			"\^w\^tlet lasso",
			10,46,7,8)
		--rectfill(9,58,65,64,8)
		?"catch 'em all",10,59,8
		
		?"press ❎",10,70+sin(t()*2),8
		check_start()
		return
	end
	
	local lvl=l[cur_l]
	
	-- check win
	if cur_l>#l then
		conture(
			"\^w\^tyou won",
			10,46,7,8)
		?"⧗"..total_t.." s",10,60,0
		?"press ❎",10,70+sin(t()*2),8
		check_start()
		return
	end
	
	-- count down the stop phase
	stp=max(stp-1,0)

	-- camera shake
	camera(0,0)
	if shake_fps > 0 then
	 camera(rnd(3),rnd(3))
		shake_fps-=1
	end
		
	-- render rocks
	for i=2,#lvl,2 do
		?"✽",lvl[i],lvl[i+1],5
	end

	-- player
	local tx=x+d*cos(angle)
	local ty=y+d*sin(angle)
	local pc=0

	-- jump animation
	if jump_fps>0 then
		pc=sin(t()*5)+1
		jump_fps-=1
	end
	
	-- render player
	?"웃",x,y-2+pc,0
	line(x+3,y-1+pc,x+3,y-1+pc,7)

	-- update rotation
	if stp==0 then
		angle-=0.008+d/6000
	end
	
	-- enemy
	for _e in all(e) do
	 -- movement
	 -- the enemy moves by its direction
	 -- it gets faster the more it get catched
		_e.x+=_e.dx*0.05*_e.cc
		_e.y+=_e.dy*0.05*_e.cc
		
		-- change direction on bounds
		if _e.x<1 or _e.x>122 then _e.dx*=-1 end
		if _e.y<2 or _e.y>124 then _e.dy*=-1 end
		
		-- change outline on catched
		local ec=15
		if _e.catched then ec=7 end
		-- render enemy
		conture("🐱",_e.x,_e.y-2,8,ec)
		?"웃",_e.x,_e.y,8
					
		-- check collision with lasso
		if stp==0 and not _e.catched and col(tx-4,ty-3,8,3,_e.x-1,_e.y-3,8,8) then
			_e.catched=true
			_e.cc+=.5
			-- sound for catch
			?"\as9x3c1"
		end
		
		-- check collision with rocks
		for i=2,#lvl,2 do
			if _e.catched and col(lvl[i],lvl[i+1],6,4,_e.x-1,_e.y-3,8,8) then
				_e.catched=false
				stp=30
				shake_fps=4
				-- sound for lost catch
				?"\ai7v2c1g0"
			end
		end
		
		if _e.catched then
			-- follow lasso
			_e.x=tx
			_e.y=ty
			
			-- on pickup
			if d==10 then
				del(e,_e)
 			jump_fps+=30
				?"\ai7x1v2c1e1g1"
				
				-- last one?
				-- the level is clear
				if #e==0 then
					cur_l+=1
					?"\ai7c7"
					_init()
				end
			end
		end
	end
		
	-- lasso
	oval(tx-4,ty-3,tx+4,ty,4)
	line(tx,ty,x,y,4)
	
	-- input
	if stp==0 and btn(❎) then
		d=min(d+1,120)
	else
		d=max(d-2,10)
	end
	
	-- count time for this run
	total_t+=1/stat(8)
	?"⧗"..flr(total_t),1,1,7
	
	-- lvl progress
	rectfill(109,2,109+(cur_l-1)*2,4,7)
	rect(109,2,125,4,7)
end

