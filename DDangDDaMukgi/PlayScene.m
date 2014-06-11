//
//  PlayScene.m
//  DDangDDaMukgi
//
//  Created by Cheon Park on 2014. 4. 24..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "PlayScene.h"

@implementation PlayScene

- (id)initWithSize:(CGSize)size withGameLevel:(int)level {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [UIColor grayColor];

        fieldMap = [[Map alloc]initWithImageNamed:[NSString stringWithFormat:@"Level%d.png", level]];
        //fieldMap = [[Map alloc]initWithGameLevel:level];
        fieldMap.name = @"FieldMap";
        fieldMap.anchorPoint = CGPointZero;
        fieldMap.position = CGPointMake(42, 56);
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
        if ([layer.name isEqualToString:@"fieldMap"]) {
            [temp addObject:layer];
        }
    }[temp makeObjectsPerformSelector:@selector(removeFromSuperlayer)];

    //Player MovingLine Drawed
    [self enumerateChildNodesWithName:@"player" usingBlock:^(SKNode *node, BOOL *stop) {
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.name = @"line";
        lineLayer.strokeColor = [UIColor redColor].CGColor;
        lineLayer.fillColor = nil;
        
        CGPathRef path = [(Player *)node createPathToMove];
        lineLayer.path = path;
        CGPathRelease(path);
        [self.view.layer addSublayer:lineLayer];
    }];

    //Map Bounder Drawed
    //CAShapeLayer *fieldLayer = [CAShapeLayer layer];
    //fieldLayer.name = @"fieldMap";
    //fieldLayer.strokeColor = [UIColor yellowColor].CGColor;
    //fieldLayer.fillColor = nil;

    //CGPathRef path = [fieldMap mappingPathToDraw];
    //fieldLayer.path = path;
    //CGPathRelease(path);
    //[self.view.layer addSublayer:fieldLayer];
}

- (void)update:(NSTimeInterval)currentTime {
    dt = currentTime - lastUpdateTime;
    lastUpdateTime = currentTime;
    
    [self enumerateChildNodesWithName:@"player" usingBlock:^(SKNode *player, BOOL *stop) {
        [(Player *)player move:@(dt)];
    }];



    if (CGRectContainsRect(fieldMap.frame, movingPlayer.frame)) {
        NSLog(@"contains point:(%f, %f", movingPlayer.position.x, movingPlayer.position.y);
    } else if (!CGRectContainsRect(fieldMap.frame, movingPlayer.frame)) {
        NSLog(@"not contains point:(%f, %f", movingPlayer.position.x, movingPlayer.position.y);
    }
    NSLog(@"fieldMap height : %f",fieldMap.frame.size.height);

    [self drawLines];   //훼이크임. 먼저 움직이고 난중에 선그림.
}


@end
