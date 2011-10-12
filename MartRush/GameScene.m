
//  GameScene.m
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GameScene.h"
#import "MovementManager.h"
#import "ControlManager.h"
#import "Player.h"
#import "GameLayer.h"
#import "GameUILayer.h"
#import "ResultScene.h"


@interface GameScene(Private)
- (void)initLayers;
- (void)initManagers;
@end


@implementation GameScene

@synthesize gameLayer, gameUILayer, merchandises, obstacles, movementManager, controlManager;
@synthesize gameState;

-(id)init
{
  if( self = [super init] )
	{		
    merchandises = [[NSMutableArray alloc] init];
    obstacles = [[NSMutableArray alloc] init];
    
    [self initLayers];
    
    gameState = GAME_STATE_START;
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"gamebg_sound.mp3"];
    
    return self;
	}
	
	return nil;
}

- (id)initWithMissionName:(NSString *)missionName
{
	if (self = [self init]) {
    gameInfoDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:missionName ofType:@"plist"]];
    
    [self initManagers];
    
    return self;
  }
  return nil;
}

- (void)initLayers
{
	gameLayer = [[GameLayer alloc] init];
	[self addChild:gameLayer];
	
	gameUILayer = [[GameUILayer alloc] init];
	[self addChild:gameUILayer];
  
  gameLayer.gameScene = self;
  gameUILayer.gameScene = self;
}

- (void)initManagers
{
	movementManager = [[MovementManager alloc] initWithGameScene:self andGameInfo:gameInfoDictionary];
  
	controlManager = [[ControlManager alloc] initWithGameScene:self];
}

- (void)draw
{
	[super draw];

  if (gameState == GAME_STATE_START) 
  {
    [movementManager update];

    [gameLayer update];    
    gameUILayer.processedPortion += 1.0f / [[gameInfoDictionary objectForKey:@"length"] intValue] * 200;
    [gameUILayer update];
    if (gameUILayer.processedPortion >= 200) {
      gameState = GAME_STATE_CLEAR;
    }
  }
  else if (gameState == GAME_STATE_PAUSE)
  {
    
  }
  else if (gameState == GAME_STATE_OVER)
  {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeDown transitionWithDuration:1 scene:[GameOverScene scene]]];
  }
  else if(gameState == GAME_STATE_CLEAR)
  {
    [[CCDirector sharedDirector] replaceScene:[ResultScene sceneWithMerchandises:gameLayer.player.cart.itemList andMission:[gameInfoDictionary objectForKey:@"mission"]]];
  }
}

-(void)dealloc
{
  [merchandises dealloc];
  [obstacles dealloc];
  [gameInfoDictionary dealloc];
  
  [movementManager dealloc];
  [controlManager dealloc];
  
  [gameLayer dealloc];
  [gameUILayer dealloc];

  [super dealloc];
}

@end
