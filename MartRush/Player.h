//
//  Player.h
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Const.h"
#import "Cart.h"

@interface Player : NSObject {
    
    int playerState;            //플레이어 상태
    int playerWayState;         //플레이어 way 방향
    int playerHp;               //플레이어 목숨
    
    float playerY;                //Y
    
    CCSprite* playerSpr;        //플레이어 Sprite
    Cart* playerCart;           //플레이어 Cart
    
}

@property (readwrite) int playerState;
@property (readwrite) int playerWayState;
@property (readwrite) float playerY;


-(void)update;

@end
