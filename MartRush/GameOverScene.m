//
//  GameOverScene.m
//  MartRush
//
//  Created by omniavinco on 11. 10. 11..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GameOverScene.h"
#import "SimpleAudioEngine.h"


@implementation GameOverScene

+(CCScene *)scene
{
  CCScene *scene = [CCScene node];
  
  CCLayer *layer = [GameOverScene node];
  
  [scene addChild:layer];
  
  return scene;
}

- (id)init
{
  if (self = [super init]) {
    [self setIsTouchEnabled:YES];
    // Play BGM
//    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"" loop:YES];
    
    // Draw background image
    CCSprite *background = [CCSprite spriteWithFile:@"GameOver_bg.png"];
    background.position = ccp(240, 0);
    background.anchorPoint = ccp(0.5f, 0.0f);
      
    [self addChild:background z:0];
      
    menuMain = [CCMenuItemImage itemFromNormalImage:@"GameOver_Btn_normal_Main.png" selectedImage:@"GameOver_Btn_Main_click.png" target:self selector:@selector(menuItemMain:)];

    menuTry = [CCMenuItemImage itemFromNormalImage:@"GameOver_Btn_normal_Retry.png" selectedImage:@"GameOver_Btn_Retry_click.png" target:self selector:@selector(menuItemTry:)];

    [menuMain setPosition:ccp(170, -60)];
    [menuTry setPosition:ccp(170, -105)];
 
    overMenu = [CCMenu menuWithItems:menuTry ,menuMain, nil];
    [self addChild:overMenu];
      
  }
  return self;
}

-(void)menuItemTry:(id)sender
{
    [[CCDirector sharedDirector] pushScene:[GameScene node]];
}

-(void)menuItemMain:(id)sender
{
    [[CCDirector sharedDirector] pushScene:[TitleLayer scene]];
}

-(void)menuItemShop:(id)sender
{
    
}

//- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//  for (UITouch *touch in touches) {
//    if (touch) {
//      // Touch anywhere... popScene(main?)
//      [[CCDirector sharedDirector] popScene];
//    }
//  }
//}
@end
