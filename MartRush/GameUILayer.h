//
//  GameUILayer.h
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameLayer.h"

@class GameScene;

@interface GameUILayer : CCLayer {
    
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

}

@property (nonatomic, retain) GameScene *gameScene;

@property (readwrite) float processedPortion;

-(void) update;
-(void) endGame:(id)sender;
-(void) heartUpdate;

@end
