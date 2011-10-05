//
//  Boss.h
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Const.h"

@class GameLayer;

@interface Boss : NSObject{
    
    int bossState;          //보스 상태
    int bossWayState;       //보스 도로 방향
    int bossHp;             //보스 생명
    float bossY;            //보스 y
    
    CCAnimate* bossRunAni;  //보스 run
    
    CCSprite* bossSpr;      //보스 Sprite    
    CCSprite* bossItemSpr;  //보스 item Sprite
    
    int bossCount;          //보스 카운터
    int nTemp;              //temp variable
    int bossStage;          //보스 레벨 
}

@property (readwrite) int bossState;
@property (readwrite) int bossWayState;
@property (readwrite) float bossY;

-(void)init:(GameLayer*)_layer:(int)_stage;
-(void)update;
-(void)bossAi:(int)Stage;                              // boss ai setting

-(void)createBossRunAnimation:(GameLayer*)_layer;       // boss run action create
-(void)startBossRunnig;                                 // boss run action start
-(void)stopBossRunning;                                 // boss all action stop

-(void)bossMovingWay:(int)_num;                         // boss way set


@end
