//
//  TitleLayer.h
//  MartRush
//
//  Created by Youjin Lim on 11. 10. 2..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class MenuLayer;

@interface TitleLayer : CCLayer {
    
    CCSprite *titleBgSprite;        // 연한 백
    CCSprite *titleBgSprite2;       // 진한 백
    CCSprite *titleBack;            // 마트 안에 백

    CCSprite *titleLogo;            // 마트 러쉬 로고
    CCSprite *titleLine[2];           // 자동문
    
    CCSprite *touchTheScreenSprite;     // 터치더 스크린 없어져요
}

+ (CCScene *)scene;

@end
