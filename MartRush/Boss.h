//
//  Boss.h
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Const.h"

@interface Boss : NSObject{
    
    int bossState;          //보스 상태
    int bossWayState;       //보스 도로 방향
    int bossHp;             //보스 생명
    float bossY;              //보스 y
    
    CCSprite* bossSpr;      //보스 Sprite    
    CCSprite* bossItemSpr;  //보스 item Sprite
}

@property (readwrite) int bossState;
@property (readwrite) int bossWayState;
@property (readwrite) float bossY;

-(void)update;
-(void)bossAi:(int) Stage;

@end
