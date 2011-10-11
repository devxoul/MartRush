
;//
//  GameScene.m
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GameScene.h"
#import "MovementManager.h"
#import "ControlManager.h"
#import "GameLayer.h"
#import "GameUILayer.h"


@interface GameScene(Private)
- (void)initLayers;
- (void)initArrays;
- (void)initManagers;
@end


@implementation GameScene

@synthesize gameLayer, gameUILayer, merchandises, obstacles, movementManager, controlManager;

- (id)init
{
	if( self = [super init] )
	{		
		[self initLayers];
		[self initArrays];
		[self initManagers];
	}
	
	return self;
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
	[movementManager update];
    
    [gameLayer update];
}

@end
