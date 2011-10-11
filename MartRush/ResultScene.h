//
//  ResultScene.h
//  MartRush
//
//  Created by omniavinco on 11. 10. 10..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ResultScene : CCLayer<CCStandardTouchDelegate> {
  NSMutableArray *merchandiseArray;
  NSMutableArray *gottenMerchandiseArray;
}

+ (CCScene *)sceneWithMerchandises:(NSArray *)merchandises;

- (CCLayer *)initWithMerchandises:(NSArray *)merchandises;

- (void)update:(ccTime)dt;
@end

