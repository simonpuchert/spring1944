--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    weapondefs_post.lua
--  brief:   weaponDef post processing
--  author:  Dave Rodgers
--
--  Copyright (C) 2008.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  Per-unitDef weaponDefs
--

local function isbool(x)   return (type(x) == 'boolean') end
local function istable(x)  return (type(x) == 'table')   end
local function isnumber(x) return (type(x) == 'number')  end
local function isstring(x) return (type(x) == 'string')  end

local function tobool(val)
  local t = type(val)
  if (t == 'nil') then
    return false
  elseif (t == 'boolean') then
    return val
  elseif (t == 'number') then
    return (val ~= 0)
  elseif (t == 'string') then
    return ((val ~= '0') and (val ~= 'false'))
  end
  return false
end

--------------------------------------------------------------------------------

local function BackwardCompability(wdName,wd)
  -- weapon reloadTime and stockpileTime were seperated in 77b1
  if (tobool(wd.stockpile) and (wd.stockpiletime==nil)) then
    wd.stockpiletime = wd.reloadtime
    wd.reloadtime    = 2             -- 2 seconds
  end

  -- auto detect ota weapontypes
  if (wd.weapontype==nil) then
    local rendertype = tonumber(wd.rendertype) or 0
    if (tobool(wd.dropped)) then
      wd.weapontype = "AircraftBomb";
    elseif (tobool(wd.vlaunch)) then
      wd.weapontype = "StarburstLauncher";
    elseif (tobool(wd.beamlaser)) then
      wd.weapontype = "BeamLaser";
    elseif (tobool(wd.isshield)) then
      wd.weapontype = "Shield";
    elseif (tobool(wd.waterweapon)) then
      wd.weapontype = "TorpedoLauncher";
    elseif (wdName:lower():find("disintegrator",1,true)) then
      wd.weaponType = "DGun"
    elseif (tobool(wd.lineofsight)) then
      if (rendertype==7) then
        wd.weapontype = "LightingCannon";

      -- swta fix (outdated?)
      elseif (wd.model and wd.model:lower():find("laser",1,true)) then
        wd.weapontype = "LaserCannon";

      elseif (tobool(wd.beamweapon)) then
        wd.weapontype = "LaserCannon";
      elseif (tobool(wd.smoketrail)) then
        wd.weapontype = "MissileLauncher";
      elseif (rendertype==4 and tonumber(wd.color)==2) then
        wd.weapontype = "EmgCannon";
      elseif (rendertype==5) then
        wd.weapontype = "Flame";
      --elseif(rendertype==1) then
      --  wd.weapontype = "MissileLauncher";
      else
        wd.weapontype = "Cannon";
      end
    else
      wd.weapontype = "Cannon";
    end
  end

  -- 
  if (tobool(wd.ballistic) or tobool(wd.dropped)) then
    wd.gravityaffected = true
  end
end

--------------------------------------------------------------------------------

local function ProcessUnitDef(udName, ud)

  local wds = ud.weapondefs
  if (not istable(wds)) then
    return
  end

  -- add this unitDef's weaponDefs
  for wdName, wd in pairs(wds) do
    if (isstring(wdName) and istable(wd)) then
      local fullName = udName .. '_' .. wdName
      WeaponDefs[fullName] = wd
      wd.filename = ud.filename
    end
  end

  -- convert the weapon names
  local weapons = ud.weapons
  if (istable(weapons)) then
    for i = 1, 32 do
      local w = weapons[i]
      if (istable(w)) then
        if (isstring(w.def)) then
          local ldef = string.lower(w.def)
          local fullName = udName .. '_' .. ldef
          local wd = WeaponDefs[fullName]
          if (istable(wd)) then
            w.name = fullName
          end
        end
        w.def = nil
      end
    end
  end

  -- convert the death explosions
  if (isstring(ud.explodeas)) then
    local fullName = udName .. '_' .. ud.explodeas
    if (WeaponDefs[fullName]) then
      ud.explodeas = fullName
    end
  end
  if (isstring(ud.selfdestructas)) then
    local fullName = udName .. '_' .. ud.selfdestructas
    if (WeaponDefs[fullName]) then
      ud.selfdestructas = fullName
    end
  end
end

--------------------------------------------------------------------------------

local function ProcessWeaponDef(wdName, wd)

  -- backward compability
  BackwardCompability(wdName,wd)
end

--------------------------------------------------------------------------------

-- Process the unitDefs
local UnitDefs = DEFS.unitDefs

