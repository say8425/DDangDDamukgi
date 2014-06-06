//
//  Map.m
//  DDangDDaMukgi
//
//  Created by Cheon Park on 2014. 5. 29..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "Map.h"

@implementation Map

- (id)initWithGameLevel:(int)level {
    if ((self = [super init])) {
        //MappingPoint Array ㅑnit
        mappingPoints = [NSMutableArray array];

        //plist Load
        NSString *levelPlist = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"Level%d", level] ofType:@"plist"];
        NSDictionary *levelData = [NSDictionary dictionaryWithContentsOfFile:levelPlist];

        //Player Character Location Init
        NSDictionary *playerData = levelData[@"Player"];
        playerX = [playerData[@"x"]intValue];
        playerY = [playerData[@"y"]intValue];

        //Map Data Init
        NSArray *mapDatas = levelData[@"Map"];
        for (NSDictionary *mapData in mapDatas) {
            CGFloat mapX = [mapData[@"x"]floatValue];
            CGFloat mapY = [mapData[@"y"]floatValue];
            CGPoint mapXY = CGPointMake(mapX, mapY);
            [mappingPoints addObject:[NSValue valueWithCGPoint:mapXY]];
        }
    }
    return self;
}

- (CGPoint)getPlayerPosiont {
    CGPoint temp = CGPointMake(playerX, playerY);
    return temp;
}


- (CGPathRef)mappingPathToDraw {
    CGMutablePathRef ref = CGPathCreateMutable();

    for (int i = 0; i < [mappingPoints count]; ++i) {
        CGPoint p = [mappingPoints[i] CGPointValue];
        p = [self.scene convertPointToView:p];

        if (i == 0) {
            CGPathMoveToPoint(ref, NULL, p.x, p.y);
        } else {
            CGPathAddLineToPoint(ref, NULL, p.x, p.y);
        }
    }return ref;
}

@end
