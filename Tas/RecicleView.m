//
//  HomeView.m
//  Tas
//
//  Created by 郭龙 on 15/11/29.
//  Copyright © 2015年 郭龙. All rights reserved.
//

#import "RecicleView.h"

#define WIDTH_OF_SCROLL_PAGE 320
#define HEIGHT_OF_SCROLL_PAGE 360
#define WIDTH_OF_IMAGE 320
#define HEIGHT_OF_IMAGE 284
#define LEFT_EDGE_OFSET 0

@implementation RecicleView
@synthesize scrollView;
@synthesize slideImages;
@synthesize myTimer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:[self homeScrollView]];
    }
    return self;
}

-(UIScrollView *) homeScrollView{
    scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    CGRect scrollFrame;
    scrollFrame.origin.x = 0;
    scrollFrame.origin.y = 0;
    scrollFrame.size.width = WIDTH_OF_SCROLL_PAGE;
    scrollFrame.size.height = HEIGHT_OF_SCROLL_PAGE;
    scrollView = [[UIScrollView alloc] initWithFrame:scrollFrame];
    scrollView.bounces = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    slideImages = [[NSMutableArray alloc] init];
    [slideImages addObject:@"girl.png"];
    [slideImages addObject:@"girl.png"];
    [slideImages addObject:@"girl.png"];
    
    //add the last image first
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:([slideImages count]-1)]]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = CGRectMake(LEFT_EDGE_OFSET, 0, WIDTH_OF_IMAGE, HEIGHT_OF_IMAGE);
    [scrollView addSubview:imageView];
    for (int i = 0;i<[slideImages count];i++) {
        //loop this bit
        UIImageView *tmpImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:i]]];
        tmpImageView.frame = CGRectMake((WIDTH_OF_IMAGE * i) + LEFT_EDGE_OFSET + 320, 0, WIDTH_OF_IMAGE, HEIGHT_OF_IMAGE);
        [scrollView addSubview:tmpImageView];
        tmpImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    //add the first image at the end
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:0]]];
    imageView2.frame = CGRectMake((WIDTH_OF_IMAGE * ([slideImages count] + 1)) + LEFT_EDGE_OFSET, 0, WIDTH_OF_IMAGE, HEIGHT_OF_IMAGE);
    [scrollView addSubview:imageView2];
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView setContentSize:CGSizeMake(WIDTH_OF_SCROLL_PAGE * ([slideImages count] + 2), HEIGHT_OF_IMAGE)];
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [self addSubview:scrollView];
    [self.scrollView scrollRectToVisible:CGRectMake(WIDTH_OF_IMAGE,0,WIDTH_OF_IMAGE,HEIGHT_OF_IMAGE) animated:NO];
    [self performSelector:@selector(updateScrollView) withObject:nil afterDelay:0.0f];
    return self.scrollView;
}

- (void) updateScrollView
{
    [myTimer invalidate];
    myTimer = nil;
    //time duration
    NSTimeInterval timeInterval = 3;
    //timer
    myTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self
                                             selector:@selector(handleMaxShowTimer:)
                                             userInfo: nil
                                              repeats:YES];
}

- (void)handleMaxShowTimer:(NSTimer*)theTimer
{
    CGPoint pt = scrollView.contentOffset;
    NSInteger count = [slideImages count];
    if(pt.x == WIDTH_OF_IMAGE * count){
        [scrollView setContentOffset:CGPointMake(0, 0)];
        [self.scrollView scrollRectToVisible:CGRectMake(WIDTH_OF_IMAGE,0,WIDTH_OF_IMAGE,HEIGHT_OF_IMAGE) animated:YES];
    }else{
        [self.scrollView scrollRectToVisible:CGRectMake(pt.x+WIDTH_OF_IMAGE,0,WIDTH_OF_IMAGE,HEIGHT_OF_IMAGE) animated:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentPage = floor((self.scrollView.contentOffset.x - self.scrollView.frame.size.width / ([slideImages count]+2)) / self.scrollView.frame.size.width) + 1;
    if (currentPage==0) {
        //go last but 1 page
        [self.scrollView scrollRectToVisible:CGRectMake(WIDTH_OF_IMAGE * [slideImages count],0,WIDTH_OF_IMAGE,HEIGHT_OF_IMAGE) animated:NO];
    } else if (currentPage==([slideImages count]+1)) { //如果是最后+1,也就是要开始循环的第一个
        [self.scrollView scrollRectToVisible:CGRectMake(WIDTH_OF_IMAGE,0,WIDTH_OF_IMAGE,HEIGHT_OF_IMAGE) animated:NO];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
