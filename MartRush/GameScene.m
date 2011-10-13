
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
#import "UserData.h"
#import "BossUILayer.h"
#import "BonusUILayer.h"

@interface GameScene(Private)
- (void)initLayers;
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
    merchandises = [[NSMutableArray alloc] init];
    obstacles = [[NSMutableArray alloc] init];
    
    [self initLayers];
    
    gameState = GAME_STATE_START;
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"gamebg_sound.mp3"];
    
    gameInfoDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[UserData userData].lastPlayedStage ofType:@"plist"]];
    
    [self initManagers];

    
    return self;
	}
	
	return nil;
}

- (void)init:(int)_stageType:(int)_stageNumber
{
    stageType = _stageType;
    stageNumber = _stageNumber;
    
    [self initLayers];
    //[self initArrays];
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
