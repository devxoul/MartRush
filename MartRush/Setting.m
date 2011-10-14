//
//  Setting.m
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 13..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Setting.h"
#import "SimpleAudioEngine.h"
#import "MenuLayer.h"
#import "UserData.h"

@implementation Setting

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
		self.isTouchEnabled = YES;
        
        CCLayer *layer = [CCLayer node];
        layer.anchorPoint = CGPointZero;
		[layer setPosition: ccp(0,0)];
        [self addChild: layer z:-1];
        
        
		//배경
        settingBgSprite = [[CCSprite alloc] initWithFile:@"mainbg.png"];
        settingBgSprite.anchorPoint = CGPointZero;
		[settingBgSprite setPosition:ccp(0, 0)];
        [self addChild:settingBgSprite z:0];
		//titleBgSprite.position = ccp(s.width/2, s.height/2);
		
        //전체메뉴 
        CCMenuItemImage *set_sound = [CCMenuItemImage itemFromNormalImage:@"sound.png" selectedImage:@"sound.png" target:self selector:@selector(setSound:)];
        set_sound.anchorPoint = CGPointZero;
                
        CCMenuItemImage *set_vibration = [CCMenuItemImage itemFromNormalImage:@"vibration.png" selectedImage:@"vibration.png" target:self selector:@selector(setVibration:)];
        set_vibration.anchorPoint = CGPointZero;
        CCMenuItemImage *set_reset = [CCMenuItemImage itemFromNormalImage:@"reset.png" selectedImage:@"reset.png" target:self selector:@selector(setReset:)];
        set_reset.anchorPoint = CGPointZero;
        //    CCMenuItemImage *menu_shop = [CCMenuItemImage itemFromNormalImage:@"menu_04.gif" selectedImage:@"menu_01.gif" target:self selector:@selector(back:)];
        //    menu_shop.anchorPoint = CGPointZero;
        
        CCMenu *menu = [CCMenu menuWithItems:set_sound, set_vibration, set_reset, nil];
        menu.anchorPoint = CGPointZero;
        [menu setPosition:ccp(0, 0)];
        
        [set_sound setPosition:ccp(24, 115)];
        [set_vibration setPosition:ccp(180, 115)];
        [set_reset setPosition:ccp(330, 115)];
        //    [menu_shop setPosition:ccp(366, 115)];
		
        [self addChild: menu];
        
        //뒤로가기 
        menu_back = [CCMenuItemImage itemFromNormalImage:@"back_pink.png" selectedImage:@"back_blue.png" target:self selector:@selector(back:)];
        menu_back.anchorPoint = CGPointZero;
        
        backMenu = [CCMenu menuWithItems:menu_back, nil];
        backMenu.anchorPoint = CGPointZero;
        [backMenu setPosition:ccp(10, 260)];
        
        [self addChild:backMenu];        
    }
    
    return self;
}

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
    Setting *layer = [Setting node];
    [scene addChild:layer];
    
    return scene;           
}

-(void)setSound:(id)sender
{
    //    if ([UserData userData].backSound ) {
    //        <#statements#>
    //    }
}

-(void)setVibration:(id)sender
{
    
}

-(void)setReset:(id)sender
{
    
}

- (void)back:(id)sender {
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:1 scene:[MenuLayer scene]]];
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
}

@end
