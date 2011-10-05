//
//  ControlManager.h
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Manager.h"

@class Merchandise;

@interface ControlManager : Manager {
  NSMutableArray *managedList;
  NSMutableArray *touchList;
  CCSprite *cartSprite;
}

- (ControlManager *)init;
- (ControlManager *)initWithCartSprite:(CCSprite *)_cartSprite;
- (bool)addMerchandiseToList:(Merchandise *)_object withTouch:(UITouch *)touch;
- (bool)moveObjectWithTouch:(UITouch *)touch;
- (bool)removeObjectWithTouch:(UITouch *)touch;

@end
