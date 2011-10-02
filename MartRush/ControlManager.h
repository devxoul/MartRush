//
//  ControlManager.h
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ControlManager : NSObject {
  NSMutableArray *managedList;
  CCSprite *cartSprite;
}

- (ControlManager *)initWithCartSprite:(CCSprite *)_cartSprite;
- (void)addObjectToList:(CCSprite *)_object;
- (void)moveObjectWithIndex:(NSUInteger)index ToPosition:(CGPoint)position;
- (void)removeObjectFromList:(NSUInteger)index;

@end
