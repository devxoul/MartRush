//
//  GameScene.h
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

//#import "MovementManager.h"
//#import "GameLayer.h"
//#import "GameUILayer.h"

@class MovementManager;
@class GameLayer;
@class GameUILayer;

@interface GameScene : CCScene {
	GameLayer *gameLayer;
	GameUILayer *gameUILayer;
	
	NSMutableArray *merchandises;
	NSMutableArray *obstacles;
	
	MovementManager *movementManager;
}

@property (nonatomic, retain) GameLayer *gameLayer;
@property (nonatomic, retain) GameUILayer *gameUILayer;

@property (nonatomic, retain) NSMutableArray *merchandises;
@property (nonatomic, retain) NSMutableArray *obstacles;

@property (nonatomic, retain) MovementManager *movementManager;

@end
