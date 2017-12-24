---- #########################################################################
---- #                                                                       #
---- #                                  MySwitch                                          
---- #                                                                       #
---- #########################################################################

local options = {
  { "Source", SOURCE, 1 },
  { "SwUp", VALUE , 1 },
  { "SwMid", VALUE , 2 },
  { "SwDown", VALUE , 3 },
  { "Color", COLOR, WHITE }
}

local function create(zone, options)
  local thisZone = { zone=zone, options=options, ts = MIDSIZE, xs = 0, yo = 0 }
   
  if 		thisZone.zone.w  > 240 then
	thisZone.ts = XXLSIZE + SHADOWED
	thisZone.xs = 14
	thisZone.yo = thisZone.zone.h / 2 - 38
  elseif 	thisZone.zone.w  > 70 then
	thisZone.ts = DBLSIZE + SHADOWED
	thisZone.xs = 11
	thisZone.yo = thisZone.zone.h / 2 - 20
  else
	thisZone.ts = SMLSIZE + SHADOWED
	thisZone.xs = 4
	thisZone.yo = thisZone.zone.h / 2 - 8
  end
  
  return thisZone
end

local function update(thisZone, options)
  thisZone.options = options
end

local function background(thisZone)
  return
end

function refresh(thisZone)
	
	local textValue
	local MsgTable = {[1] = "Stable"
  ,[2] = "StbOff"
  ,[3] = "SLevel"
	,[4] = "DR   50%"
  ,[5] = "DR   75%"
  ,[6] = "DR 100%"
	,[7] = "Timer On"
  ,[8] = "Timer Off"
  ,[9] = "Panic"
  ,[10] = "Brake On"
  ,[11] = "Brake Off"
  ,[12] = "Flaps Nor"
  ,[13] = "FlpSycAli"
  ,[14] = "Flaperons"
  ,[15] = "Flaps-Up"
  ,[16] = "Flaps-Mid"
	,[17] = "Flaps-Down"}


	  	value = getValue(thisZone.options.Source)
      
  
      
  if(value == nil) then
      return
  end

  textValue = "Not Set"

	if(value == -1024) then
      textValue = (MsgTable[thisZone.options.SwUp])
  end
  
  	if(value == 0) then
      textValue = (MsgTable[thisZone.options.SwMid])
  end	
  
  if(value == 1024) then
      textValue = (MsgTable[thisZone.options.SwDown])
  end	
  

		--textValue = (MsgTable[thisZone.options.Msg])
   -- textValue = value  
  
	local xo = thisZone.zone.x + (thisZone.zone.w / 2) - (thisZone.xs * string.len(textValue))
	local yo = thisZone.zone.y + thisZone.yo
	--lcd.setColor(CUSTOM_COLOR, BLACK)
	--lcd.drawText(xo + 2, yo + 2, textValue, thisZone.ts + CUSTOM_COLOR)
	lcd.setColor(CUSTOM_COLOR, thisZone.options.Color)
	lcd.drawText(xo, yo, textValue, thisZone.ts + CUSTOM_COLOR);
  --lcd.drawSwitch(xo + (thisZone.xs * string.len(textValue) * 1.7), yo, thisZone.options.Source,CUSTOM_COLOR);
  --lcd.drawText(xo + (thisZone.xs * string.len(textValue) * 1.7), yo, thisZone.options.Source,CUSTOM_COLOR);
end

return { name="MySwitch", options=options, create=create, update=update, background=background, refresh=refresh }
