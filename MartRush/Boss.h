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
    
<<<<<<< HEAD
    int movingTiming;       //보스 움직이는 타이밍 체크 카운트
    int firingTiming;       //보스 발사하는 타이밍 체크 카운트

=======
    CCAnimate* bossRunAni;  //보스 run
>>>>>>> 71a1f67b432a0c9cfbcd87b3f13967b729a5a3b8
    
    CCSprite* bossSpr;      //보스 Sprite    
    CCSprite* bossItemSpr;  //보스 item Sprite
}

@property (readwrite) int bossState;
@property (readwrite) int bossWayState;
@property (readwrite) float bossY;

-(void)init:(GameLayer*)_layer;
-(void)update;
-(void)bossAi:(int) Stage;

-(void)createBossRunAnimation:(GameLayer*)_layer;
-(void)startBossRunnig;
-(void)stopBossRunning;

@end
