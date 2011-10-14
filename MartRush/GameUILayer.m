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
#import "GameLayer.h"
#import "GameOverScene.h"

@implementation GameUILayer

@synthesize gameScene;

- (id)init
{
	if( self = [super init] )
	{
    self.processedPortion = 0;
    
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
    [heartArray addObject:heart];
    
    heart = [CCSprite spriteWithFile:@"heart.png"];
    [heart setPosition:ccp(91,285)];
    [heartArray addObject:heart];
    
    for (CCSprite *heart in heartArray) {
      heart.anchorPoint = ccp(0.5f, 0.0f);
      [self addChild:heart];
    }
    
    startIcon = [CCSprite spriteWithFile:@"heart.png"];
    [startIcon setPosition:ccp(135,285)];
    startIcon.anchorPoint = ccp(0.5f, 0.0f);
    [self addChild:startIcon];
    
    endIcon = [CCSprite spriteWithFile:@"heart.png"];
    [endIcon setPosition:ccp(371,285)];
    endIcon.anchorPoint = ccp(0.5f, 0.0f);
    [self addChild:endIcon];
    
    
    info = [CCMenuItemImage itemFromNormalImage:@"cartbutton.png" selectedImage:@"cartbutton_pressed.png" block:^(id sender) {
      
    }];
    info.anchorPoint = ccp(0.5f, 0.0f);
    
    gaugeBg = [[CCSprite alloc] initWithFile:@"gaugebg.png"];
    [gaugeBg setPosition:ccp(253,294)];
    gaugeBg.anchorPoint = ccp(0.5f, 0.0f);
    [self addChild:gaugeBg];
    
    gauge = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"gauge.png"] rect:CGRectMake(0,0,0,8)];
    [gauge setPosition:ccp(155,296)];
    gauge.anchorPoint = ccp(0.0f, 0.0f);
    
    [self addChild:gauge];
    
    pause = [CCMenuItemImage itemFromNormalImage:@"pause.png" selectedImage:@"pause_pressed.png" block:^(id sender) {
      gameScene.gameState = GAME_STATE_PAUSE;
      // TODO: show pause menu
      [self addChild:[GamePauseMenuLayer layerWithStage:gameScene] z:10000];
      gameScene.gameLayer.isTouchEnabled = NO;
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

-(float)processedPortion
{
  return processedPortion;
}

- (void)setProcessedPortion:(float)processedPortion_
{
  processedPortion = processedPortion_;
  [gauge setTextureRect:CGRectMake(0, 0, processedPortion, 8)];
}

-(void) heartUpdate{
  CCFiniteTimeAction *action = [CCFadeOut actionWithDuration:0.3];
  CCSprite *heart = 0;
  if(gameScene.gameLayer.player.hp == 2){
    heart = [heartArray objectAtIndex:2];
  }  
  if(gameScene.gameLayer.player.hp == 1){
    heart = [heartArray objectAtIndex:1];
  }  
  if(gameScene.gameLayer.player.hp == 0){
    heart = [heartArray objectAtIndex:0];
    action = [CCSequence actions:action, [CCCallFunc actionWithTarget:self selector:@selector(endGame:)], nil];
  }
  if (heart) {
    [heart runAction:action];
  }
}

- (void)update{
}

-(void)endGame:(id)sender
{
  [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeDown transitionWithDuration:1 scene:[GameOverScene scene]]];
}

@end
