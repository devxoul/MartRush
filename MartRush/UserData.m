//
//  UserData.m
//  MartRush
//
//  Created by omniavinco on 11. 10. 13..
//  Copyright (c) 2011년 Joyfl. All rights reserved.
//

#import "UserData.h"

@implementation UserData

@synthesize money, lastPlayedStage, vibration, backSound, stageInfo;

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
		
        
        backSound = [[dict objectForKey:@"sound"] boolValue];        
        vibration = [[dict objectForKey:@"vibration"] boolValue];
        
        boughtStage = [dict objectForKey:@"stages"];
        
        if (!boughtStage) {
            boughtStage = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], nil];
        }
        
        [boughtStage retain];
        
        stageInfo = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StageList" ofType:@"plist"]] retain];
        
        cartInfo = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CartList" ofType:@"plist"]] retain];
        
        boughtCart = [dict objectForKey:@"cart"];
        
        if (!boughtCart) {
            boughtCart = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], nil];
        }
        
        [boughtCart retain];
        
        return self;
    }
    
    return nil;
}

- (BOOL)saveToFile
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[NSNumber numberWithInteger:money] forKey:@"money"];
    [dict setObject:[NSNumber numberWithBool:backSound] forKey:@"sound"];
    [dict setObject:[NSNumber numberWithBool:vibration] forKey:@"vibration"];
    [dict setObject:boughtStage forKey:@"stages"];
    [dict setObject:boughtCart forKey:@"cart"];
    
    return [dict writeToFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"UserData.plist"] atomically:YES];
}

- (BOOL)setToFile
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[NSNumber numberWithBool:backSound] forKey:@"sound"];
    [dict setObject:[NSNumber numberWithBool:vibration] forKey:@"vibration"];
    
    return [dict writeToFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"UserData.plist"] atomically:YES];    
}

- (BOOL)removeToFile
{
    NSString* path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] 
                      stringByAppendingFormat:@"/UserData.plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        return YES;
    }
    else
    {        
        money = 0;
        boughtStage = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], nil];
        stageInfo = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StageList" ofType:@"plist"]] retain];
        cartInfo = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CartList" ofType:@"plist"]] retain];
        boughtCart = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], nil];
        
        return YES;
    }
    
    return NO;
}

- (BOOL)buyStage:(NSNumber *)stage
{
    NSInteger price = -1;
    for (NSString *key in stageInfo) 
    {
        if ([[[stageInfo objectForKey:key] objectForKey:@"level"] integerValue] == [stage integerValue])
        {
            price = [[[stageInfo objectForKey:key] objectForKey:@"value"] integerValue];
        }
    }
    
    if (price <= money)
    {
        money -= price;
        [boughtStage addObject:stage];
        [self saveToFile];
        return YES;
    }
    
    return NO;
}

- (BOOL)isAvaliableStage:(NSNumber *)stage
{
    return ([boughtStage indexOfObjectIdenticalTo:stage] != NSNotFound);
}

- (NSString *)lastStage
{
    for (NSString *key in [stageInfo allKeys]) {
        if ([[[stageInfo objectForKey:key] objectForKey:@"level"] integerValue] == [lastPlayedStage integerValue])
        {
            return key;
        }
    }
    return nil;
}

- (BOOL)buyCart:(NSNumber *)cart
{
    NSInteger price = -1;
    for (NSString *key in stageInfo) {
        if ([[[cartInfo objectForKey:key] objectForKey:@"level"] integerValue] == [cart integerValue])
        {
            price = [[[cartInfo objectForKey:key] objectForKey:@"value"] integerValue];
        }
    }
    if (price <= money)
    {
        money -= price;
        [boughtCart addObject:cart];
        [self saveToFile];
        return YES;
    }
    
    return NO;
}


- (BOOL)isAvaliableCart:(NSNumber *)cart
{
    return ([boughtCart indexOfObjectIdenticalTo:cart] != NSNotFound);
}

- (void)dealloc
{
    [boughtStage dealloc];
    [super dealloc];
}

@end
