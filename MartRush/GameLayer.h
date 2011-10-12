//
//  GameLayer.h
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "GameScene.h"

@class Player;
@class Boss;
@class Cart;

@interface GameLayer : CCLayer<CCStandardTouchDelegate> {
  GameScene *gameScene;
  
  Player* player;
  Boss* boss;
}

@property (nonatomic, retain) GameScene *gameScene;
@property (readonly) Player *player;

- (void)update;
- (Cart*)getCartpointer;

@end
