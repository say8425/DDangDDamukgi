//
//  DDangDDaMukgiViewController.m
//  DDangDDaMukgi
//
//  Created by Cheon Park on 2014. 4. 13..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "DDangDDaMukgiViewController.h"
#import "MainMenuScene.h"
#import "PlayScene.h"

@implementation DDangDDaMukgiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene *mainScene = [MainMenuScene sceneWithSize:skView.bounds.size];
    
    mainScene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:mainScene];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
