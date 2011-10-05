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
}

@property (nonatomic, retain) GameScene *gameScene;

@end
