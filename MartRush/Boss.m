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
    bossHp = 30;                    
    bossStage = _stage;
}

#ifdef MARTRUSH_HAN_EDIT

-(void) createBossCollisionAnimation:(GameLayer*)_layer
{
    NSLog(@"CreateBossCollisionAnimation");
    
    //애니메이션 - 충돌생성
 /*   [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Boom_list.plist"];
    
    collisionSpr = [CCSprite spriteWithSpriteFrameName:@"Boom1.png"];
    collisionSpr.position = bossSpr.position;
    collisionSpr.anchorPoint = ccp(0.5f, 0.0f);
    
    CCSpriteBatchNode *bachNode = [CCSpriteBatchNode batchNodeWithFile:@"Boom_list.png"];
    [bachNode addChild:collisionSpr];
    [_layer addChild:bachNode];
    
    NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
    
    for (int i = 1; i < 5; i++) {
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Boom%d.png", i]];
        [aniFrames addObject:frame];
    }
        
    CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.1f];
    bossCollisionAni = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];    
*/
    
    
    //스프라이트만 생성

    collisionSpr = [CCSprite spriteWithFile:@"Boom1.png"];
    collisionSpr.position = bossSpr.position;
    collisionSpr.anchorPoint = ccp(0.5f, 0.0f);
    [_layer addChild:collisionSpr];

    
    [collisionSpr setVisible:NO];
    
    
}

-(void) bossDoCollisionAnimation {
    NSLog(@"bossDoCollisionAnimation");
    
    [collisionSpr setVisible:YES];
    [collisionSpr setPosition:bossSpr.position];
    
    CCCallFunc* bossCollisionCallback = [CCCallFunc actionWithTarget:self selector:@selector(bossEndCollision:)];
    
    CCFiniteTimeAction *action = [CCFadeOut actionWithDuration:0.3];
    
    //CCAction *action = [CCFadeOut actionWithDuration:0.3];
    
    [collisionSpr runAction:action];
    [collisionSpr runAction:[CCSequence actions:action, bossCollisionCallback,nil]];
    //[collisionSpr runAction:[CCSequence actions:bossCollisionAni, bossCollisionCallback, nil]];
    
}

-(void) bossEndCollision:(id)sender{
    NSLog(@"bossEndCollision");

    [collisionSpr stopAllActions];
    [collisionSpr setVisible:NO];

    bossHp--;
    if(bossHp == 0){
        bossState = BOSS_STATE_DEAD;
    }
    else
        bossState = BOSS_STATE_RUN;
}

#endif




-(void)createBossRunAnimation:(GameLayer*)_layer
{    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"boss_run.plist"];
    bossSpr = [[CCSprite spriteWithSpriteFrameName:@"boss_run_0.png"] retain
               ];
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



-(void)update
{
    // BOSS DRAW
    if (nTemp == 0 ) {
        nTemp = (arc4random() % (100 - (10 * bossStage) + bossHp)) + 4;
    }
    if (nTemp2 == 0 ){
        nTemp2 = (arc4random() % (100 - (10 * bossStage) + bossHp)) + 4;
    }
    
    if(nTemp == bossMoveCount)
        [self bossAiMoving:MARTRUSH_STAGE_1];

    if(nTemp2 == bossAttackCount)
        [self bossAiAttack:MARTRUSH_STAGE_1];

    bossMoveCount++;
    bossAttackCount++;
    
    switch (bossState) {
        case BOSS_STATE_DEAD:
            break;
        case BOSS_STATE_CRASH:
            [self bossDoCollisionAnimation];
            break;
    }
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
    bossMoveCount = 0;
    nTemp = 0;
}

-(void)bossEndAttack:(id)sender
{
    bossState = BOSS_STATE_RUN;
    bossAttackCount = 0;
    nTemp2 = 0;
}


-(void)bossAiMoving:(int)_stage
{
    BOOL isMoved = (arc4random()%2 == 0) ? YES : NO ;          // 이동 %는 50%로 고정
    //이동하면 웨이 상태 변경
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
    [self bossEndMoving:self];
}



-(void)bossAiAttack:(int)_stage
{
    BOOL isFired = (arc4random()%10 < _stage+4 ) ? YES : NO ;   // 발사 %는 스테이지에 따라서 바뀜, 50%, 60%, 70%, 80%, 90%, 스테이지는 1,2,3,4,5로 넘어옴
    
    //발사하면 상태 변화
    if(isFired && bossState == BOSS_STATE_RUN){
        bossState = BOSS_STATE_ATTACK;

/*        
        //Obstacle 생성..
        Obstacle *tempObstacle = [[Obstacle alloc] init];
        [tempObstacle setWayState:bossWayState];
        [tempObstacle setObstacleSpr:bossItemSpr];
        [tempObstacle setSpeed:1.003];
        [tempObstacle setState:1.1];
        [tempObstacle setZ:1000.0];
        
        [[[gameLayer gameScene] movementManager] createObstacle:tempObstacle wayState:bossWayState];
        [tempObstacle release];
 */
    }    
   // [self bossDoCollisionAnimation];

    [self bossEndAttack:self];

}

@end
