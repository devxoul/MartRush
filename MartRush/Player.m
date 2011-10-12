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
@synthesize playerSpeed;
@synthesize playerHp;
@synthesize playerCart;

// state 액션 구현

-(void)init:(GameLayer*)_layer
{
    gamelayer = _layer;
    [self createPlayerRunAnimation];
    
    [self setPlayerState:PLAYER_STATE_RUN];
    [self setPlayerWayState:LEFT_WAY];
    [self setPlayerY:PLAYER_Y_POSITION];
    
    playerHp = 3;
    playerCount = 0;
    
    playerCart = [Cart alloc];
    [playerCart init:gamelayer];
    
    [self startPlayerRunning];
}

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
    [gamelayer addChild:bachNode z:2];
    
    NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 6; i++) {
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"player_run_%d.png", i]];
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

-(void)createPlayerStateAnimation
{
    if(playerState == PLAYER_STATE_CRASH)
    {
        CCCallFunc* endPlayerCrash = [CCCallFunc actionWithTarget:self selector:@selector(endPlayerCrash:)];
        
        stateSpr = [[CCSprite alloc] initWithFile:@"crash_effect.png"];
        
        int _z = playerSpr.zOrder;
        [gamelayer addChild:stateSpr z:(_z) + 1];
        
        stateSpr.position = ccp(playerSpr.position.x, playerSpr.position.y + 40);
        stateSpr.anchorPoint = ccp(0.5f, 0.0f);
        
        [stateSpr runAction:[CCSequence actions:[CCFadeOut actionWithDuration:1] ,endPlayerCrash, nil]];
        playerState = PLAYER_STATE_CRASHING;
    }
}

-(void)endPlayerCrash:(id)sender
{
    if (playerHp <= 0)
        playerState = PLAYER_STATE_DEAD;
    else
    {
        playerState = PLAYER_STATE_RUN;
        playerHp--;
    }
}

-(void)playerMovingWay:(int)_num
{
    if (_num == LEFT_WAY) 
    {
        if(playerWayState == RIGHT_WAY)
        {
            playerWayState = LEFT_WAY;
            [playerSpr runAction:[CCMoveTo actionWithDuration:1 position:ccp(PLAYER_LEFT_X_POSITION, PLAYER_Y_POSITION)]];
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
            [playerSpr runAction:[CCMoveTo actionWithDuration:1 position:ccp(PLAYER_RIGHT_X_POSITION, PLAYER_Y_POSITION)]];
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

