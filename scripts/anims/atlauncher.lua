local head = piece "head"
local torso = piece "torso"
local pelvis = piece "pelvis"
local gun = piece "gun"
local ground = piece "ground"
local flare = piece "flare"

local luparm = piece "luparm"
local lloarm = piece "lloarm"

local ruparm = piece "ruparm"
local rloarm = piece "rloarm"

local lthigh = piece "lthigh"
local lleg = piece "lleg"
local lfoot = piece "lfoot"

local rthigh = piece "rthigh"
local rleg = piece "rleg"
local rfoot = piece "rfoot"
local backblast = piece "backblast"

local MUZZLEFLASH = 1024 + 6
local MUZZLEDUST = 1024 + 7

local tags = {
	canProneFire = true,
	canStandFire = true,
	canRunFire = false,
	weaponPiece = piece "gun",
	showOnReady = true,
}


local stances = {
	stand_aim = {
					turns = {
						{head, x_axis, math.rad(0)},
						{head, y_axis, math.rad(40)},
						{head, z_axis, math.rad(20)},						
						
						{ruparm, x_axis, 0},
						{ruparm, y_axis, math.rad(60)},
						{ruparm, z_axis, 0},

						{luparm, x_axis, math.rad(-80)},
						{luparm, y_axis, 0},
						{luparm, z_axis, 0},
						
						{rloarm, x_axis, math.rad(-150)},
						{rloarm, y_axis, 0},
						{rloarm, z_axis, 0},

						{lloarm, x_axis, math.rad(-60)},
						{lloarm, y_axis, 0},
						{lloarm, z_axis, 0},
						
						{gun, x_axis, math.rad(45)},
						{gun, y_axis, 0},
						{gun, z_axis, math.rad(-20)},

						{torso, y_axis, math.rad(-40)},
						{torso, z_axis, math.rad(-10)},

						{pelvis, x_axis, 0},
						{pelvis, z_axis, 0},

						{rthigh, x_axis, 0},
						{rthigh, y_axis, 0},
						{rthigh, z_axis, 0},

						{lthigh, x_axis, math.rad(-80)},
						{lthigh, y_axis, 0},
						{lthigh, z_axis, 0},
						
						{rleg, x_axis, math.rad(90)},
						{rleg, y_axis, 0},
						{rleg, z_axis, 0},

						{lleg, x_axis, math.rad(80)},
						{lleg, y_axis, 0},
						{lleg, z_axis, 0},

					},
					moves = {
						{pelvis, y_axis, -2},
					},
					headingTurn = {pelvis, y_axis, 0, 1},
					pitchTurn = {torso, x_axis, math.rad(10), -1},
				},
	stand_ready_1 =	{
					turns = {
						{head,   x_axis, 0},
						{head,   y_axis, 0},
						{head,   z_axis, 0},
						{ruparm, x_axis, math.rad(-60)},
						{ruparm, y_axis, math.rad(-60)},
						{ruparm, z_axis, 0},
						{luparm, x_axis, math.rad(20)},
						{luparm, y_axis, 0},
						{luparm, z_axis, 0},
						{rloarm, x_axis, math.rad(-40)},
						{rloarm, y_axis, 0},
						{rloarm, z_axis, math.rad(120)},
						{lloarm, x_axis, math.rad(30)},
						{lloarm, y_axis, math.rad(80)},
						{lloarm, z_axis, math.rad(-115)},
						{gun,    x_axis, math.rad(20)},
						{gun,    y_axis, 0},
						{gun,    z_axis, math.rad(10)},
						{torso,  x_axis, 0},
						{torso,  y_axis, 0},
						{torso,  z_axis, 0},
					},
				},
	stand_ready_2 = {
					turns = { -- Turns
						{head, x_axis, 0},
						{head, y_axis, 0},
						{head, z_axis, 0},
						{ruparm, x_axis, math.rad(-70)},
						{ruparm, y_axis, math.rad(-40)},
						{ruparm, z_axis, 0},
						{luparm, x_axis, 0},
						{luparm, y_axis, math.rad(20)},
						{luparm, z_axis, 0},
						{rloarm, x_axis, math.rad(-40)},
						{rloarm, y_axis, 0},
						{rloarm, z_axis, math.rad(110)},
						{lloarm, x_axis, math.rad(30)},
						{lloarm, y_axis, math.rad(100)},
						{lloarm, z_axis, math.rad(-70)},
						{gun, x_axis, math.rad(30)},
						{gun, y_axis, 0},
						{gun, z_axis, math.rad(20)},
						{torso, x_axis, 0},
						{torso, y_axis, 0},
						{torso, z_axis, 0},
					},
				},
	prone_ready = {
					turns = { -- Turns
						{head, x_axis, math.rad(-60)},
						{head, y_axis, 0},
						{head, z_axis, 0},

						{ruparm, x_axis, math.rad(-80)},
						{ruparm, y_axis, math.rad(20)},
						{ruparm, z_axis, math.rad(-70)},

						{luparm, x_axis, math.rad(-140)},
						{luparm, y_axis, math.rad(-30)},
						{luparm, z_axis, 0},
						
						{rloarm, x_axis, math.rad(-120)},
						{rloarm, y_axis, math.rad(30)},
						{rloarm, z_axis, 0},

						{lloarm, x_axis, math.rad(20)},
						{lloarm, y_axis, math.rad(65)},
						{lloarm, z_axis, math.rad(-40)},
						
						{gun, x_axis, math.rad(10)},
						{gun, y_axis, math.rad(-35)},
						{gun, z_axis, math.rad(-45)},

						{torso, x_axis, math.rad(-10)},
						{torso, y_axis, math.rad(20)},
						{torso, z_axis, 0},
					},
				},
	prone_aim = {
					turns = { -- Turns
						{head, x_axis, math.rad(-60)},
						{head, y_axis, 0},
						{head, z_axis, 0},

						{ruparm, x_axis, math.rad(-80)},
						{ruparm, y_axis, math.rad(20)},
						{ruparm, z_axis, math.rad(-70)},

						{luparm, x_axis, math.rad(-140)},
						{luparm, y_axis, math.rad(-30)},
						{luparm, z_axis, 0},
						
						{rloarm, x_axis, math.rad(-120)},
						{rloarm, y_axis, math.rad(30)},
						{rloarm, z_axis, 0},

						{lloarm, x_axis, math.rad(20)},
						{lloarm, y_axis, math.rad(65)},
						{lloarm, z_axis, math.rad(-40)},
						
						{gun, x_axis, math.rad(10)},
						{gun, y_axis, math.rad(-35)},
						{gun, z_axis, math.rad(-45)},

						{torso, x_axis, math.rad(-10)},
						{torso, y_axis, math.rad(20)},
						{torso, z_axis, 0},
					},
					headingTurn = {pelvis, y_axis, 0, 1},
					pitchTurn = {torso, x_axis, math.rad(-10), -0.5},
				},
	kf_stand_fire = {
				emit = {
					{backblast, MUZZLEFLASH},
					{backblast, MUZZLEDUST},
				},
	},
	kf_prone_fire = {
				emit = {
					{backblast, MUZZLEFLASH},
					{backblast, MUZZLEDUST},
				},
	},
}

local variants = {
	stand_ready = {stances.stand_ready_1, 
					stances.stand_ready_2},
	prone_ready = { stances.prone_ready},
	run_ready = {stances.stand_ready_1, 
				stances.stand_ready_2},
	stand_aim = { stances.stand_aim},
	prone_aim = { stances.prone_aim},
}

local keyframes = {
	stand_fire = {stances.kf_stand_fire},
	prone_fire = {stances.kf_prone_fire},
}

local keyframeDelays = {
	stand_fire = {0.033, 0.033},
	prone_fire = {0.033, 0.033},
}

return tags, variants, keyframes, keyframeDelays