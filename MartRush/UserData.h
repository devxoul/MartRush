//
//  UserData.h
//  MartRush
//
//  Created by omniavinco on 11. 10. 13..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject
{
  NSDictionary *stageInfo;
  NSDictionary *cartInfo;
  
  // game state 
  NSUInteger money;
  NSMutableArray *boughtStage;
  NSNumber *lastPlayedStage;
  
  NSMutableArray *boughtCart;
  
  // user setting value
  BOOL backSound;         // back ground sound
  BOOL vibration;         // 진동
}

@property (readwrite) NSUInteger money;
@property (readwrite) BOOL backSound;
@property (readwrite) BOOL vibration;
@property (retain, readwrite) NSNumber *lastPlayedStage;
@property (readonly) NSString *lastStage;
@property (readonly) NSDictionary *stageInfo;

+ (UserData *)userData;

- (BOOL)saveToFile;

- (BOOL)buyStage:(NSNumber *)stage;
- (BOOL)isAvaliableStage:(NSNumber *)stage;

- (BOOL)buyCart:(NSNumber *)cart;
- (BOOL)isAvaliableCart:(NSNumber *)cart;

@end
