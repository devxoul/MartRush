//
//  GameScene.h
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Const.h"
#import "GameOverScene.h"
#import "ResultScene.h"
#import "SimpleAudioEngine.h"

@class MovementManager;
@class GameLayer;
@class GameUILayer;
@class ControlManager;
@class Cart;

@interface GameScene : CCScene {
    
@public
	GameLayer *gameLayer;
	GameUILayer *gameUILayer;
	
	NSMutableArray *merchandises;
	NSMutableArray *obstacles;
	
	MovementManager *movementManager;
	ControlManager *controlManager;
  
  NSDictionary *gameInfoDictionary;
    
  NSInteger gameState;
}

@property (nonatomic, retain) GameLayer *gameLayer;
@property (nonatomic, retain) GameUILayer *gameUILayer;

@property (nonatomic, retain) NSMutableArray *merchandises;
@property (nonatomic, retain) NSMutableArray *obstacles;

@property (nonatomic, retain) MovementManager *movementManager;
@property (retain) ControlManager *controlManager;

@property (readwrite) int gameState;
@end
