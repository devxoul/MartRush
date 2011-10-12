//
//  GamePauseMenuLayer.h
//  MartRush
//
//  Created by omniavinco on 11. 10. 13..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameScene;

@interface GamePauseMenuLayer : CCLayer {
  GameScene *gameScene;
}

+ (CCLayer *)layerWithStage:(GameScene *)gameScene;

- (id)initWithStage:(GameScene *)gameScene;

@end
