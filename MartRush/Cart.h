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
    int itemCount;                //아이템 카운트
    
    CCSprite* cartSpr;            //카트 이미지
}

@property (nonatomic, retain) NSMutableArray* itemList;

-(void)init:(GameLayer*)_layer;
-(void)update;

-(void)cartMovingWay:(int)_num;             //카트 길 이동
-(void)cartItemAdd:(Merchandise*)_item;     //카트 아이템 추가

@end
