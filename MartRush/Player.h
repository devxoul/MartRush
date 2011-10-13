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

@class Cart;
@class GameLayer;

@interface Player : NSObject {
    
    @public
    GameLayer* gamelayer;
    
    NSInteger state;            //플레이어 상태
    NSInteger wayState;         //플레이어 way 방향
    NSInteger hp;               //플레이어 목숨
    
    float y;              //Y
    float speed;
    
    CCAnimate* runAni;    //플레이어 Run Animation
    CCAnimate* stateAni;  //플레이어 런을 제외한 Animation    
    
    CCSpriteBatchNode *bachNode;
    CCSprite* spr;        //플레이어 Sprite
    Cart* cart;           //플레이어 Cart
    
    CCSpriteBatchNode *bachNodeState;       
    CCSprite* stateSpr;             
    
    CGRect boundingBox;
}

@property (readwrite) NSInteger state;
@property (readwrite) NSInteger wayState;
@property (readwrite) float y;
@property (readwrite) float speed;
@property (readonly) CGRect boundingBox;
@property (readwrite) NSInteger hp;
@property (retain) Cart* cart;

-(id)initWithGameLayer:(GameLayer *)_layer;

-(void)createPlayerRunAnimation;                        // 런 액션 만들기 
-(void)startPlayerRunning;                              // 런 액션 스타트 
-(void)stopPlayerRunning;                               // 스탑 

-(void)createPlayerStateAnimation;                      // state에 따른 액션 만들기
-(void)endPlayerCrash:(id)sender;                       // 무빙하고 end

-(void)playerSetZorder:(NSInteger)_z;                         // player z order setting

-(void)update;                                          // draw

@end
