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
@public
    // game state 
    NSUInteger money;
    NSMutableArray *boughtStage;
    
    // user setting value
    BOOL backSound;         // back ground sound
    BOOL vibration;         // 진동
    
    NSDictionary *stageInfo;
    NSDictionary *cartInfo;
    NSMutableArray *boughtCart;    
    NSString *lastPlayedStage;
}

@property (readwrite) NSUInteger money;
@property (readwrite) BOOL backSound;
@property (readwrite) BOOL vibration;
@property (retain, readwrite) NSString *lastPlayedStage;
@property (readonly) NSString *lastStage;
@property (readonly) NSDictionary *stageInfo;

+ (UserData *)userData;

- (BOOL)saveToFile;
- (BOOL)removeToFile;
- (BOOL)setToFile;

- (BOOL)buyStage:(NSNumber *)stage;
- (BOOL)isAvaliableStage:(NSNumber *)stage;

- (BOOL)buyCart:(NSNumber *)cart;
- (BOOL)isAvaliableCart:(NSNumber *)cart;


@end