for udName, ud in pairs(UnitDefs) do
  if (isstring(udName) and istable(ud)) then
    ProcessUnitDef(udName, ud)
  end
end


for wdName, wd in pairs(WeaponDefs) do
  if (isstring(wdName) and istable(wd)) then
    ProcessWeaponDef(wdName, wd)
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local modOptions
if (Spring.GetModOptions) then
  modOptions = Spring.GetModOptions()
end


--------------------------------------------------------------------------------
-- Damage Types
--------------------------------------------------------------------------------


local damageTypes = VFS.Include("gamedata/damagedefs.lua")

for _, weaponDef in pairs(WeaponDefs) do
  if not weaponDef.isshield then
    local damage = weaponDef.damage
    local defaultDamage = damage["default"]
    
    if defaultDamage and tonumber(defaultDamage) > 0 then
      local damageType = "default"
      if weaponDef.customparams and weaponDef.customparams.damagetype then
        damageType = weaponDef.customparams.damagetype
      end
      local mults = damageTypes[damageType]
      if mults then
        for armorType, mult in pairs(mults) do
          if not damage[armorType] then
            damage[armorType] = defaultDamage * mult
          end
        end
      else
        Spring.Echo("weapondefs_post.lua: Invalid damagetype " .. damageType .. " for weapon " .. weaponDef.name)
      end
    end
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Range Multiplier
--

if (modOptions) then
 if (modOptions.weapon_range_mult) then
	local totalWeapons
	totalWeapons = 0
	local rangeCoeff
	rangeCoeff = modOptions.weapon_range_mult
	Spring.Echo("Starting weapon range multiplying, coefficient: "..rangeCoeff)
	for name in pairs(WeaponDefs) do
		local curRange = WeaponDefs[name].range
		if (curRange) then
			WeaponDefs[name].range = curRange * rangeCoeff
			totalWeapons = totalWeapons + 1
		end
	end
	Spring.Echo("Done with the ranges, "..totalWeapons.." weapons processed.")
  end
  
  if (modOptions.weapon_reload_mult) then
	local totalWeapons
	totalWeapons = 0
	local reloadCoeff
	reloadCoeff = modOptions.weapon_reload_mult
	Spring.Echo("Starting weapon reload multiplying, coefficient: "..reloadCoeff)
	for name in pairs(WeaponDefs) do
		local curReload = WeaponDefs[name].reloadtime
		local rendertype = WeaponDefs[name].rendertype
		local explosiongenerator = WeaponDefs[name].explosiongenerator
		if (curReload) then
			WeaponDefs[name].reloadtime = curReload * reloadCoeff
			if (WeaponDefs[name].sprayangle) then
				WeaponDefs[name].sprayangle	= (WeaponDefs[name].sprayangle/reloadCoeff)
			end
			if (WeaponDefs[name].accuracy) then
				WeaponDefs[name].accuracy = (WeaponDefs[name].accuracy/reloadCoeff)
			end
			totalWeapons = totalWeapons + 1
		end
	end
  end
  if (modOptions.weapon_edgeeffectiveness_mult) then
	local edgeeffectCoeff
	edgeeffectCoeff = modOptions.weapon_edgeeffectiveness_mult
	for name in pairs(WeaponDefs) do
		local curEdgeeffect = WeaponDefs[name].edgeeffectiveness
		if (curEdgeeffect) then
			WeaponDefs[name].edgeeffectiveness = curEdgeeffect * edgeeffectCoeff
		end
	end
  end
  
  if (modOptions.weapon_aoe_mult) then
	local aoeCoeff
	aoeCoeff = modOptions.weapon_aoe_mult
	for name in pairs(WeaponDefs) do
		if (WeaponDefs[name].lineofsight ~= 1) then
			local curAoe = WeaponDefs[name].areaofeffect
			if (curAoe) then
				WeaponDefs[name].areaofeffect = curAoe * aoeCoeff
			end
		end
	end
  end
  
  if (modOptions.weapon_hedamage_mult) then
	local heCoeff
	heCoeff = modOptions.weapon_hedamage_mult
	for name in pairs(WeaponDefs) do
		--if (WeaponDefs[name].canattackground == true) and (WeaponDefs[name].lineofsight ~= 1) then
			for armorType,armorDamage in pairs (WeaponDefs[name].damage) do
				WeaponDefs[name].damage[armorType] = armorDamage * heCoeff
			end
		--end
	end
  end
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------