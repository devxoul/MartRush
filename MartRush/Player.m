//
//  Player.m
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Player.h"
#import "Const.h"

@implementation Player

@synthesize playerState;
@synthesize playerWayState;
@synthesize playerY;

-(id)init
{
    self = [super init];
    
    if (self) {
        // Initialization code here.
        playerSpr = [[CCSprite alloc] initWithFile:@"player.png"];
        playerSpr.position = ccp(60,20);
        playerSpr.anchorPoint = ccp(0.5f, 0.0f);
        
        [self setPlayerState:PLAYER_STATE_RUN];
        [self setPlayerWayState:LEFT_WAY];
        [self setPlayerY:PLAYER_Y_POSITION];

        playerHp = 3;                
    }
    
    return self;
}

-(void)update
{
    // 플레이어 이미지 DRAW
    
    if(playerState == PLAYER_STATE_RUN)
    {
        
    }
    
}

@end
