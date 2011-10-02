//
//  Cart.m
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 1..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Cart.h"

@implementation Cart

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        cartSpr = [[CCSprite alloc] initWithFile:@"fruit_apple.png"];
        cartSpr.position = ccp(60,20);
    }
    
    return self;
}

-(void)update
{    
    
}

@end
