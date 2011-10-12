//
//  BossUILayer.h
//  MartRush
//
//  Created by Han Sanghoon on 11. 10. 12..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"

@interface BossUILayer : CCLayer{

    GameScene *gameScene;
    
    CCSprite *backGround;
    
    CCSprite *heartSprite1;
    CCSprite *heartSprite2;
    CCSprite *heartSprite3;
    
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

@property (nonatomic, retain) CCMenu *pauseMenu;
@property (nonatomic, retain) CCMenuItemImage *info;
@property (nonatomic, retain) CCMenuItemImage *pause;

-(void)update;
-(void) gaugeUpdate;


@end
