//
//  Cart.m
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Cart.h"

@implementation Cart

@synthesize itemList;
@synthesize cartHp;
#ifdef MARTRUSH_HAN_EDIT
@synthesize cartSpr;
#endif

-(id)init:(GameLayer*)_layer
{
  if (self = [super init]) {
    itemList = [[NSMutableArray alloc] init];
    
    cartSpr = [[CCSprite alloc] initWithFile:@"cart.png"];
    [cartSpr setTextureRect:CGRectMake(0, 0, 92, 68)];
    cartSpr.position = ccp(CART_LEFT_X_POSITION, CART_Y_POSITION);  

    [_layer addChild:cartSpr z:1];
    
    return self;
  }
  
  return nil;
}    

-(NSInteger)wayState
{
  return 0;
};

-(void)setWayState:(NSInteger)wayState
{
  if(wayState == LEFT_WAY)
      [cartSpr runAction:[CCMoveTo actionWithDuration:1 position:ccp(CART_LEFT_X_POSITION, CART_Y_POSITION)]];
  else if(wayState == RIGHT_WAY)
      [cartSpr runAction:[CCMoveTo actionWithDuration:1 position:ccp(CART_RIGHT_X_POSITION, CART_Y_POSITION)]];
}

-(void)cartItemAdd:(Merchandise*)_item
{
    [itemList addObject:_item];
}

-(void)update
{    
    if(itemList.count < 3)
        [cartSpr setTextureRect:CGRectMake(0, 0, 92, 68)];
    else if(itemList.count < 6)
        [cartSpr setTextureRect:CGRectMake(92, 0, 92, 68)];
    else 
        [cartSpr setTextureRect:CGRectMake(184, 0, 92, 68)];
}

-(void)dealloc
{
  [itemList dealloc];
  [super dealloc];
}

@end
