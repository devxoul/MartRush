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
    GameScene *gameScene;
    
    CCSprite *heartSprite1;
    CCSprite *heartSprite2;
    CCSprite *heartSprite3;
    
    CCSprite *backGround;
    CCSprite *gauge;
    
    CCSprite *infoButton;
    CCSprite *pauseButton;
    
    float i;
    
}

@property (nonatomic, retain) GameScene *gameScene;

-(void)update;

@end
