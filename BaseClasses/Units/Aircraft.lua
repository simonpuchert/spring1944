-- Aircraft ----
local Aircraft = Unit:New{
	airSightDistance	= 4000,
	brakeRate			= 5,
	canFly				= true,
	canMove				= true,
	category			= "AIR",
	explodeAs			= "Vehicle_Explosion_Med",
	footprintX			= 4,
	footprintZ			= 4,
	allowTerrainCollisions		= false, 
	idleAutoHeal		= 2,
	idleTime			= 1800,
	myGravity			= 0.6,
	noChaseCategory		= "FLAG MINE",
	radardistance		= 1000,
	repairable			= false,
	script				= "Aircraft.lua",
	sightdistance		= 0,
	stealth				= true,
	turnRate			= 50,

	customParams = {
		damageGroup			= "planes",
		feartarget			= true,
		proptexture			= "prop3.tga",
		soundcategory		= "<SIDE>/Air",
		wiki_parser                 = "aircraft",  -- aircrafts.md template
		wiki_subclass_comments      = "",          -- To be override by boat classes
		wiki_comments               = "",          -- To be override by each unit
	},
}

local Recon = Aircraft:New{
	description			= "Recon Plane",
	buildCostMetal		= 1000,
	cruiseAlt			= 1500,
	iconType			= "recon",

	maxAcc				= 0.343,
	maxAileron			= 0.005,
	maxBank				= 0.1,
	maxElevator			= 0.005,
	maxPitch			= 1,
	maxRudder			= 0.005,
	maxVelocity			= 11.2,
	radardistance		= 1500,
	sightDistance		= 600,

	customParams = {
		maxFuel				= 60,
		wiki_subclass_comments = [[Cheap aircraft used to carry out scouting
tasks. A great way to spy enemy, and to provide a line of sight to your long
range weapons (care, unlike terrain and water units, it is not improving the
accuracy). Stay away from enemy AA.]],
	},
}

local Fighter = Aircraft:New{
	description			= "Air-Superiority Fighter",
	cruiseAlt			= 1500,
	noChaseCategory		= "FLAG MINE INFANTRY DEPLOYED SOFTVEH OPENVEH HARDVEH SHIP LARGESHIP BUILDING TURRET",
	iconType			= "fighter",
	customParams = {
		soundcategory		= "<SIDE>/Air/Fighter",
		maxFuel				= 180,
		wiki_subclass_comments = [[Designed to hunt enemy aircrafts. However,
it can be very useful to strike against infantry, deployed guns, or even light
vehicles.]],
	},

	-- sfxTypes = { -- TODO: remove once using LUS
		-- explosionGenerators = {
			-- "custom:SMOKEPUFF_GPL_FX",
			-- "custom:MG_MUZZLEFLASH",
			-- "custom:XSMALL_MUZZLEFLASH",
			-- "custom:MG_SHELLCASINGS",
		-- },
	-- },
}

local Interceptor = Fighter:New{
	description			= "Interceptor",
	cruiseAlt			= 1500,
	customParams = {
		maxFuel				= 120,
	},
}

local AttackFighter = Fighter:New{
	description			= "Attack Fighter",
	cruiseAlt			= 1500,
	maxPitch				= 0.24,
	maxElevator				= 0.002,
	noChaseCategory		= "FLAG INFANTRY DEPLOYED AIR BUILDING MINE",
	customParams = {
		wiki_subclass_comments = [[Unit specifically designed to carry out
terrain/water units strikes. This is a very dangerous unit, which may inflict
dramatically large amount of damage. However, they are quite vulnerable to
AA defenses]],
	},
}

local FighterBomber = Fighter:New{
	attackSafetyDistance	= 200,
	description				= "Fighter-Bomber",
	iconType				= "bomber",
	cruiseAlt				= 1500,
	noChaseCategory		= "FLAG AIR MINE",
	fireState				= 0,
	maxElevator				= 0.001,
	maxPitch				= 0.2,

	customParams = {
		maxFuel				= 60,
		wiki_subclass_comments = [[Unit specifically designed to carry out
buildings strikes. This is a very dangerous unit, which may inflict
dramatically large amount of damage. However, they are quite vulnerable to
AA defenses]],
	},

	weapons = {
		[1] = {
			name				= "bomb",
			maxAngleDif			= 20,
			mainDir				= [[0 0 1]],
		},
	},
}

local CruiseMissile = Aircraft:New{
	buildCostMetal				= 6000,
	cruiseAlt					= 1500,
	iconType					= "fighter",
	maxAcc						= 0,
	maxAileron					= 0.00465,
	maxBank						= 1,
	maxElevator					= 0.0036,
	maxPitch					= 1,
	maxRudder					= 0.002765,
	maxVelocity					= 18.2,
	radardistance				= 0,
	airSightDistance			= 0,

	customParams = {
		cruise_missile_accuracy		= 400,
		enginesound					= "v1-",
		enginesoundnr				= 19,
		enginevolume				= 8,
		deposit						= 0,
		maxFuel						= 120,
		wiki_subclass_comments = [[Inaccurate cruise missile which can be sent
from your far and safe radar station to anywhere.]],
	},
}

local Glider = Aircraft:New{
	airSightDistance	= 0,
	buildCostMetal		= 6000,
	corpse				= "<NAME>_Damaged",
	cruiseAlt			= 1500,

	customParams = {
		cruise_missile_accuracy	= 1,
		deposit					= 0,
		maxFuel				= 120,
		wiki_subclass_comments = [[Gliders are aircrafts meant to land in a
designated area, deploying a relatively large task force, enough to cause big
troubles in enemy base, or to recover some flags. Gliders are extremely
vulnerable to AA, at a point that they cannot even flight over a protected
area.]],
	},
	explodeAs			= "noweapon",
	iconType			= "transportplane",
	maxAcc				= 0,
	maxAileron			= 0.00465,
	maxBank				= 1,
	maxDamage			= 215,
	maxElevator			= 0.0036,
	maxPitch			= 1,
	maxRudder			= 0.002765,
	maxVelocity			= 9.8,

}

local ParaTransport = Aircraft:New{
	description			= "Paratroop Transport Plane",
	buildCostMetal		= 3000,
	cruiseAlt			= 2100,

	footprintX			= 6,
	footprintZ			= 6,
	iconType			= "transportplane",

	maxAcc				= 0.309,
	maxAileron			= 0.003,
	maxBank				= 0.25,
	maxElevator			= 0.0025,
	maxPitch			= 1,
	maxRudder			= 0.002,
	maxVelocity			= 11.2,
	refuelTime			= 10,

	customParams = {
		damageGroup			= "armouredPlanes",
		deposit			= 0,
		troopdropper	= 1,
		maxFuel				= 180,
		wiki_subclass_comments = [[Airbourne troopers transport and drop. This
aircraft will flight over a designated area, releasing paratroopers. In fact a
really fast way to deploy infantry anywhere. Meanwhile the aircraft can be
armoured enough to flight over AA protected areas, the paratroopers exposed to
AA fire are easy targets.]],
	},
	weapons = {
		[1] = {
			name			= "<SIDE>_paratrooper",
		},
	}
}

local ArmouredPlane = Def:New{
	customParams = {
		damageGroup		= "armouredPlanes",
	}
}

return {
	Aircraft = Aircraft,
	Recon = Recon,
	Fighter = Fighter,
	Interceptor = Interceptor,
	AttackFighter = AttackFighter,
	FighterBomber = FighterBomber,
	CruiseMissile = CruiseMissile,
	Glider = Glider,
	ArmouredPlane = ArmouredPlane,
	ParaTransport = ParaTransport,
}
