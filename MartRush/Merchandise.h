//
//  Merchandise.h
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Merchandise : NSObject {
	CCSprite *merchandiseSpr;
	
	int wayState;
	int state;
}

@property (nonatomic, retain) CCSprite *merchandiseSpr;

@property int wayState;


@end
