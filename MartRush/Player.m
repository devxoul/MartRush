//
//  Player.m
//  MartRush
//
//  Created by 복 & 한 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Player.h"
#import "Const.h"
#import "GameLayer.h"
#import "GameUILayer.h"
#import "BossUILayer.h"

@implementation Player

@synthesize playerState;
@synthesize playerWayState;
@synthesize playerY;
@synthesize playerHp;
@synthesize playerCart;
@synthesize playerRunDistance;
@synthesize playerSpeed;
// state 액션 구현

-(void)init:(GameLayer*)_layer{
    gamelayer = _layer;
    [self createPlayerRunAnimation];
        
    stateSpr = [[CCSprite alloc] initWithFile:@"boom.png"];
    stateSpr.anchorPoint = ccp(0.5f, 0.0f);
    [stateSpr setVisible:NO];
    
    [self setPlayerState:PLAYER_STATE_RUN];
    [self setPlayerWayState:LEFT_WAY];
    [self setPlayerY:PLAYER_Y_POSITION];
    
    playerHp = 3;
    playerCount = 0;
    playerRunDistance = 0;
    
    playerCart = [Cart alloc];
    [playerCart init:gamelayer];
    
    playerSpeed = gamelayer.gameScene.stageNumber*2 + 10 ;
    
    [self startPlayerRunning];
    [gamelayer addChild:stateSpr z:Z_ORDER_PLAYER+1];
    
}

/*
-(void)setPlayerStateCrash:(int)State{
    switch (State) {
        case PLAYER_STATE_CRASH:
            playerState = PLAYER_STATE_CRASH;
            [self createPlayerStateAnimation];
            break;
    }
}
 */

- (CGRect)playerBoundingBox
{
    return CGRectUnion([playerSpr boundingBox], [[playerCart cartSpr] boundingBox]);
}

-(void)playerSetZorder:(int)_z
{
    [gamelayer reorderChild:bachNode z:_z];
    [gamelayer reorderChild:playerCart->cartSpr z:_z-1];
}


-(void)createPlayerRunAnimation
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"player_run.plist"];
    
    playerSpr = [CCSprite spriteWithSpriteFrameName:@"player_run_0.png"];
    playerSpr.position = ccp(PLAYER_LEFT_X_POSITION, PLAYER_Y_POSITION);
    playerSpr.anchorPoint = ccp(0.5f, 0.0f);
    
    bachNode = [CCSpriteBatchNode batchNodeWithFile:@"player_run.png"];
    [bachNode addChild:playerSpr];
    [gamelayer addChild:bachNode z:Z_ORDER_PLAYER];
    
    NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 9; i++) {
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"player_run_%d.png", i]];
        [aniFrames addObject:frame];
    }
    
    CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.03f];
    playerRunAni = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];    
}


-(void)startPlayerRunning
{
    [playerSpr runAction:[CCRepeatForever actionWithAction:playerRunAni]];
}

-(void)stopPlayerRunning
{
    [playerSpr stopAllActions];
}

-(void)createPlayerStateAnimation
{
    if(playerState == PLAYER_STATE_CRASH)
    {
        [stateSpr setVisible:YES];
        playerState = PLAYER_STATE_CRASHING;

        CCCallFunc* endPlayerCrashCall = [CCCallFunc actionWithTarget:self selector:@selector(endPlayerCrash:)];
                
        stateSpr.position = ccp(playerSpr.position.x, playerSpr.position.y);
        
        [stateSpr runAction:[CCSequence actions:[CCFadeOut actionWithDuration:1] ,endPlayerCrashCall, nil]];
        playerState = PLAYER_STATE_CRASHING;
        playerHp--;
        
        switch (gamelayer.gameScene.stageType) {
            case STAGE_TYPE_NORMAL:
                [gamelayer.gameScene.gameUILayer heartUpdate];
                break;
            case STAGE_TYPE_BOSS:
                [gamelayer.gameScene.bossUILayer heartUpdate];
                break;
        }
        
        if (playerHp <= 0)
        {   
            playerState = PLAYER_STATE_DEAD;
            gamelayer.gameScene.gameState = GAME_STATE_OVER;
        }
    }
}

-(void)endPlayerCrash:(id)sender
{
    if(playerHp > 0)
        playerState = PLAYER_STATE_RUN;
}

-(void)playerMovingWay:(int)_num
{
    if (_num == LEFT_WAY) 
    {
        if(playerWayState == RIGHT_WAY)
        {
            playerWayState = LEFT_WAY;
            [playerSpr runAction:[CCEaseBackOut actionWithAction:[CCMoveTo actionWithDuration:0.3 position:ccp(PLAYER_LEFT_X_POSITION, PLAYER_Y_POSITION)]]];
            [playerCart cartMovingWay:LEFT_WAY];
        }
        else
            return;
    }
    else if(_num == RIGHT_WAY)
    {
        if(playerWayState == LEFT_WAY)
        {            
            playerWayState = RIGHT_WAY;
            [playerSpr runAction:[CCEaseBackOut actionWithAction:[CCMoveTo actionWithDuration:0.3 position:ccp(PLAYER_RIGHT_X_POSITION, PLAYER_Y_POSITION)]]];
            [playerCart cartMovingWay:RIGHT_WAY];
        }
        else
            return;
    }
}


-(void)update
{
    // 카트 이미지 Draw
    [playerCart update];
    // 플레이어 이미지 DRAW
    if(playerState == PLAYER_STATE_RUN)
    {
        
    }
    else if(playerState == PLAYER_STATE_CRASH)
    {
      [self createPlayerStateAnimation];
    }
    else if(playerState == PLAYER_STATE_DEAD)
    {
    }
    
    if(playerCount == 50)
        //        [self playerMovingWay:RIGHT_WAY];
        //        [self createPlayerStateAnimation];
//        playerState = PLAYER_STATE_DEAD;
        
        playerCount++;
    
}


@end

