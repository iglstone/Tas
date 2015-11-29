//
//  HomeView.h
//  Tas
//
//  Created by 郭龙 on 15/11/29.
//  Copyright © 2015年 郭龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecicleView : UIView <UIScrollViewDelegate>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) NSMutableArray *slideImages;
@property (nonatomic) NSTimer *myTimer;

@end
