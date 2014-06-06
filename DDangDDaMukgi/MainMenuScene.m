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

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //self.backgroundColor = [SKColor colorWithRed:0.65 green:0.98 blue:0.72 alpha:1.00];
        self.backgroundColor = [UIColor blackColor];
        red = arc4random()%255, green = arc4random()%255, blue = arc4random()%255;
        
        //타이틀 라벨
        SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"DDang DDaMukgi"];
        titleLabel.text      = @"DDang DDaMukig";
        titleLabel.fontSize  = 84;
        titleLabel.fontColor = [UIColor lightGrayColor];
        titleLabel.fontName  = @"Gill Sans";
        titleLabel.position  = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) * 0.8);
        [self addChild:titleLabel];
        
        //Touch anywhere - 스타트
        SKLabelNode * startLabel = [SKLabelNode labelNodeWithFontNamed:@"Touch any where"];
        startLabel.text      = @"Touch any where";
        startLabel.fontSize  = 42;
        startLabel.fontColor = [UIColor lightGrayColor];
        startLabel.fontName  = @"Gill Sans Light";
        startLabel.position  = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) * 0.2);
        [self addChild:startLabel];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
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
        [self addChild:touchCircleSprite];
        NSLog(@"touched:%0.2f, %0.2f", touchLoacation.x, touchLoacation.y);
        
        /*[self runAction:[SKAction runBlock:^{
            SKTransition *reveal = [SKTransition fadeWithDuration:2.0];
            SKScene *playScene = [[PlayScene alloc]initWithSize:self.size];
            [self.view presentScene:playScene transition:reveal];
            }]

//         // Configure the view.
//         SKView *skView = (SKView *)self.view;
//         skView.showsFPS = YES;
//         skView.showsNodeCount = YES;
//         
//         // Create and configure the scene.
//         SKScene *mainScene = [MainMenuScene sceneWithSize:skView.bounds.size];
//         mainScene.scaleMode = SKSceneScaleModeAspectFill;
//         
//         // Present the scene.
//         [skView presentScene:mainScene];
         
         
         ];*/


        //Play Scene Load
        [self runAction:[SKAction runBlock:^{
            SKTransition *reveal = [SKTransition fadeWithDuration:2.0];
            SKScene *playScene = [[PlayScene alloc]initWithSize:self.size];
            [self.view presentScene:playScene transition:reveal];
        }]];

    }
}

-(void)update:(NSTimeInterval)currentTime {
//    self.backgroundColor = [SKColor colorWithRed:red green:green blue:blue alpha:0.42];
//    SKAction *bakChagAction = [SKAction colorizeWithColorBlendFactor:arc4random()%255 duration:4.2];
//    [self.parent runAction:bakChagAction];
    

    //NSLog(@"%d %d %d",red,green,blue);

}

- (void)updateViewBackground {
    self.backgroundColor = [SKColor colorWithRed:red green:green blue:blue alpha:0.42];
    //SKAction *bakChagAction = [SKAction colorizeWithColorBlendFactor:arc4random()%255 duration:4.2];
    
    //self.backgroundColor = [SKColor colorWithRed:red green:green blue:blue alpha:0.42];
    
    //SKAction *bakChagAction = [SKAction
    
//  [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:4.2];
    int randomNumber = arc4random_uniform(255);
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:
                                                   [NSString stringWithFormat:@"random_bg_%i",randomNumber]]];
    [UIView commitAnimations];
    
    NSLog(@"updateViewBAK");
}

@end