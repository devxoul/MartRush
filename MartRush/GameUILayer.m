//
//  GameUILayer.m
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GameUILayer.h"
#import "GameScene.h"
#import "Player.h"
#import "GamePauseMenuLayer.h"

@implementation GameUILayer

@synthesize gameScene;

- (id)init
{
	if( self = [super init] )
	{
    processedPortion = 0;
    
    backGround = [CCSprite spriteWithFile:@"uilayer_bg.png"];
    [backGround setPosition:ccp(240,280)];
    backGround.anchorPoint = ccp(0.5f, 0.0f);
    [self addChild:backGround];
    
    heartArray = [[NSMutableArray alloc] init];
    
    CCSprite *heart = [CCSprite spriteWithFile:@"heart.png"];
    [heart setPosition:ccp(25,285)];
    [heartArray addObject:heart];
    
    heart = [CCSprite spriteWithFile:@"heart.png"];
    [heart setPosition:ccp(58,285)];
    [heartArray addObject:[heart autorelease]];
    
    heart = [CCSprite spriteWithFile:@"heart.png"];
    [heart setPosition:ccp(91,285)];
    [heartArray addObject:[heart autorelease]];
    
    for (CCSprite *heart in heartArray) {
      heart.anchorPoint = ccp(0.5f, 0.0f);
      [self addChild:heart];
    }
 
    startIcon = [CCSprite spriteWithFile:@"heart.png"];
    [startIcon setPosition:ccp(135,285)];
    startIcon.anchorPoint = ccp(0.5f, 0.0f);
    [self addChild:startIcon];
    
    gauge = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"gauge.png"] rect:CGRectMake(0,0,0,30)];
    [gauge setPosition:ccp(153,285)];
    gauge.anchorPoint = ccp(0.0f, 0.0f);
    
    [self addChild:gauge];
    
    endIcon = [CCSprite spriteWithFile:@"heart.png"];
    [endIcon setPosition:ccp(371,285)];
    endIcon.anchorPoint = ccp(0.5f, 0.0f);
    [self addChild:endIcon];

    
    info = [CCMenuItemImage itemFromNormalImage:@"cartbutton.png" selectedImage:@"cartbutton_pressed.png" block:^(id sender) {
      
    }];
    info.anchorPoint = ccp(0.5f, 0.0f);

    pause = [CCMenuItemImage itemFromNormalImage:@"pause.png" selectedImage:@"pause_pressed.png" block:^(id sender) {
      gameScene.gameState = GAME_STATE_PAUSE;
      // TODO: show pause menu
      [self addChild:[GamePauseMenuLayer node] z:10000];
    }];
    pause.anchorPoint = ccp(0.5f, 0.0f);        
    
    pauseMenu = [CCMenu menuWithItems:pause, info, nil];
    pauseMenu.anchorPoint = ccp(0.5f, 0.0f);
    
    [pauseMenu setPosition:ccp(0,0)];
    [info setPosition:ccp(415,285)];
    [pause setPosition:ccp(455,285)];

    [self addChild:pauseMenu];
    
    return self;
  }
	
	return nil;
}

-(void)changePlayerHp:(NSInteger)hp
{
  for (CCSprite *heart in heartArray) {
    if (hp > 0) {
      heart.opacity = 255;
    }
    else
    {
      heart.opacity = 0;
    }
    hp--;
  }

}

-(float)processedPortion
{
  return processedPortion;
}

- (void)setProcessedPortion:(float)processedPortion_
{
  processedPortion = processedPortion_;
  [gauge setTextureRect:CGRectMake(0, 0, processedPortion, 30)];
}

- (void)update{
  [self changePlayerHp:gameScene.gameLayer.player.hp];
}

@end
