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

#define STAGE_BUY			0
#define STAGE_BUY_POPUP		1

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
		
		buyState = STAGE_BUY;
		
		buyLayer = [[CCLayer alloc] init];
		[self addChild:buyLayer z:30];
		
		buyLayer.visible = NO;
		
        stageInfoArray = [UserData userData].stageInfo;
        stageKeys = [[stageInfoArray keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [[(NSDictionary *)obj1 objectForKey:@"level"] integerValue] > [[(NSDictionary *)obj2 objectForKey:@"level"] integerValue];
        }] retain];
        
        menuArray = [NSMutableArray array];
		
		for (NSString *key in stageKeys) {
            NSDictionary *stageInfo = [stageInfoArray objectForKey:key];
			
			if ([[UserData userData] isAvaliableStage:[stageInfo objectForKey:@"level"]]) 
			{
				 item = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:[stageInfo objectForKey:@"icon"]]
																 selectedSprite:[CCSprite spriteWithFile:[stageInfo objectForKey:@"icon"]]
																		 target:self
																	   selector:@selector(selectLevel:)];				
			}
			else
			{
				if([[stageInfo objectForKey:@"level"] integerValue] == 1)
				{
					item = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:[stageInfo objectForKey:@"icon"]]
																	 selectedSprite:[CCSprite spriteWithFile:[stageInfo objectForKey:@"icon"]]
																			 target:self
																		   selector:@selector(selectLevel:)];				
				}
				else
				{
					item = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:[stageInfo objectForKey:@"bought"]]
																	 selectedSprite:[CCSprite spriteWithFile:[stageInfo objectForKey:@"bought"]]
																			 target:self
																		   selector:@selector(selectLevel:)];
					
				}
			}
			
			[menuArray addObject:item];
        }
		
        
        menu = [SlidingMenuGrid menuWithArray:menuArray cols:5 rows:1 position:CGPointMake(90, 160) padding:CGPointMake(80, 0)];
        
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
		
		buyAlert = [CCSprite spriteWithFile:@"small_alert.png"];
		[buyAlert setAnchorPoint:ccp(0.5, 0.5)];
		[buyAlert setPosition:ccp(240, 160)];
		
		[buyLayer addChild:buyAlert z:6];					
		
		buylab = [CCLabelTTF labelWithString:@"Would you like to open?" fontName:@"NanumScript.ttf" fontSize:24];
		buylab.color = ccBLACK;
		buylab.anchorPoint = ccp(0.5, 0.5);
		buylab.position = ccp(245, 190);
		[buyLayer addChild:buylab z:7];			
		
		buyValue = [CCLabelTTF labelWithString:@" " fontName:@"NanumScript.ttf" fontSize:24];
		buyValue.color = ccBLACK;
		[buyValue setAnchorPoint:ccp(0.5, 0.0)];
		[buyValue setPosition:ccp(240, 150)];
		[buyLayer addChild:buyValue z:7];
		
		
		buyYes = [CCMenuItemImage itemFromNormalImage:@"btn_yes.png" selectedImage:@"btn_yes.png" block:^(id sender) {
			// TODO: buyStage?
			if ([[UserData userData] buyStage:selectStage]) 
			{
				// Success
				if ([UserData userData].backSound)
					[[SimpleAudioEngine sharedEngine] playEffect:@"unlock.mp3"];
				
				[moneyLabel setString:[NSString stringWithFormat:@"%d", [UserData userData].money]];
				buyLayer.visible = NO;
				buyState = STAGE_BUY;
				
				menuArray = nil;
				
				[self removeChild:menu cleanup:YES];
				menu = nil;
				[menu dealloc];
				
				menuArray = [NSMutableArray array];

				stageInfoArray = [UserData userData].stageInfo;
				stageKeys = [[stageInfoArray keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
					return [[(NSDictionary *)obj1 objectForKey:@"level"] integerValue] > [[(NSDictionary *)obj2 objectForKey:@"level"] integerValue];
				}] retain];

				
				for (NSString *key in stageKeys) {
					NSDictionary *stageInfo = [stageInfoArray objectForKey:key];
					
					if ([[UserData userData] isAvaliableStage:[stageInfo objectForKey:@"level"]]) 
					{
						item = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:[stageInfo objectForKey:@"icon"]]
													   selectedSprite:[CCSprite spriteWithFile:[stageInfo objectForKey:@"icon"]]
															   target:self
															 selector:@selector(selectLevel:)];				
					}
					else
					{
						if([[stageInfo objectForKey:@"level"] integerValue] == 1)
						{
							item = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:[stageInfo objectForKey:@"icon"]]
														   selectedSprite:[CCSprite spriteWithFile:[stageInfo objectForKey:@"icon"]]
																   target:self
																 selector:@selector(selectLevel:)];				
						}
						else
						{
							item = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:[stageInfo objectForKey:@"bought"]]
														   selectedSprite:[CCSprite spriteWithFile:[stageInfo objectForKey:@"bought"]]
																   target:self
																 selector:@selector(selectLevel:)];
							
						}						
					}
					
					[menuArray addObject:item];
				}
				
				menu = [SlidingMenuGrid menuWithArray:menuArray cols:5 rows:1 position:CGPointMake(90, 160) padding:CGPointMake(80, 0)];
				[self addChild:menu z:5];
			}
			else
			{
				if ([UserData userData].backSound)
					[[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];

				buyYes.visible = NO;
				buyNO.visible = NO;
				menuBuy.visible = NO;
				buyValue.visible = NO;
				
				[buylab setString:@"you need money."];
				buylab.color = ccBLACK;
				buylab.anchorPoint = ccp(0.5, 0.5);
				buylab.position = ccp(245, 190);
				
				cashNO = [CCMenuItemImage itemFromNormalImage:@"btn_yes.png" selectedImage:@"btn_yes.png" block:^(id sender) {
					
					buyLayer.visible = NO;
					buyState = STAGE_BUY;
					
					cashNO.visible = NO;
					cashMenu.visible = NO;
					
					if ([UserData userData].backSound)
						[[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
				}];	
				
				cashNO.anchorPoint = ccp(0.5, 0.0);
				cashNO.position = ccp(240, 100);
				
				cashMenu = [CCMenu menuWithItems:cashNO, nil];
				cashMenu.anchorPoint = CGPointZero;
				cashMenu.position = CGPointZero;
				
				[buyLayer addChild:cashMenu z:8];
			}
		}];		
		buyYes.anchorPoint = CGPointZero;
		buyYes.position = ccp(120, 100);
		
		buyNO = [CCMenuItemImage itemFromNormalImage:@"btn_no.png" selectedImage:@"btn_no.png" block:^(id sender) {			
			
			buyState = STAGE_BUY;
			buyLayer.visible = NO;
			
			if ([UserData userData].backSound)
				[[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
		}];
		buyNO.anchorPoint = CGPointZero;
		buyNO.position = ccp(260, 100);
		
		menuBuy = [CCMenu menuWithItems:buyNO, buyYes, nil];
		menuBuy.anchorPoint = CGPointZero;
		menuBuy.position = CGPointZero;
		
		[buyLayer addChild:menuBuy z:8];
		
        return self;
    }
    
    return nil;
}

- (void)selectLevel:(id)sender
{	
	
	if ([UserData userData].backSound)
		[[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];	
	
	if ([[[stageInfoArray objectForKey:[stageKeys objectAtIndex:[sender tag] - 1]] objectForKey:@"level"] integerValue] == 1)
    {
		[UserData userData].lastPlayedStage = [stageKeys objectAtIndex:[sender tag] - 1];
		[[CCDirector sharedDirector] pushScene:[CCTransitionSlideInT transitionWithDuration:0.3 scene:[[[GameScene alloc]init] autorelease]]];

		return;
	}
	
    if ([[UserData userData] isAvaliableStage:[[stageInfoArray objectForKey:[stageKeys objectAtIndex:[sender tag] - 1]] objectForKey:@"level"]])
	{
		if (buyState == STAGE_BUY) 
		{
			[UserData userData].lastPlayedStage = [stageKeys objectAtIndex:[sender tag] - 1];
			[[CCDirector sharedDirector] pushScene:[CCTransitionSlideInT transitionWithDuration:0.3 scene:[[[GameScene alloc]init] autorelease]]];
		}
    }
    else
    {
		if (buyState == STAGE_BUY) 
		{
			self.isTouchEnabled = NO;
			buyLayer.isTouchEnabled = YES;
			
			buyLayer.visible = YES;			
			buyState = STAGE_BUY_POPUP;
			
			buyYes.visible = YES;
			buyNO.visible = YES;
			menuBuy.visible = YES;
			buyValue.visible = YES;
			
			cashMenu.visible = NO;
			cashNO.visible = NO;
			
			[buylab setString:@"Would you like to open?"];
			NSString* temp = [NSString stringWithFormat:@"$ %@", 
							  [[[stageInfoArray objectForKey:[stageKeys objectAtIndex:[sender tag] - 1]] objectForKey:@"value"] stringValue]];
			
			[buyValue setString:temp];			
			selectStage = [[stageInfoArray objectForKey:[stageKeys objectAtIndex:[sender tag] - 1]] objectForKey:@"level"];
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
