//
//  Boss.m
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Boss.h"


@implementation Boss

@synthesize bossState;
@synthesize bossWayState;
@synthesize bossY;


-(void)init:(GameLayer*)_layer:(int)_stage
{
    [self createBossRunAnimation:_layer];
    
    [self setBossState:BOSS_STATE_RUN];
    [self setBossWayState:LEFT_WAY];
    [self setBossY:BOSS_Y_POSITION];
    
    [self startBossRunnig];
    
    bossHp = 30;                    
    bossStage = _stage;
}

-(void)createBossRunAnimation:(GameLayer*)_layer
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"boss_run.plist"];
    
    bossSpr = [CCSprite spriteWithSpriteFrameName:@"boss_run_0.png"];
    bossSpr.position = ccp(240, 240);
    bossSpr.anchorPoint = ccp(0.5f, 0.0f);
    
    CCSpriteBatchNode *bachNode = [CCSpriteBatchNode batchNodeWithFile:@"boss_run.png"];
    [bachNode addChild:bossSpr];
    [_layer addChild:bachNode];
    
    NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i++) {
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"boss_run_%d.png", i]];
        [aniFrames addObject:frame];
    }
    
    CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.1f];
    bossRunAni = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];    
}

-(void)startBossRunnig
{
    [bossSpr runAction:[CCRepeatForever actionWithAction:bossRunAni]];     
}

-(void)stopBossRunning
{
    [bossSpr stopAllActions];
}

-(void)update
{
    // BOSS DRAW
    if (nTemp == 0 ) {
        nTemp = (arc4random() % (100 - (10 * bossStage))) + 4;
    }
    
    if(nTemp == bossCount)
    {
        [self bossAi:bossStage];
        bossCount = 0;
    }
    
    bossCount++;
}

-(void)bossMovingWay:(int)_num
{
    if (_num == LEFT_WAY) 
        [bossSpr runAction:[CCMoveTo actionWithDuration:1 position:ccp(BOSS_LEFT_X_POSITION, BOSS_Y_POSITION)]];
    else if (_num == RIGHT_WAY)
        [bossSpr runAction:[CCMoveTo actionWithDuration:1 position:ccp(BOSS_RIGHT_X_POSITION, BOSS_Y_POSITION)]];
}


-(void)bossAi:(int) Stage
{   
    BOOL isMoved = (arc4random()%2 == 0) ? YES : NO ;          // 이동 %는 50%로 고정
    BOOL isFired = (arc4random()%10 < Stage+4 ) ? YES : NO ;   // 발사 %는 스테이지에 따라서 바뀜, 50%, 60%, 70%, 80%, 90%, 스테이지는 1,2,3,4,5로 넘어옴
    
    
    //이동하면 웨이 상태 변경
    if (isMoved) 
    {
        switch (bossWayState) 
        {
            case LEFT_WAY:
                bossWayState = RIGHT_WAY;
                [self bossMovingWay:RIGHT_WAY];
                break;
                
            case RIGHT_WAY:
                bossWayState = LEFT_WAY;
                [self bossMovingWay:LEFT_WAY];
                break;
        }
        
    }
    
    //발사하면 상태 변화
    if(isFired && bossState != BOSS_STATE_MOVING){
        bossState = BOSS_STATE_ATTACK;
    }
    
}

@end
