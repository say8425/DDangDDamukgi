//
//  LevelScene.m
//  DDangDDaMukgi
//
//  Created by Cheon Park on 2014. 6. 11..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "LevelScene.h"

@implementation LevelScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [UIColor blackColor];

        //Level Select Box
        SKSpriteNode *levelSelect_Box = [[SKSpriteNode alloc]initWithImageNamed:@"LevelSelect_Box.png"];
        levelSelect_Box.name = @"LevelSelect_Box";
        levelSelect_Box.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) * 0.45);
        [self addChild:levelSelect_Box];

        //Level Box 1
        SKSpriteNode *levelBox1 = [[SKSpriteNode alloc]initWithImageNamed:@"LevelBox1.png"];
        levelBox1.name = @"LevelBox1";
        levelBox1.position = CGPointMake(levelSelect_Box.size.width / 5 * 1, levelSelect_Box.size.height / 3 * 1);
        [self addChild:levelBox1];

        //Level Box 2
        SKSpriteNode *levelBox2 = [[SKSpriteNode alloc]initWithImageNamed:@"LevelBox2.png"];
        levelBox2.name = @"LevelBox2";
        levelBox2.position = CGPointMake(levelSelect_Box.size.width / 5 * 2, levelSelect_Box.size.height / 3 * 1);
        [self addChild:levelBox2];

        //Level Box 3
        SKSpriteNode *levelBox3 = [[SKSpriteNode alloc]initWithImageNamed:@"LevelBox3.png"];
        levelBox1.name = @"LevelBox3";
        levelBox1.position = CGPointMake(levelSelect_Box.size.width / 5 * 3, levelSelect_Box.size.height / 3 * 1);
        [self addChild:levelBox3];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [[touches anyObject]locationInNode:self.scene];
    SKNode *node = [self nodeAtPoint:touchPoint];
    int level;


    if ([node.name isEqualToString:[NSString stringWithFormat:@"LevelBox%d", level]]) {
        SKTransition *reveal = [SKTransition fadeWithDuration:2.0];
        SKScene *playScene = [[PlayScene alloc]initWithSize:self.size withGameLevel:level];
        [self.view presentScene:playScene transition:reveal];
    }
}


@end
