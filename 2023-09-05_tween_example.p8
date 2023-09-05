pg={
	x=10,
	y=60,
	p=0,
	v=1
}

dia={
	x=20,
	w=84,
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
		.add(dia,"y",39,0.5,tweens.ease_in_quad)
		.add(dia,"y",42,0.1,tweens.ease_in_quad)
		.add(dia,"y",39,0.05,tweens.ease_in_quad)
		.add(dia,"y",40,0.05,tweens.ease_in_quad)
		.delay(1.75)
		.on_finish(close_dialog)
		.start()
end

function close_dialog()
	tweens
		.create()
		.parallel()
		.add(dia,"cont",false,0.01)
		.add(dia,"y",130,0.3,tweens.ease_in_quad)
		.add(dia,"h",11,0.1,tweens.ease_in_quad)
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
 print("▤ dialog",dia.x+2,dia.y+2,7)
 if dia.cont then
	 print("incoming data",dia.x+4,dia.y+15,7)
 end
 
	tweens.update()
end
