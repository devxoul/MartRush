//
//  StageSelectScene.m
//  MartRush
//
//  Created by omniavinco on 11. 10. 13..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "StageSelectScene.h"
#import "GameScene.h"
#import "UserData.h"
#import "SlidingMenuGrid.h"
#import "Shop.h"
#import "SimpleAudioEngine.h"
#import "MenuLayer.h"

@implementation StageSelectScene

+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];
    
    [scene addChild:[StageSelectScene node]];
    
    return scene;
}

- (id)init
{
    if (self = [super init]) {
        CCSprite *background = [CCSprite spriteWithFile:@"mainbg.png"];
        [background setPosition:CGPointMake(240, 160)];
        [self addChild:background];
        
//        CCSprite* bigAlert = [CCSprite spriteWithFile:@"big_alert.png"];
//        [bigAlert setAnchorPoint:ccp(0.5, 0.5)];
//        [bigAlert setPosition:CGPointMake(240, 160)];
//
//        [self addChild:bigAlert];
        
        stageInfoArray = [UserData userData].stageInfo;
        stageKeys = [[stageInfoArray keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [[(NSDictionary *)obj1 objectForKey:@"level"] integerValue] > [[(NSDictionary *)obj2 objectForKey:@"level"] integerValue];
        }] retain];
        
        NSMutableArray *menuArray = [NSMutableArray array];
        for (NSString *key in stageKeys) {
            NSDictionary *stageInfo = [stageInfoArray objectForKey:key];
            CCMenuItemSprite *item = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:[stageInfo objectForKey:@"icon"]]
                                                             selectedSprite:[CCSprite spriteWithFile:[stageInfo objectForKey:@"icon"]]
                                                                     target:self
                                                                   selector:@selector(selectLevel:)];
            [menuArray addObject:item];
        }

        
        SlidingMenuGrid* menu = [SlidingMenuGrid menuWithArray:menuArray cols:5 rows:1 position:CGPointMake(90, 160) padding:CGPointMake(80, 0)];
        
        [self addChild:menu z:5];
        
        moneyLabel = [[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", [UserData userData].money] fontName:@"NanumScript.ttf" fontSize:40] retain];
        
        [self addChild:moneyLabel z:20];
        
        [moneyLabel setColor:ccc3(0, 0, 0)];
        
        [moneyLabel setPosition:CGPointMake(400, 280)];
        
        CCMenu *shopButton = [CCMenu menuWithItems:[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"shop.jpg"]
                                                                           selectedSprite:[CCSprite spriteWithFile:@"shop.jpg"]
                                                                                    block:^(id sender) {
                                                                                        [[CCDirector sharedDirector] pushScene:[Shop scene]];
                                                                                    }], nil];
        
        [self addChild:shopButton z:20];
        
        [shopButton setPosition:CGPointMake(400, 300)];
        
        CCMenu *backButton = [CCMenu menuWithItems:
                              [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"back_pink.png"] selectedSprite:[CCSprite spriteWithFile:@"back_blue.png"] block:^(id sender) {
            [[CCDirector sharedDirector] pushScene:[CCTransitionSlideInL transitionWithDuration:0.3 scene:[MenuLayer scene]]];
        }], nil];
        
        [backButton setPosition:CGPointMake(30, 295)];
        
        [self addChild:backButton z:20];
        
        return self;
    }
    
    return nil;
}

- (void)selectLevel:(id)sender
{
	
    if ([[UserData userData] isAvaliableStage:[[stageInfoArray objectForKey:[stageKeys objectAtIndex:[sender tag] - 1]] objectForKey:@"level"]]) {
//        [UserData userData].lastPlayedStage = [[stageInfoArray objectForKey:[stageKeys objectAtIndex:[sender tag] - 1]] objectForKey:@"level"];
		[UserData userData].lastPlayedStage = [stageKeys objectAtIndex:[sender tag] - 1];
        
        if ([UserData userData].backSound)
            [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
        
        [[CCDirector sharedDirector] pushScene:[CCTransitionSlideInL transitionWithDuration:0.3 scene:[[[GameScene alloc]init] autorelease]]];
    }
    else
    {
        // TODO: buyStage?
        if ([[UserData userData] buyStage:[[stageInfoArray objectForKey:[stageKeys objectAtIndex:[sender tag] - 1]] objectForKey:@"level"]]) {
            
            // Success
            if ([UserData userData].backSound)
                [[SimpleAudioEngine sharedEngine] playEffect:@"unlock.mp3"];

            [moneyLabel setString:[NSString stringWithFormat:@"%d", [UserData userData].money]];
        }
        
    }
}

-(void)dealloc
{
  [stageInfoArray release];
  stageInfoArray = nil;
  
  [stageKeys release];
  stageKeys = nil;
  
  [super dealloc];
}

@end
