//
//  Player.h
//  DDangDDaMukgi
//
//  Created by Cheon Park on 2014. 4. 26..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Player : SKSpriteNode {
    NSMutableArray *wayPoints;              //Player's wayPoints ARRAY
    CGPoint        velocity;                //Player's current speed and direction
}

- (void)addPointToMove:(CGPoint)point;      //Adding moving point
- (void)move:(NSNumber *)dt;                //Move!
- (CGPathRef)createPathToMove;              //before moving, Make a path
- (CGPoint)checkBoundaries:(CGPoint)point;  //Check bounder

@end
