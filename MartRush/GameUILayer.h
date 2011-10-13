//
//  GameUILayer.h
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameScene;

@interface GameUILayer : CCLayer {
<<<<<<< HEAD
  GameScene *gameScene;
  
  CCSprite *backGround;
    
  NSMutableArray *heartArray;
  
  CCSprite *gauge;
  
  CCSprite *infoButton;
  CCSprite *pauseButton;

  CCSprite *startIcon;
  CCSprite *endIcon;
  
  float processedPortion;
  
  CCMenu *pauseMenu;
  
  CCMenuItemImage *info;
  CCMenuItemImage *pause;
=======
    
  NSMutableArray *heartArray;
  
	float processedPortion;
	GameScene *gameScene;

	CCSprite *backGround;

	CCSprite *gaugeBg;
	CCSprite *gauge;

	CCSprite *infoButton;
	CCSprite *pauseButton;

	CCSprite *startIcon;
	CCSprite *endIcon;

	float i;

	CCMenu *pauseMenu;

	CCMenuItemImage *info;
	CCMenuItemImage *pause;

>>>>>>> 90875aae98f1da45960a46120cd60e654ba894c8
}

@property (nonatomic, retain) GameScene *gameScene;

@property (readwrite) float processedPortion;
<<<<<<< HEAD

-(void)changePlayerHp:(NSInteger)hp;
=======
>>>>>>> 90875aae98f1da45960a46120cd60e654ba894c8

-(void) update;
-(void) endGame:(id)sender;
-(void) heartUpdate;

@end
