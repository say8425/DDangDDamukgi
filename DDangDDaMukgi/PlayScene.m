//
//  PlayScene.m
//  DDangDDaMukgi
//
//  Created by Cheon Park on 2014. 4. 24..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "PlayScene.h"

@implementation PlayScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [UIColor greenColor];
        
        Player *player = [[Player alloc]initWithImageNamed:@"player.png"];
        player.name    = @"player";
        player.position = CGPointMake(self.size.width / 2.0f, self.size.height / 2.0f);
        [self addChild:player];
    } return self;
}

- (id)initWithSize:(CGSize)size withGameLevel:(int)level {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [UIColor greenColor];

        fieldMap = [[Map alloc]initWithGameLevel:level];
        fieldMap.name = @"FieldMap";
        fieldMap.position = CGPointMake(CGPointZero.x, CGPointZero.y);
        [self addChild:fieldMap];

        Player *player = [[Player alloc]initWithImageNamed:@"player.png"];
        player.name    = @"player";
        player.position = [fieldMap getPlayerPosiont];
        [self addChild:player];
    } return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [[touches anyObject]locationInNode:self.scene];
    SKNode *node = [self nodeAtPoint:touchPoint];
    
    if ([node.name isEqualToString:@"player"]) {
        [(Player *)node addPointToMove:touchPoint];
        movingPlayer = (Player *)node;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [[touches anyObject]locationInNode:self.scene];
    //SKNode *node = [self nodeAtPoint:touchPoint];

    
    if (movingPlayer) {
        //if ([node.name isEqualToString:@"bounder"]) {

        //}
        [movingPlayer addPointToMove:touchPoint];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)addPointToDraw:(CGPoint)point {
    
}

- (void)draw:(NSNumber *)dt {
    
}

- (void)drawLines {
    NSMutableArray *temp = [NSMutableArray array];
    
    for (CALayer *layer in self.view.layer.sublayers) {
        if ([layer.name isEqualToString:@"line"]) {
            [temp addObject:layer];
        }
        if ([layer.name isEqualToString:@"map"]) {
            [temp addObject:layer];
        }
    }[temp makeObjectsPerformSelector:@selector(removeFromSuperlayer)];

    //Player MovingLine Drawed
    [self enumerateChildNodesWithName:@"player" usingBlock:^(SKNode *node, BOOL *stop) {
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.name = @"line";
        lineLayer.strokeColor = [UIColor grayColor].CGColor;
        lineLayer.fillColor = nil;
        
        CGPathRef path = [(Player *)node createPathToMove];
        lineLayer.path = path;
        CGPathRelease(path);
        [self.view.layer addSublayer:lineLayer];
    }];

    //Map Bounder Drawed
    CAShapeLayer *mapLayer = [CAShapeLayer layer];
    mapLayer.name = @"map";
    mapLayer.strokeColor = [UIColor yellowColor].CGColor;
    mapLayer.fillColor = nil;

    CGPathRef path = [fieldMap mappingPathToDraw];
    mapLayer.path = path;
    CGPathRelease(path);
    [self.view.layer addSublayer:mapLayer];
}

- (void)update:(NSTimeInterval)currentTime {
    dt = currentTime - lastUpdateTime;
    lastUpdateTime = currentTime;
    
    [self enumerateChildNodesWithName:@"player" usingBlock:^(SKNode *player, BOOL *stop) {
        [(Player *)player move:@(dt)];
    }];

    [self drawLines];   //훼이크임. 먼저 움직이고 난중에 선그림.
}


@end
