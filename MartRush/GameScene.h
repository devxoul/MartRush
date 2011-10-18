//
//  GameScene.h
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class MovementManager;
@class GameLayer;
@class GameUILayer;
@class ControlManager;
@class Cart;
@class BossUILayer;
@class BonusUILayer;

@interface GameScene : CCScene {
	
@public
	GameLayer *gameLayer;
	GameUILayer *gameUILayer;
	BossUILayer *bossUILayer;
	BonusUILayer *bonusUILayer;
	NSMutableArray *merchandises;
	NSMutableArray *obstacles;
	
	MovementManager *movementManager;
	ControlManager *controlManager;
	
	NSMutableDictionary *gameInfoDictionary;
	
	NSInteger gameState;
	NSInteger stageType;
	NSInteger stageLevel;
	
	NSInteger count;
	CCLabelTTF *label;
}

@property (nonatomic, retain) GameLayer *gameLayer;
@property (nonatomic, retain) GameUILayer *gameUILayer;
@property (nonatomic, retain) BossUILayer *bossUILayer;
@property (nonatomic, retain) BonusUILayer *bonusUILayer;

@property (nonatomic, retain) NSMutableArray *merchandises;
@property (nonatomic, retain) NSMutableArray *obstacles;

@property (nonatomic, retain) MovementManager *movementManager;
@property (retain) ControlManager *controlManager;

@property (readwrite) NSInteger gameState;

@property (readwrite) NSInteger stageType;
@property (readwrite) NSInteger stageLevel;

@property (nonatomic, retain) NSMutableDictionary *gameInfoDictionary;

@end
