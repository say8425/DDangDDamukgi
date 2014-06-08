//
//  PlayScene.h
//  DDangDDaMukgi
//
//  Created by Cheon Park on 2014. 4. 24..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Player.h"
#import "Map.h"

@interface PlayScene : SKScene {
    Player         *movingPlayer;       //Holding a reference to the Plater that user wants to move
    Map            *fieldMap;
    Map            *terriMap;
    BOOL           terriBool;
    NSTimeInterval lastUpdateTime;      //Store a lastTime of last call to update:
    NSTimeInterval dt;                  //Store a time that between the two most recent
}

- (void)draw:(NSNumber *)dt;
- (void)drawLines;
- (id)initWithSize:(CGSize)size withGameLevel:(int)level;
@end
