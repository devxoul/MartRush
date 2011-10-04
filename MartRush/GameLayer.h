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

#ifdef MARTRUSH_BOC_EDIT
#import "Player.h"
#import "Boss.h"

@class Player;
@class Boss;
#endif

@interface GameLayer : CCLayer {
    
#ifdef MARTRUSH_BOC_EDIT
    //    GameScene *gameScene;
        
    Player* player;
    Boss* boss;
#endif
    
}

@property (nonatomic, retain) GameScene *gameScene;

- (void)update;

@end
