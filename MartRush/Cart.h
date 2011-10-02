//
//  Cart.h
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Cart : NSObject{

    NSMutableArray* itemList;     //카트 담긴 아이템
    int itemCount;                //아이템 카운트
    
    CCSprite* cartSpr;            //카트 이미지
}

-(void)update;

@end
