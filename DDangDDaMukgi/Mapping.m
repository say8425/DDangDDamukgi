//
//  Mapping.m
//  DDangDDaMukgi
//
//  Created by Cheon Park on 2014. 5. 16..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "Mapping.h"

@implementation Mapping
- (id)initWithLayer:(id)layer {
    if (self = [super initWithLayer:layer]) {
        self.backgroundColor = [UIColor greenColor].CGColor;
        self.frame = CGRectMake(20, 20, 1000, 1000);
    }
    return self;
}

- (CGPathRef)createMap {
    CGMutablePathRef ref = CGPathCreateMutable();
    
    return ref;
}
    

@end
