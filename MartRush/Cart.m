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

-(void)init:(GameLayer*)_layer
{
    itemList = [NSMutableArray array];
    itemCount = 0;
    
    cartSpr = [[CCSprite alloc] initWithFile:@"cart.png"];
    [cartSpr setTextureRect:CGRectMake(0, 0, 92, 68)];
    cartSpr.position = ccp(CART_LEFT_X_POSITION, CART_Y_POSITION);  

    [_layer addChild:cartSpr z:1];
}    

-(void)cartMovingWay:(int)_num
{
    if(_num == LEFT_WAY)
        [cartSpr runAction:[CCMoveTo actionWithDuration:1 position:ccp(CART_LEFT_X_POSITION, CART_Y_POSITION)]];
    else if(_num == RIGHT_WAY)
        [cartSpr runAction:[CCMoveTo actionWithDuration:1 position:ccp(CART_RIGHT_X_POSITION, CART_Y_POSITION)]];
}

-(void)cartItemAdd:(Merchandise*)_item
{
    [itemList addObject:_item];
    itemCount++;
}

-(void)update
{    
    if(itemCount < 3)
        [cartSpr setTextureRect:CGRectMake(0, 0, 92, 68)];
    else if(itemCount < 6)
        [cartSpr setTextureRect:CGRectMake(92, 0, 92, 68)];
    else 
        [cartSpr setTextureRect:CGRectMake(184, 0, 92, 68)];
}

@end
