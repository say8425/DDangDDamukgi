//
//  Bounder.h
//  DDangDDaMukgi
//
//  Created by Cheon Park on 2014. 5. 7..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Bounder : SKSpriteNode {
    NSMutableArray  *drawingPints;            //그려야할 포인트들
}

- (void)followingBounder:(CGPoint)point;      //벽을 따라서 이동하게 조절함
@end
