---- #########################################################################
---- #                                                                       #
---- #                                  MyValue  1                                         
---- #                                                                       #
---- #########################################################################

local options = {
  { "Source", SOURCE, 1 },
  { "MsgNo", VALUE , 1 },
  { "Percent", BOOL , 0 },
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
	local MsgTable = {
   [1] = "DualRate -"
  ,[2] = "Expo -"
  ,[3] = "Rud Mix -"
	,[4] = "Flaps"
  ,[5] = "Brake"
  ,[6] = "Throttle "
	}


	  	value = getValue(thisZone.options.Source)
      
      
  if(value == nil) then
      return
  end

 
 textValue = (MsgTable[thisZone.options.MsgNo])
		--textValue = (MsgTable[thisZone.options.Msg])
   -- textValue = value  

	local xo = thisZone.zone.x + (thisZone.zone.w / 2) - (thisZone.xs * string.len(textValue))
	local yo = thisZone.zone.y + thisZone.yo
	--lcd.setColor(CUSTOM_COLOR, BLACK)
	--lcd.drawText(xo + 2, yo + 2, textValue, thisZone.ts + CUSTOM_COLOR)
	lcd.setColor(CUSTOM_COLOR, thisZone.options.Color)
	lcd.drawText(xo , yo, textValue, thisZone.ts + CUSTOM_COLOR);
  lcd.setColor(CUSTOM_COLOR, thisZone.options.Color)
  
  if (Percent) then
    
	lcd.drawNumber(xo + (thisZone.xs * string.len(textValue) * 1.7), yo, value, thisZone.ts + CUSTOM_COLOR + PREC1);
  
else
  
  lcd.drawNumber(xo + (thisZone.xs * string.len(textValue) * 1.7), yo, value, thisZone.ts + CUSTOM_COLOR );

end

end

return { name="MyValue", options=options, create=create, update=update, background=background, refresh=refresh }
