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
  NSUInteger money;
  
  NSMutableArray *boughtStage;
}

@property (readwrite) NSUInteger money;

+ (UserData *)userData;

- (BOOL)saveToFile;

- (BOOL)buyStage:(NSString *)stage;

- (BOOL)isAvaliableStage:(NSString *)stage;

@end
