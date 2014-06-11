//
//  Map.m
//  DDangDDaMukgi
//
//  Created by Cheon Park on 2014. 5. 29..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "Map.h"


@implementation Map
- (id)initWithImageNamed:(NSString *)name {
    if (self = [super initWithImageNamed:name]) {
        playerX = 10;
        playerY = 10;
    }return self;
}

#pragma mark -

- (id)initWithGameLevel:(int)level {
    if ((self = [super init])) {
        //MappingPoint Array ㅑnit
        mappingPoints = [NSMutableArray array];

        //plist Load
        NSString *levelPlist = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"Level%d", level] ofType:@"plist"];
        NSDictionary *levelData = [NSDictionary dictionaryWithContentsOfFile:levelPlist];
        NSLog(@"df%@", levelPlist);

        //NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Menu" ofType:@"plist"];
        //self.menuArray = [NSMutableArray arrayWithContentsOfFile:plistPath];

        //Player Character Location Init
        NSDictionary *playerData = levelData[@"Player"];
        playerX = [playerData[@"x"]intValue];
        playerY = [playerData[@"y"]intValue];
        NSLog(@"playX:%d",playerX);
        //Map Data Init
        NSArray *mapDatas = levelData[@"Map"];
        for (NSDictionary *mapData in mapDatas) {
            CGFloat mapX = [mapData[@"x"]floatValue];
            CGFloat mapY = [mapData[@"y"]floatValue];
            CGPoint mapXY = CGPointMake(mapX, mapY);
            NSLog(@"mapXY : (%f, %f)", mapXY.x, mapXY.y);
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

    //areaFunc
    CGFloat area = 0;
    int N = [mappingPoints count];
    CGPoint points[N];
    //-end

    for (int i = 0; i < [mappingPoints count]; ++i) {
        CGPoint p = [mappingPoints[i] CGPointValue];
        p = [self.scene convertPointToView:p];

        if (i == 0) {
            CGPathMoveToPoint(ref, NULL, p.x, p.y);
        } else {
            CGPathAddLineToPoint(ref, NULL, p.x, p.y);
        }
        //areaInt
        points[i] = p;
    }

    //areaFunc
    for (int i = 0; i < N; i++) {
        area += (points[i].x * points[(i+1) % N].y - points[(i+1) % N].x * points[i].y)/2.0;
    }//NSLog(@"area : %f", area);

    return ref;
}

//CGPoint points[N];

//CGFloat area = 0;
//for (int i = 0; i < N; i++) {
//    area += (points[i].x * points[(i+1) % N].y - points[(i+1) % N].x * points[i].y)/2.0;
//}

@end
