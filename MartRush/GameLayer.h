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
    
#ifdef MARTRUSH_BOC_EDIT       
    Player* player;
    Boss* boss;
#endif
    
}

@property (nonatomic, retain) GameScene *gameScene;
@property (readonly) Player *player;
@property( readonly) Boss* boss;


- (void)update;
- (Cart*)getCartpointer;

@end
