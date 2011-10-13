//
//  TutorialLayer.h
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 14..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Const.h"
#import "StageSelectLayer.h"
#import "MenuLayer.h"

@class StageSelectLayer;
@class MenuLayer;

@interface TutorialLayer : CCLayer
{
    CCSprite*  sceneSpr[TUTORIAL_MAX_SCENE];
    
    CCMenuItemImage* skip;
    CCMenuItemImage* back;
    
    int tutorialCount;
}

+(CCScene*)scene;

-(void)clickSkip:(id)sender;
-(void)clickBack:(id)back;

@end
