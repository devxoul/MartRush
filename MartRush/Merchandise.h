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
	
	NSInteger wayState;
	
	float z_;
	
	NSString *name;
	NSInteger price;
}

@property (nonatomic, retain) CCSprite *merchandiseSpr;

@property NSInteger wayState;
@property (nonatomic) float z;

@property (nonatomic, retain) NSString *name;
@property NSInteger price;

- (id)initWithName:(NSString *)name andSprite:(CCSprite *)sprite andWay:(NSInteger)way andPrice:(NSInteger)price_ andZ:(float)z;

@end
