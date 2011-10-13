//
//  Boss.h
//  MartRush
//
//  Created by 복 & 한 on 11. 9. 30..
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
  int bossMaxHp;
  float bossY;            //보스 y
  
  CCAnimate* bossRunAni;  //보스 run
  
  CCSprite* bossSpr;      //보스 Sprite    
  CCSprite* bossItemSpr;  //보스 item Sprite
  
  int bossMoveCount;          //보스 움직임 카운터
  int bossAttackCount;    //보스 공격 카운터
  
  int nTemp;              //temp variable
  int nTemp2;             //temp2 variable
  
  int bossStage;          //보스 레벨 
  
  GameLayer *gameLayer;
  CCSprite *collisionSpr;
  
  CCAnimate* bossCollisionAni;   //보스 충돌
  
}

@property (readwrite) int bossState;
@property (readwrite) int bossWayState;
@property (readwrite) float bossY;
@property (readwrite) int bossHp;
@property (readwrite) int bossMaxHp;

-(void)init:(GameLayer*)_layer;
-(void)update;

-(void)bossAiMoving:(int)_stage;                        // boss ai setting
-(void)bossAiAttack:(int)_stage;                        // boss ai attack

-(void)bossEndMoving:(id)sender;                        // boss Moving stop
-(void)bossEndAttack:(id)sender;                        // boss Attack stop

-(void)createBossRunAnimation:(GameLayer*)_layer;       // boss run action create
-(void)startBossRunnig;                                 // boss run action start

-(void)stopBossRunning;                                 // boss all action stop

-(void)bossMovingWay:(int)_num;                         // boss way set

#ifdef MARTRUSH_HAN_EDIT
-(void) bossEndCollision:(id)sender;
-(void) createBossCollisionAnimation:(GameLayer*)_layer;
-(void) bossDoCollisionAnimation;
#endif

@end
