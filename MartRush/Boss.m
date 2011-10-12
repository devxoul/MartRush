//
//  Boss.m
//  MartRush
//
//  Created by 복 & 한 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Boss.h"


@implementation Boss

@dynamic bossState;
@synthesize bossWayState;
@synthesize bossY;
@synthesize bossHp;


-(void)init:(GameLayer*)_layer:(int)_stage
{
    [self createBossRunAnimation:_layer];
    
#ifdef MARTRUSH_HAN_EDIT
    [self createBossCollisionAnimation:_layer];
#endif
    
    [self setBossState:BOSS_STATE_RUN];
    [self setBossWayState:LEFT_WAY];
    [self setBossY:BOSS_Y_POSITION];
    [self startBossRunnig];
    gameLayer = _layer;
    bossHp = 1;                    
    bossStage = _stage;
    nTemp = 0;
    nTemp2 = 0;
    bossAttackCount = 0;
    bossMoveCount = 0;
}

#ifdef MARTRUSH_HAN_EDIT

-(void) bossEndDead:(id)sender{
    
    NSLog(@"bossEndDead");
    [bossSpr setVisible:NO];

}

-(void) bossDoDead{

    NSLog(@"bossDoDead");
    CCCallFunc* bossDoDeadEndCallback = [CCCallFunc actionWithTarget:self selector:@selector(bossEndDead:)];
    CCFiniteTimeAction *action = [CCRotateBy actionWithDuration:2.0f angle:7200.0f];    
    CCFiniteTimeAction *action1 = [CCFadeOut actionWithDuration:2.0f];    
    [bossSpr runAction:action];
    [bossSpr runAction:[CCSequence actions:action1, bossDoDeadEndCallback,nil]];

}

-(void) createBossCollisionAnimation:(GameLayer*)_layer{
    NSLog(@"CreateBossCollisionAnimation");

    //스프라이트 생성
    collisionSpr = [CCSprite spriteWithFile:@"boom.png"];
    collisionSpr.position = bossSpr.position;
    collisionSpr.anchorPoint = ccp(0.5f, 0.25f);
    [_layer addChild:collisionSpr];

    //안보이게 설정
    [collisionSpr setVisible:NO];
    
    
}

-(void) bossDoCollisionAnimation {
    NSLog(@"bossDoCollisionAnimation");
    
    [collisionSpr setVisible:YES];
    [collisionSpr setPosition:bossSpr.position];
    [self stopBossRunning];
    //충돌 애니메이션 후
    CCCallFunc* bossCollisionCallback = [CCCallFunc actionWithTarget:self selector:@selector(bossEndCollision:)];
    
    CCFiniteTimeAction *action = [CCFadeOut actionWithDuration:1.0];
        
    [collisionSpr runAction:action];
    [collisionSpr runAction:[CCSequence actions:action, bossCollisionCallback,nil]];
    
}

-(void) bossEndCollision:(id)sender{
//    NSLog(@"bossEndCollision");

    [collisionSpr stopAllActions];
    [collisionSpr setVisible:NO];

    bossHp--;
    if(bossHp == 0){
        bossState = BOSS_STATE_DEAD;
        NSLog(@"Boss last collision");
        [self bossDoDead];
    }
    else{
        bossState = BOSS_STATE_RUN;
        [self startBossRunnig];
    }
}

#endif




-(void)createBossRunAnimation:(GameLayer*)_layer
{    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"boss_run.plist"];
    bossSpr = [[CCSprite spriteWithSpriteFrameName:@"boss_run_0.png"] retain];
    bossSpr.position = ccp(240, BOSS_Y_POSITION);
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

-(void)setBossState:(int)State{
    switch (State) {
        case BOSS_STATE_CRASH:
            bossState = BOSS_STATE_CRASHING;
            [self bossDoCollisionAnimation];
            break;
    }
}

-(int)getBossState{
    return bossState;
}


-(void)update
{
    // BOSS DRAW
    if (nTemp == 0 ) {
        nTemp = (arc4random() % (100 - (10 * bossStage) + bossHp)) + 4;
    }
    if (nTemp2 == 0 ){
        nTemp2 = (arc4random() % (100 - (10 * bossStage) + bossHp)) + 4;
    }
    
  

    if( arc4random() % 100 == 3 && bossState == BOSS_STATE_RUN){
        [self setBossState:BOSS_STATE_CRASH];
    }
    
    if(nTemp == bossMoveCount)
        [self bossAiMoving:MARTRUSH_STAGE_1];

    if(nTemp2 == bossAttackCount)
        [self bossAiAttack:MARTRUSH_STAGE_1];
    
    
    bossMoveCount++;
    bossAttackCount++;
    
}

-(void)bossMovingWay:(int)_num
{
    //call back  액션이 끝나고 bossEndMoving으로가게 
    CCCallFunc* bossEndMoving = [CCCallFunc actionWithTarget:self selector:@selector(bossEndMoving:)];
    
    if (_num == LEFT_WAY) 
        [bossSpr runAction:[CCSequence actions:[CCMoveTo actionWithDuration:1 position:ccp(BOSS_LEFT_X_POSITION, BOSS_Y_POSITION)], bossEndMoving, nil]];
    else if (_num == RIGHT_WAY)
        [bossSpr runAction:[CCSequence actions:[CCMoveTo actionWithDuration:1 position:ccp(BOSS_RIGHT_X_POSITION, BOSS_Y_POSITION)], bossEndMoving, nil]];
}

-(void)bossEndMoving:(id)sender
{
    bossState = BOSS_STATE_RUN;
}

-(void)bossEndAttack:(id)sender
{
    bossState = BOSS_STATE_RUN;
}


-(void)bossAiMoving:(int)_stage
{
    BOOL isMoved = (arc4random()%2 == 0) ? YES : NO ;          // 이동 %는 50%로 고정
    //이동하면 웨이 상태 변경
    bossMoveCount = 0;
    nTemp = 0;
    
    if (isMoved && bossState == BOSS_STATE_RUN) 
    {
        bossState = BOSS_STATE_MOVING;
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

}



-(void)bossAiAttack:(int)_stage
{
    BOOL isFired = (arc4random()%10 < _stage+4 ) ? YES : NO ;   // 발사 %는 스테이지에 따라서 바뀜, 50%, 60%, 70%, 80%, 90%, 스테이지는 1,2,3,4,5로 넘어옴
    
    bossAttackCount = 0;
    nTemp2 = 0;
    
    //발사하면 상태 변화
    if(isFired && bossState == BOSS_STATE_RUN){
        bossState = BOSS_STATE_ATTACK;

#ifdef MARTRUSH_HAN_EDIT
        //Obstacle 생성..   
        [[[gameLayer gameScene] movementManager] createObstacle:@"boss_run_0.png" way:bossWayState z:200000000 speed:bossStage];
        bossState = BOSS_STATE_RUN;
#endif
    }    
    
}

@end
