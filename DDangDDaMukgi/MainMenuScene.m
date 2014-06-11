//
//  MainMenuScene.m
//  DDangDDaMukgi
//
//  Created by Cheon Park on 2014. 4. 14..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "MainMenuScene.h"
#import "PlayScene.h"
#import "config.h"

@implementation MainMenuScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //self.backgroundColor = [SKColor colorWithRed:0.65 green:0.98 blue:0.72 alpha:1.00];
        self.backgroundColor = [UIColor blackColor];
        red = arc4random()%255, green = arc4random()%255, blue = arc4random()%255;
        
        //Title Label
        SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"DDang DDaMukgi"];
        titleLabel.text      = @"DDang DDaMukig";
        titleLabel.fontSize  = 84;
        titleLabel.fontColor = [UIColor lightGrayColor];
        titleLabel.fontName  = @"Gill Sans";
        titleLabel.position  = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) * 0.8);
        [self addChild:titleLabel];

        //Touch anywhere - startingGuide
        SKLabelNode *startLabel = [SKLabelNode labelNodeWithFontNamed:@"Touch any where"];
        startLabel.text      = @"Touch any where";
        startLabel.fontSize  = 42;
        startLabel.fontColor = [UIColor lightGrayColor];
        startLabel.fontName  = @"Gill Sans Light";
        startLabel.position  = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) * 0.2);
        [self addChild:startLabel];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //Circle Effect
    for (UITouch *touch in touches) {
        CGPoint touchLoacation          = [touch locationInNode:self];
        SKSpriteNode *touchCircleSprite = [SKSpriteNode spriteNodeWithImageNamed:@"touchCircle.png"];
        touchCircleSprite.position      = touchLoacation;
        SKAction *touchAction           = [SKAction group:@[
                                                            [SKAction fadeAlphaTo:0.0
                                                                         duration:0.42],
                                                            [SKAction resizeToWidth:3600
                                                                             height:3600
                                                                           duration:0.42]]
                                           ];

        [touchCircleSprite runAction:touchAction];
        //test deleting this, and work well then delete this.
        [self addChild:touchCircleSprite];

        [self runAction:[SKAction runBlock:^{
            SKTransition *reveal = [SKTransition fadeWithDuration:2.0];
            SKScene *playScene = [[PlayScene alloc]initWithSize:self.size withGameLevel:1];
            [self.view presentScene:playScene transition:reveal];
        }]];

    }
}


- (void)updateViewBackground {
    self.backgroundColor = [SKColor colorWithRed:red green:green blue:blue alpha:0.42];

    [UIView setAnimationDuration:4.2];
    int randomNumber = arc4random_uniform(255);
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:
                                                   [NSString stringWithFormat:@"random_bg_%i",randomNumber]]];
    [UIView commitAnimations];
    
    NSLog(@"updateViewBAK");
}

@end