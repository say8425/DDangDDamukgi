//
//  Player.m
//  DDangDDaMukgi
//
//  Created by Cheon Park on 2014. 4. 26..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "Player.h"
#import "config.h"

@implementation Player

- (instancetype)initWithImageNamed:(NSString *)name {
    if (self = [super initWithImageNamed:name]) {
        wayPoints = [NSMutableArray array];
    }
    return self;
}


#pragma mark - movingFunction

///Adding moving point
- (void)addPointToMove:(CGPoint)point {
    [wayPoints addObject:[NSValue valueWithCGPoint:point]];
}

///Move!
- (void)move:(NSNumber *)dt {
    CGPoint currentPosition = self.position;
    CGPoint newPosition;
    
    if ([wayPoints count] > 0) {
        CGPoint targetPoint = [[wayPoints firstObject]CGPointValue];
        
        CGPoint offset      = CGPointMake(targetPoint.x - currentPosition.x,
                                          targetPoint.y - currentPosition.y);
        
        CGFloat length      = sqrtf      (offset.x * offset.x +
                                          offset.y * offset.y);
        CGPoint direction   = CGPointMake(offset.x / length,
                                          offset.y / length);
        
        velocity            = CGPointMake(direction.x * POINTS_PER_SEC,
                                          direction.y * POINTS_PER_SEC);
        newPosition         = CGPointMake(currentPosition.x + velocity.x * [dt doubleValue],
                                          currentPosition.y + velocity.y * [dt doubleValue]);
        

        if (CGRectContainsPoint(self.frame, targetPoint)) {
            [wayPoints removeObjectAtIndex:0];
        }
    } else {    //If wayPoints is empty, then velocity is ZERO
        newPosition = CGPointMake(currentPosition.x + 0 * [dt doubleValue],
                                  currentPosition.y + 0 * [dt doubleValue]);
    }
    
    self.position = [self checkBoundaries:newPosition];
    self.zRotation = atan2f(velocity.y, velocity.x) + M_PI_2;
}

///before moving, Make a path
- (CGPathRef)createPathToMove {
    CGMutablePathRef ref = CGPathCreateMutable();
    
    for (int i = 0; i < [wayPoints count]; ++i) {
        CGPoint p = [wayPoints[i] CGPointValue];
        p = [self.scene convertPointToView:p];
        
        if (i == 0) {
            CGPathMoveToPoint(ref, NULL, p.x, p.y);
        } else {
            CGPathAddLineToPoint(ref, NULL, p.x, p.y);
        }
    }
    return ref;
}

///Check bounder
- (CGPoint)checkBoundaries:(CGPoint)point {
    CGPoint newVelocity = velocity;
    CGPoint newPosition = point;

    CGPoint bottomLeft = CGPointZero;
    CGPoint topRight = CGPointMake(self.scene.size.width, self.scene.size.height);

    //
    if (newPosition.x <= bottomLeft.x) {
        newPosition.x = bottomLeft.x;
        newVelocity.x = -newVelocity.x;
    } else if (newPosition.x >= topRight.x) {
        newPosition.x = topRight.x;
        newVelocity.x = -newVelocity.x;
    }

    if (newPosition.y <= bottomLeft.y) {
        newPosition.y = bottomLeft.y;
        newVelocity.y = -newVelocity.y;
    } else if (newPosition.y >= topRight.y) {
        newPosition.y = topRight.y;
        newVelocity.y = -newVelocity.y;
    }

    velocity = newVelocity;
    return newPosition;
}
@end
