//
//  Cart.h
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Const.h"
#import "Merchandise.h"

@class GameLayer;
@class Merchandise;

@interface Cart : NSObject{
@public
    NSMutableArray* itemList;     //카트 담긴 아이템
    
    CCSprite* cartSpr;            //카트 이미지
    NSInteger cartHp;                   //카트 체력
}

@property (retain, readonly) NSMutableArray* itemList;
@property (readwrite) NSInteger cartHp;
@property (readwrite) NSInteger wayState;

#ifdef MARTRUSH_HAN_EDIT
@property (readonly) CCSprite* cartSpr;
#endif

-(id)init:(GameLayer*)_layer;
-(void)update;

-(void)cartItemAdd:(Merchandise*)_item;     //카트 아이템 추가

@end
