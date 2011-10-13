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
}

@property (nonatomic, retain) GameScene *gameScene;

@property (readwrite) float processedPortion;

-(void)changePlayerHp:(NSInteger)hp;

-(void)update;

@end
