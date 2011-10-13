
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

@synthesize gameLayer, gameUILayer, merchandises, obstacles, movementManager, controlManager,bossUILayer, bonusUILayer;
@synthesize gameState, stageNumber, stageType;


-(id)init
{
	if( self = [super init] )
	{		
        [self init:1 :1];
	}
	
	return self;


}
- (void)init:(int)_stageType:(int)_stageNumber
{
    stageType = _stageType;
    stageNumber = _stageNumber;
    
    [self initLayers];
    [self initArrays];
    [self initManagers];
    
    gameState = GAME_STATE_START;
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"gamebg_sound.mp3"];
}

- (void)initLayers
{
	gameLayer = [[GameLayer alloc] init];
	[self addChild:gameLayer];
	
    switch (stageType) {
        case STAGE_TYPE_NORMAL:
            gameUILayer = [[GameUILayer alloc] init];
            gameUILayer.gameScene = self;
            [self addChild:gameUILayer];
            break;
        case STAGE_TYPE_BOSS:
            bossUILayer = [[BossUILayer alloc] init];
            bossUILayer.gameScene = self;
            [self addChild:bossUILayer];
            break;
        case STAGE_TYPE_BONUS:
            bonusUILayer = [[BonusUILayer alloc] init];
            bonusUILayer.gameScene = self;
            [self addChild:bonusUILayer];
            break;
    }
	

    gameLayer.gameScene = self;

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
        
        
        switch (stageType) {
            case STAGE_TYPE_NORMAL:
                [gameUILayer update];
                break;
            case STAGE_TYPE_BOSS:
                [bossUILayer update];
                break;
            case STAGE_TYPE_BONUS:
                [bonusUILayer update];
                break;
        }
        
    }
    
    else if (gameState == GAME_STATE_PAUSE)
    {
        switch (stageType) {
            case STAGE_TYPE_NORMAL:
                [gameUILayer update];
                break;
            case STAGE_TYPE_BOSS:
                [bossUILayer update];
                break;
            case STAGE_TYPE_BONUS:
                [bonusUILayer update];
                break;
        }

    }
    else if (gameState == GAME_STATE_OVER)
    {
      //  [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeDown transitionWithDuration:1 scene:[GameOverScene scene]]];
//        [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeDown transitionWithDuration:0.5 scene:[GameOverScene scene]]];
//        [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:3 scene:[GameOverScene scene]]];
//        [[CCDirector sharedDirector] replaceScene:[CCTransitionRadialCCW transitionWithDuration:1 scene:[GameOverScene scene]]];  // 화면 시계 방향 전환 
//        [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:0.3 scene:[GameOverScene scene]]];
    
//        gameState = GAME_STATE_OVERING;
        
        switch (stageType) {
            case STAGE_TYPE_NORMAL:
                [gameUILayer update];
                break;
            case STAGE_TYPE_BOSS:
                [bossUILayer update];
                break;
            case STAGE_TYPE_BONUS:
                [bonusUILayer update];
                break;
        }
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
