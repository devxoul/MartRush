//
//  TitleLayer.h
//  MartRush
//
//  Created by Youjin Lim on 11. 10. 2..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "MenuLayer.h"

@class MenuLayer;

@interface TitleLayer : CCLayer {

    CCSprite *titleBgSprite;
    CCSprite *touchTheScreenSprite;
    
}

+ (CCScene *)scene;

@end
