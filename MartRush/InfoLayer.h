//
//  InfoLayer.h
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 14..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

@class MenuLayer;
@class UserData;

@interface InfoLayer : CCLayer
{
  CCSprite* infoBg;
}

+(CCScene*) scene;
-(void)moveBack:(id)sender;

@end
