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
    
    @public
    GameLayer* gamelayer;
    
    int playerState;            //플레이어 상태
    int playerWayState;         //플레이어 way 방향
    int playerHp;               //플레이어 목숨
    
    float playerY;              //Y
    float playerSpeed;
    
    CCAnimate* playerRunAni;    //플레이어 Run Animation
    CCAnimate* playerStateAni;  //플레이어 런을 제외한 Animation    
    
    CCSpriteBatchNode *bachNode;
    CCSprite* playerSpr;        //플레이어 Sprite
    Cart* playerCart;           //플레이어 Cart
    
    CCSpriteBatchNode *bachNodeState;       
    CCSprite* stateSpr;             
    
    int playerCount;
    
    CGRect playerBoundingBox;
}

@property (readwrite) int playerState;
@property (readwrite) int playerWayState;
@property (readwrite) float playerY;
@property (readwrite) float playerSpeed;
@property (readonly) CGRect playerBoundingBox;
@property (readwrite) int playerHp;
@property (retain) Cart* playerCart;

-(void)init:(GameLayer *)_scene;

-(void)createPlayerRunAnimation;                        // 런 액션 만들기 
-(void)startPlayerRunning;                              // 런 액션 스타트 
-(void)stopPlayerRunning;                               // 스탑 

-(void)createPlayerStateAnimation;                      // state에 따른 액션 만들기
-(void)endPlayerCrash:(id)sender;                       // 무빙하고 end

-(void)playerMovingWay:(int)_num;                       // ControlM에서 호출에서 playerWayState수정
-(void)playerSetZorder:(int)_z;                         // player z order setting

-(void)update;                                          // draw

@end
