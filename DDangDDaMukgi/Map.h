//
//  Map.h
//  DDangDDaMukgi
//
//  Created by Cheon Park on 2014. 5. 29..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Map : SKSpriteNode {
    NSMutableArray *mappingPoints;
    int playerX;
    int playerY;
}

- (id)initWithGameLevel:(int)level;
- (CGPoint)getPlayerPosiont;
- (CGPathRef)mappingPathToDraw;

@end
