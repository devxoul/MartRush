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

NSString* plistNameArray[10] = 
{
    @"player_run",
    @"player_crash",
    @"player_dead",
    @"player_leftarm",
    @"player_rightarm"
};

NSString* imgNameArray[10] = 
{
    @"player_"
};

-(void)init:(GameLayer*)_layer
{
//    playerRunAni = [self createAnimation:_layer :PLAYER_STATE_RUN :playerSpr :PLAYER_LEFT_X_POSITION :PLAYER_Y_POSITION :bachNode:6];
    [self createPlayerRunAnimation:_layer];
    
    [self setPlayerState:PLAYER_STATE_RUN];
    [self setPlayerWayState:LEFT_WAY];
    [self setPlayerY:PLAYER_Y_POSITION];
    
    playerHp = 3;
    playerCount = 0;
            
    playerCart = [Cart alloc];
    [playerCart init:_layer];
    
    [self startPlayerRunning];
}

-(void)playerSetZorder:(GameLayer*)_layer:(int)_z
{
    [_layer reorderChild:bachNode z:_z];
    [_layer reorderChild:playerCart->cartSpr z:_z-1];
}


-(void)createPlayerRunAnimation:(GameLayer*)_layer
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"player_run.plist"];
    
    playerSpr = [CCSprite spriteWithSpriteFrameName:@"player_0.png"];
    playerSpr.position = ccp(PLAYER_LEFT_X_POSITION, PLAYER_Y_POSITION);
    playerSpr.anchorPoint = ccp(0.5f, 0.0f);
    
    bachNode = [CCSpriteBatchNode batchNodeWithFile:@"player_run.png"];
    [bachNode addChild:playerSpr];
    [_layer addChild:bachNode z:2];

    NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
       
    for (int i = 0; i < 6; i++) {
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"player_%d.png", i]];
        [aniFrames addObject:frame];
    }
    
    CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.05f];
    playerRunAni = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];    
}
//
//-(CCAnimate*)createAnimation:(GameLayer*)_layer:(int)_state:(CCSprite*)_spr:(float)_x:(float)_y:(CCSpriteBatchNode*)_bnode:(int)_count
//{
//    NSString* sTemp = plistNameArray[_state];    
//    sTemp = [sTemp stringByAppendingFormat:@".plist"];
//        
//    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:sTemp];
//    
//    [sTemp init];
//    sTemp = imgNameArray[_state];
//    sTemp = [sTemp stringByAppendingFormat:@"0.png"];
//    
//    _spr = [CCSprite spriteWithSpriteFrameName:sTemp];
//    _spr.position = ccp(_x, _y);
//    
//    [sTemp init];
//    sTemp = plistNameArray[_state];
//    sTemp = [sTemp stringByAppendingFormat:@".png"];
//    
//    _bnode = [CCSpriteBatchNode batchNodeWithFile:sTemp];
//    [_bnode addChild:_spr];
//    [_layer addChild:_bnode];
//    
//    NSMutableArray *aniFrames = [NSMutableArray array];
//    
//    for (int i = 0; i < _count; i++) 
//    {
//        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"player_%d.png", i]];
//        [aniFrames addObject:frame];
//    }
//    
//    CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.05f];
//    CCAnimate* _ani = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];
//    
//    return _ani;
//}

-(void)startPlayerRunning
{
    [playerSpr runAction:[CCRepeatForever actionWithAction:playerRunAni]];
}

-(void)createPlayerStateAnimation:(GameLayer*)_layer
{
    
}

-(void)startPlayerStating:(CCAnimate*)_ani
{
    [stateSpr runAction:[CCSequence actions:_ani, nil]];
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
//            [playerSpr runAction:[CCMoveTo actionWithDuration:1 position:ccp(PLAYER_LEFT_X_POSITION, PLAYER_Y_POSITION)]];
            [playerSpr runAction:[CCSequence actions:[CCMoveTo actionWithDuration:1 position:ccp(PLAYER_LEFT_X_POSITION, PLAYER_Y_POSITION)], nil]];
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
    else if(playerState == PLAYER_STATE_DEAD)
    {
        
    }
    
    if(playerCount == 50)
//        [self playerMovingWay:RIGHT_WAY];
    
    playerCount++;
        
}

@end

