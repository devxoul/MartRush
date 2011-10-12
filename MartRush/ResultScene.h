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
  NSMutableArray *gottenMerchandiseArray;
  NSMutableDictionary *missionDictionary;
  
  CCLabelTTF *numberOfCorrectLabel;
  CCLabelTTF *numberOfMiscorrectLabel;
  CCLabelTTF *compensationLabel;
  
  NSUInteger numberOfCorrect;
  NSUInteger numberOfMiscorrect;
  NSUInteger compensation;
}

+ (CCScene *)sceneWithMerchandises:(NSArray *)merchandises andMission:(NSDictionary *)mission;

- (CCLayer *)initWithMerchandises:(NSArray *)merchandises andMission:(NSDictionary *)mission;

- (void)update:(ccTime)dt;
@end

