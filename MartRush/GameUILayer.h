//
//  GameUILayer.h
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "GameScene.h"

@interface GameUILayer : CCLayer {
    GameScene *gameScene;
}

@property (nonatomic, retain, readonly) GameScene *gameScene;

@end
