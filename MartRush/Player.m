//
//  Player.m
//  MartRush
//
//  Created by 복 & 한 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Player.h"
#import "Const.h"

@implementation Player

@synthesize playerState;
@synthesize playerWayState;
@synthesize playerY;


-(void)init:(GameLayer*)_layer
{
    [self createPlayerRunAnimation:_layer];
    
    [self setPlayerState:PLAYER_STATE_RUN];
    [self setPlayerWayState:LEFT_WAY];
    [self setPlayerY:PLAYER_Y_POSITION];
    
    playerHp = 3;
    playerCount = 0;
            
    [self startPlayerRunning];
}

-(void)createPlayerRunAnimation:(GameLayer*)_layer
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"player_run.plist"];
    
    playerSpr = [CCSprite spriteWithSpriteFrameName:@"player_0.png"];
    playerSpr.position = ccp(PLAYER_LEFT_X_POSITION, PLAYER_Y_POSITION);
    playerSpr.anchorPoint = ccp(0.5f, 0.0f);
    
    CCSpriteBatchNode *bachNode = [CCSpriteBatchNode batchNodeWithFile:@"player_run.png"];
    [bachNode addChild:playerSpr];
    [_layer addChild:bachNode];

    NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
       
    for (int i = 0; i < 6; i++) {
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"player_%d.png", i]];
        [aniFrames addObject:frame];
    }
    
    CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.05f];
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


-(void)playerMovingWay:(int)_num
{
    if (_num == LEFT_WAY) 
    {
        if(playerWayState == RIGHT_WAY)
        {
            playerWayState = LEFT_WAY;
//            [playerSpr runAction:[CCMoveBy actionWithDuration:1 position:ccp(PLAYER_LEFT_X_POSITION, PLAYER_Y_POSITION)]];
            [playerSpr runAction:[CCMoveBy actionWithDuration:1 position:ccp(85, 0)]];
        }
        else
            return;
    }
    else if(_num == RIGHT_WAY)
    {
        if(playerWayState == LEFT_WAY)
        {
            playerWayState = RIGHT_WAY;
//            [playerSpr runAction:[CCMoveBy actionWithDuration:1 position:ccp(PLAYER_RIGHT_X_POSITION, PLAYER_Y_POSITION)]];
            [playerSpr runAction:[CCMoveBy actionWithDuration:1 position:ccp(PLAYER_RIGHT_X_POSITION, PLAYER_Y_POSITION)]];
        }
        else
            return;
    }
}

-(void)update
{
    // 플레이어 이미지 DRAW
            
    if(playerState == PLAYER_STATE_RUN)
    {
        
    }
    else if(playerState == PLAYER_STATE_LEFTARM_MOVE)
    {
        
    }
    else if(playerState == PLAYER_STATE_RIGHTARM_MOVE)
    {
        
    }
    else if(playerState == PLAYER_STATE_RIGHTARM_MOVE)
    {
        
    }
    else if(playerState == PLAYER_STATE_DEAD)
    {
        
    }
    
    if(playerCount == 50)
//        [self playerMovingWay:RIGHT_WAY];
    
    playerCount++;
        
}

@end

