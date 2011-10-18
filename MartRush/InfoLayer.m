//
//  InfoLayer.m
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 14..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "MenuLayer.h"
#import "InfoLayer.h"
#import "UserData.h"

@implementation InfoLayer

NSString* infoArr[15] = 
{
	@"Information",
	@" ",
	@"ters213@gmail.com",
	@" ",
	@"Credit",
	@" ",
	@"imeugenius",
	@"MC.Im",
	@"Cute Sanghun",
	@"Nice Gyuseon",
	@"Youngest Xoul"
};


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        infoBg = [[CCSprite alloc] initWithFile:@"mainbg.png"];
        [self addChild:infoBg];
        
        [infoBg setPosition:ccp(0, 0)];
        [infoBg setAnchorPoint:CGPointZero];
        
        CCMenuItemImage* back = [CCMenuItemImage itemFromNormalImage:@"back_pink.png" selectedImage:@"back_blue.png" 
                                                              target:self selector:@selector(moveBack:)];
        
        back.anchorPoint = CGPointZero;
        
        CCMenu* menu = [CCMenu menuWithItems:back, nil];
        [menu setAnchorPoint:CGPointZero];
        [menu setPosition:ccp(5, 270)];
        
        [self addChild:menu];
		
		CCLabelTTF* infolab[10];
		
		for (int i = 0; i < 15; i++)
		{
			infolab[i] = [CCLabelTTF labelWithString:infoArr[i] fontName:@"NanumScript.ttf" fontSize:30];
			infolab[i].anchorPoint = ccp(0.5, 0.5);
			infolab[i].position = ccp(240, 280 - (i * 25));
			infolab[i].color = ccBLACK;
			
			[self addChild:infolab[i]];
		}		
    }
    
    return self;
}

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
    InfoLayer *layer = [InfoLayer node];
    [scene addChild:layer];
    
    return scene;       
}

-(void)moveBack:(id)sender
{
    if ([UserData userData].backSound)
        [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:0.3 scene:[MenuLayer scene]]];        
}

@end
