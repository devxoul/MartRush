//
//  GameOverScene.h
//  MartRush
//
//  Created by omniavinco on 11. 10. 11..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

#import "GameScene.h"
#import "TitleLayer.h"

@interface GameOverScene : CCLayer<CCStandardTouchDelegate> {
   
}

+(CCScene *)scene;

-(void)menuItemShop:(id)sender;

@end
