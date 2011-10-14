//
//  UserData.m
//  MartRush
//
//  Created by omniavinco on 11. 10. 13..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import "UserData.h"

@implementation UserData

@synthesize money, lastPlayedStage, vibration, backSound;

+ (UserData *)userData
{
    static UserData *ret;
    
    if (!ret)
    {
        ret = [[UserData alloc] init];
    }
    
    return ret;
}

- (id)init
{
    if (self = [super init])
    {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[(NSString *)[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"UserData.plist"]];
        
        money = [[dict objectForKey:@"money"] integerValue];
        
        if (!money) {
            money = 0;
        }
        
        boughtStage = [dict objectForKey:@"stages"];
        
        if (!boughtStage) {
            boughtStage = [NSMutableArray array];
        }
        
        [boughtStage retain];
        
        backSound = [[dict objectForKey:@"sound"] boolValue];
        if (!backSound) {
            backSound = YES;
        }
        
        vibration = [[dict objectForKey:@"vibration"] boolValue];
        if (!vibration) {
            vibration = YES;
        }
        
        
        boughtStage = [dict objectForKey:@"stages"];
        
        if (!boughtStage) {
            boughtStage = [NSMutableArray arrayWithObjects:@"fruit_1", nil];
        }
        
        [boughtStage retain];
        
        return self;
    }
    
    return nil;
}

- (BOOL)saveToFile
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[NSNumber numberWithInteger:money] forKey:@"money"];    
    
    return [dict writeToFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] pathForResource:@"UserData" ofType:@"plist"] atomically:YES];
}

- (BOOL)buyStage:(NSString *)stage
{
    NSInteger price = [[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StageList" ofType:@"plist"]] objectForKey:stage] integerValue];
    if (price <= money)
    {
        money -= price;
        [boughtStage addObject:stage];
        [self saveToFile];
        return YES;
    }
    
    return NO;
}

- (BOOL)isAvaliableStage:(NSString *)stage
{
    return ([boughtStage indexOfObject:stage] != NSNotFound);
}

- (void)dealloc
{
    [boughtStage dealloc];
    [super dealloc];
}

@end
