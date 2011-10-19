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
    
    NSMutableArray *heartArray;
    
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
    
    CCSprite* missionAlert;
	CCLabelTTF* missionLabel;
	CCMenuItemImage* missionCheck;
	CCMenu* missionMenu;
}

@property (nonatomic, retain) GameScene *gameScene;

@property (nonatomic, retain) CCMenu *pauseMenu;
@property (nonatomic, retain) CCMenuItemImage *info;
@property (nonatomic, retain) CCMenuItemImage *pause;

-(void)update;
-(void)gaugeUpdate;
-(void)endGame:(id)sender;
-(void) heartUpdate;
-(void)missionAlertCheck:(id)sender;

@end
