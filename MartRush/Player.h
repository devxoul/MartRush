//
//  Player.h
//  MartRush
//
//  Created by 복 & 한 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Const.h"
#import "Cart.h"

@class GameLayer;

@interface Player : NSObject {
    
    int playerState;            //플레이어 상태
    int playerWayState;         //플레이어 way 방향
    int playerHp;               //플레이어 목숨
    
    float playerY;              //Y
    
    CCAnimate* playerRunAni;    //플레이어 Run Animation
    CCAnimate* playerStateAni;  //플레이어 런을 제외한 Animation    

    CCSpriteBatchNode *bachNode;
    CCSprite* playerSpr;        //플레이어 Sprite
    Cart* playerCart;           //플레이어 Cart
    
    CCSpriteBatchNode *bachNodeState;       
    CCSprite* stateSpr;             
    
    int playerCount;
    
}

@property (readwrite) int playerState;
@property (readwrite) int playerWayState;
@property (readwrite) float playerY;

-(void)init:(GameLayer *)_scene;

-(void)createPlayerRunAnimation:(GameLayer*)_layer;     // 런 액션 만들기 
-(void)startPlayerRunning;                              // 런 액션 스타트 

-(void)createPlayerStateAnimation:(GameLayer*)_layer;   // state에 따른 액션 만들기
-(void)startPlayerStating:(CCAnimate*)_ani;             // state 액션 스타트 
 
-(void)stopPlayerRunning;                               // 스탑 

-(void)playerMovingWay:(int)_num;                       // ControlM에서 호출에서 playerWayState수정
-(void)playerSetZorder:(GameLayer*)_layer:(int)_z;      // player z order setting

-(void)update;                                          // draw

@end
