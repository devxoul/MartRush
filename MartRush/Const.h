//
//  Const.h
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#ifndef MartRush_Const_h
#define MartRush_Const_h

#define MARTRUSH_BOC_EDIT
#define MARTRUSH_HAN_EDIT

//GAME STAGE LEVEL
#define MARTRUSH_STAGE_1            0
#define MARTRUSH_STAGE_2            1
#define MARTRUSH_STAGE_3            2
#define MARTRUSH_STAGE_4            3
#define MARTRUSH_STAGE_5            4

//GAME STATE 
#define GAME_STATE_START            0
#define GAME_STATE_PAUSE            1
#define GAME_STATE_OVER             2
#define GAME_STATE_CLEAR            3

// PLAYER STATE
#define PLAYER_STATE_RUN            0
#define PLAYER_STATE_CRASH          1
#define PLAYER_STATE_CRASHING       2
#define PLAYER_STATE_DEAD           3
#define PLAYER_STATE_LEFTARM_MOVE   4
#define PLAYER_STATE_RIGHTARM_MOVE  5
#define PLAYER_STATE_MOVING         6

#define PLAYER_Y_POSITION           0

#define PLAYER_LEFT_X_POSITION      155
#define PLAYER_RIGHT_X_POSITION     325

//CART STATE
#define CART_LEFT_X_POSITION        155
#define CART_RIGHT_X_POSITION       325

#define CART_Y_POSITION             0

// BOSS STATE
#define BOSS_STATE_RUN              0
#define BOSS_STATE_CRASH            1
#define BOSS_STATE_CRASHING         2
#define BOSS_STATE_DEAD             3
#define BOSS_STATE_ATTACK           4
#define BOSS_STATE_MOVING           5

#define BOSS_LEFT_X_POSITION        155
#define BOSS_RIGHT_X_POSITION       325

#define BOSS_Y_POSITION             180

// WAY STATE
#define LEFT_WAY                    0
#define RIGHT_WAY                   1

// Z ORDER
#define Z_ORDER_BACKGROUND			0
#define Z_ORDER_MERCHANDISE			100000000
#define Z_ORDER_OBSTACLE			200000000
#define Z_ORDER_PLAYER				200000001
#define Z_ORDER_DRAGGING_MERCHANDISE    200000002

#endif
