
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
#import "BossUILayer.h"
#import "BonusUILayer.h"

@interface GameScene(Private)
- (void)initLayers;
- (void)initArrays;
- (void)initManagers;
@end


@implementation GameScene

@synthesize gameLayer, gameUILayer, merchandises, obstacles, movementManager, controlManager,bossUILayer;
@synthesize gameState;

- (id)init
{
	if( self = [super init] )
	{		
		[self initLayers];
		[self initArrays];
		[self initManagers];
        
        gameState = GAME_STATE_START;
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"gamebg_sound.mp3"];
	}
	
	return self;
}

- (void)initLayers
{
	gameLayer = [[GameLayer alloc] init];
	[self addChild:gameLayer];
	
	//gameUILayer = [[GameUILayer alloc] init];
	//[self addChild:gameUILayer];
    
   // bossUILayer = [[BossUILayer alloc] init];
//	[self addChild:bossUILayer];
    
    bonusUILayer = [[BonusUILayer alloc] init];
    [self addChild:bonusUILayer];

    gameLayer.gameScene = self;
    bonusUILayer.gameScene = self;
    //bossUILayer.gameScene = self;
    //gameUILayer.gameScene = self;
}

- (void)initArrays
{
	merchandises = [[NSMutableArray alloc] init];
	obstacles = [[NSMutableArray alloc] init];
}

- (void)initManagers
{
	movementManager = [[MovementManager alloc] initWithGameScene:self];
  
	controlManager = [[ControlManager alloc] initWithGameScene:self];
}

- (void)draw
{
	[super draw];

    if (gameState == GAME_STATE_START) 
    {
        [movementManager update];

        [gameLayer update];        
        //[gameUILayer update];
        //[bossUILayer update];
        [bonusUILayer update];
    }
    else if (gameState == GAME_STATE_PAUSE)
    {
        
    }
    else if (gameState == GAME_STATE_OVER)
    {
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeDown transitionWithDuration:1 scene:[GameOverScene scene]]];
//        [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeDown transitionWithDuration:0.5 scene:[GameOverScene scene]]];
//        [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:3 scene:[GameOverScene scene]]];
//        [[CCDirector sharedDirector] replaceScene:[CCTransitionRadialCCW transitionWithDuration:1 scene:[GameOverScene scene]]];  // 화면 시계 방향 전환 
//        [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:0.3 scene:[GameOverScene scene]]];
    
//        gameState = GAME_STATE_OVERING;
    }
    else if(gameState == GAME_STATE_CLEAR)
    {
      [[CCDirector sharedDirector] replaceScene:[ResultScene sceneWithMerchandises:gameLayer.player.playerCart.itemList andMission:missionDictionary]];
    }
}

-(void)dealloc
{
  [merchandises dealloc];
  [obstacles dealloc];
  [movementManager dealloc];
  [controlManager dealloc];
  
  [gameLayer dealloc];
  [gameUILayer dealloc];

  [super dealloc];
}

@end
