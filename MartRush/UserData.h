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
    // game state 
    NSUInteger money;
    NSMutableArray *boughtStage;
    NSString *lastPlayedStage;
    
    // user setting value
    BOOL backSound;         // back ground sound
    BOOL vibration;         // 진동

}

@property (readwrite) NSUInteger money;
@property (readwrite) BOOL backSound;
@property (readwrite) BOOL vibration;
@property (retain, readwrite) NSString *lastPlayedStage;

+ (UserData *)userData;

- (BOOL)saveToFile;

- (BOOL)buyStage:(NSString *)stage;
- (BOOL)isAvaliableStage:(NSString *)stage;

@end
