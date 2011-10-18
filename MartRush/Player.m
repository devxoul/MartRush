//
//  Player.m
//  MartRush
//
//  Created by 복 & 한 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Player.h"
#import "Const.h"
#import "Cart.h"
#import "GameLayer.h"
#import "GameUILayer.h"
#import "BossUILayer.h"

@implementation Player

@synthesize state;
@synthesize y;
@synthesize speed;
@synthesize hp;
@synthesize cart;
@synthesize playerRunDistance;

// state 액션 구현

-(id)initWithGameLayer:(GameLayer*)_layer
{
  if (self = [super init]) {
    gamelayer = _layer;
    [self createPlayerRunAnimation];
    
    //int _z = spr.zOrder;
    state = PLAYER_STATE_RUN;
    wayState = LEFT_WAY;
    y = PLAYER_Y_POSITION;
    
    stateSpr = [[CCSprite alloc] initWithFile:@"boom.png"];
    [gamelayer addChild:stateSpr z:Z_ORDER_PLAYER + 1];
    stateSpr.anchorPoint = ccp(0.5f, 0.0f);
    [stateSpr setVisible:NO];
    
    hp = 3;
    
    cart = [[Cart alloc] init:gamelayer];
    
    speed = gamelayer.gameScene.stageLevel + 10 ;
    
    [self startPlayerRunning];
    return self;
  }
  return nil;
}

- (CGRect)boundingBox
{
  return CGRectUnion([spr boundingBox], [[cart cartSpr] boundingBox]);
}

-(void)playerSetZorder:(int)_z
{
  [gamelayer reorderChild:bachNode z:_z];
  [gamelayer reorderChild:cart->cartSpr z:_z-1];
}


-(void)createPlayerRunAnimation
{
  [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"player_run.plist"];
  
  spr = [CCSprite spriteWithSpriteFrameName:@"player_run_0.png"];
  spr.position = ccp(PLAYER_LEFT_X_POSITION, PLAYER_Y_POSITION);
  spr.anchorPoint = ccp(0.5f, 0.0f);
  
  bachNode = [CCSpriteBatchNode batchNodeWithFile:@"player_run.png"];
  [bachNode addChild:spr];
  [gamelayer addChild:bachNode z:Z_ORDER_PLAYER];
  
  NSMutableArray *aniFrames = [[NSMutableArray alloc] init];
  
  for (int i = 0; i < 9; i++) {
    CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"player_run_%d.png", i]];
    [aniFrames addObject:frame];
  }
  
  CCAnimation *animation = [CCAnimation animationWithFrames:aniFrames delay:0.03f];
  runAni = [[CCAnimate alloc] initWithAnimation:animation restoreOriginalFrame:NO];    
}


-(void)startPlayerRunning
{
  [spr runAction:[CCRepeatForever actionWithAction:runAni]];
}

-(void)stopPlayerRunning
{
  [spr stopAllActions];
}

-(void)createPlayerStateAnimation
{
  if(state == PLAYER_STATE_CRASH)
  {
    [stateSpr setVisible:YES];
    state = PLAYER_STATE_CRASHING;
    
    CCCallFunc* endPlayerCrashCall = [CCCallFunc actionWithTarget:self selector:@selector(endPlayerCrash:)];
    
    stateSpr.position = ccp(spr.position.x, spr.position.y);
    
    [stateSpr runAction:[CCSequence actions:[CCFadeOut actionWithDuration:1] ,endPlayerCrashCall, nil]];
    state = PLAYER_STATE_CRASHING;
    hp--;
    
    switch (gamelayer.gameScene.stageType) {
      case STAGE_TYPE_NORMAL:
        [gamelayer.gameScene.gameUILayer heartUpdate];
        break;
      case STAGE_TYPE_BOSS:
        [gamelayer.gameScene.bossUILayer heartUpdate];
        break;
    }
    
    if (hp <= 0)
    {   
      state = PLAYER_STATE_DEAD;
      gamelayer.gameScene.gameState = GAME_STATE_OVER;
    }
  }
}

-(void)endPlayerCrash:(id)sender
{
  if (hp > 0)
    state = PLAYER_STATE_RUN;
}

-(NSInteger)wayState
{
  return wayState;
}

-(void)setWayState:(NSInteger)_wayState
{
  if (_wayState == LEFT_WAY) 
  {
    if(wayState == RIGHT_WAY)
    {
      wayState = LEFT_WAY;
      [spr runAction:[CCEaseBackOut actionWithAction:[CCMoveTo actionWithDuration:0.5 position:ccp(PLAYER_LEFT_X_POSITION, PLAYER_Y_POSITION)]]];           
      cart.wayState = LEFT_WAY;
    }
  }
  else if(_wayState == RIGHT_WAY)
  {
    if(wayState == LEFT_WAY)
    {            
      wayState = RIGHT_WAY;
      [spr runAction:[CCEaseBackOut actionWithAction:[CCMoveTo actionWithDuration:0.5 position:ccp(PLAYER_RIGHT_X_POSITION, PLAYER_Y_POSITION)]]];           
      cart.wayState = RIGHT_WAY;
    }
  }
}


-(void)update
{
  // 카트 이미지 Draw
  [cart update];
  // 플레이어 이미지 DRAW
  if(state == PLAYER_STATE_RUN)
  {
    
  }
  else if(state == PLAYER_STATE_CRASH)
  {
    [self createPlayerStateAnimation];
  }
  else if(state == PLAYER_STATE_DEAD)
  {
  }
}


@end

