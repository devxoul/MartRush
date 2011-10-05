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
#import "Player.h"
#import "Boss.h"

@class Player;
@class Boss;

@interface GameLayer : CCLayer<CCStandardTouchDelegate> {
    GameScene *gameScene;

#ifdef MARTRUSH_BOC_EDIT
        
    Player* player;
    Boss* boss;
#endif
    
}

@property (nonatomic, retain) GameScene *gameScene;
@property (readonly) Player *player;

- (void)update;

@end
