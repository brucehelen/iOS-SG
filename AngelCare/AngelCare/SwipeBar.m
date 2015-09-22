//
//  SwipeBar.m
//  AngelBaby
//
//  Created by macmini on 13/6/4.
//  Copyright (c) 2013年 Bill Lin. All rights reserved.
//

#import "SwipeBar.h"

@interface SwipeBar ()
//  Gesture handler for swiping
- (void)barViewWasSwiped:(UIPanGestureRecognizer*)recognizer;
//  Finishes animating the bar if not completely swiped up/down
- (void)completeAnimation:(BOOL)show;

@end

@implementation SwipeBar
@synthesize parentView = _parentView;
@synthesize delegate = _delegate;
@synthesize barView = _barView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


#pragma mark - Init

- (id)init
{
    if (self = [super init]) {
        _isHidden = YES;
        _canMove = NO;
        _height = 88.0f;
        _padding = 0.0f;
        _animationDuration = 0.1f;
        [self setBackgroundColor:[UIColor clearColor]];
        [self setOpaque:NO];
    }
    return self;
}


- (id)initWithMainView:(UIView *)view
{
    if (self = [self init]) {
        [self setParentView:view];
        
        UIPanGestureRecognizer *swipeDown = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(barViewWasSwiped:)];
        [self addGestureRecognizer:swipeDown];
        
        CGRect parentFrame = _parentView.frame;
        NSLog(@"parent Frame = %f %f %f %f",_parentView.frame.origin.x,_parentView.frame.origin.y,_parentView.frame.size.width,_parentView.frame.size.height);
        CGRect frame = CGRectMake(parentFrame.size.width-20, 20, parentFrame.size.width, parentFrame.size.height);
        [self setFrame:frame];
    }
    return self;
}


- (id)initWithMainView:(UIView*)view barView:(UIView*)barView
{
    if (self = [self initWithMainView:view]) {
        _height = barView.frame.size.height;
//        _height = 320;
        _barView = barView;
        [self addSubview:_barView];
    }
    return [self initWithMainView:view];
}



#pragma mark - Display methods

- (void)show:(BOOL)shouldShow
{
    [self completeAnimation:shouldShow];
}

- (void)hide:(BOOL)shouldHide
{
    [self completeAnimation:(!shouldHide)];
}

- (void)toggle
{
    [self completeAnimation:_isHidden];
}

#pragma mark - UIGestureRecognizer handlers

- (void)barViewWasSwiped:(UIPanGestureRecognizer*)recognizer
{
    CGPoint swipeLocation = [recognizer locationInView:_parentView];
    
//    NSLog(@"swipeLocation = %f %f",swipeLocation.x,swipeLocation.y);
    
        
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        _canMove = YES;
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(swipebarWasSwiped:)]) {
                [self.delegate swipebarWasSwiped:self];
            }
        }
        return;
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged && _canMove) {
        
//        NSLog(@"parent View frame = %f %f %f %f ",self.parentView.frame.origin.x,self.parentView.frame.origin.y,self.parentView.frame.size.width,self.parentView.frame.size.height);
//        
//        NSLog(@"frame View frame = %f %f %f %f ",self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height);

        
//        float maxYPosition = self.parentView.frame.size.height - self.frame.size.height;
        float maxXPosition = self.parentView.frame.size.width - self.frame.size.width;
        if (swipeLocation.x > maxXPosition) {
//            CGRect frame = CGRectMake(self.frame.origin.x, swipeLocation.y, self.frame.size.width, self.frame.size.height);
            
            CGRect frame = CGRectMake(swipeLocation.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
            
//            CGRect frame = CGRectMake(swipeLocation.x, self.frame.origin.y, self.frame.size.width, 200);
            [self setFrame:frame];
        }
        return;
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded && _canMove) {
        float pivotYPosition = self.parentView.frame.size.width - self.frame.size.width / 2;
        
//        NSLog(@"pivot = %f frame = %f",pivotYPosition,self.frame.origin.x);
        
        _canMove = NO;
        [self completeAnimation:(self.frame.origin.x > pivotYPosition)];
        return;
    }
}

#pragma mark - Private methods

- (void)completeAnimation:(BOOL)show
{
    _isHidden = !show;
//    CGRect parentFrame = self.parentView.frame;
    CGRect goToFrame;
    if (show) {
//        goToFrame = CGRectMake(self.frame.origin.x, parentFrame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
        
        goToFrame = CGRectMake(self.frame.size.width+20, 91, self.frame.size.width, self.frame.size.height);
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            goToFrame = CGRectMake(748, 195, self.frame.size.width, self.frame.size.height);
        }
        
        
//        goToFrame = CGRectMake(self.frame.size.width+20, 91, self.frame.size.width, 200);
        
        NSLog(@"self.frame1 %f %f %f %f",self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
        
        NSLog(@"gotoFrame1 %f %f %f %f",goToFrame.origin.x,goToFrame.origin.y,goToFrame.size.width,goToFrame.size.height);
        
    }
    else {
//        goToFrame = CGRectMake(self.frame.origin.x, parentFrame.size.height - _padding, self.frame.size.width, self.frame.size.height);
        
        goToFrame = CGRectMake(40, 91, self.frame.size.width, self.frame.size.height);
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            goToFrame = CGRectMake(483, 195, self.frame.size.width, self.frame.size.height);
        }
        
//        goToFrame = CGRectMake(40, 91, self.frame.size.width, 200);
        NSLog(@"self.frame2 %f %f %f %f",self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
        NSLog(@"gotoFrame2 %f %f %f %f",goToFrame.origin.x,goToFrame.origin.y,goToFrame.size.width,goToFrame.size.height);
    }
    [UIView animateWithDuration:_animationDuration animations:^{
        [self setFrame:goToFrame];
    } completion:^(BOOL finished){
        if (finished && self.delegate) {
            if (show && [self.delegate respondsToSelector:@selector(swipeBarDidAppear:)]) {
                [self.delegate swipeBarDidAppear:self];
            }
            else if (!show && [self.delegate respondsToSelector:@selector(swipeBarDidDisappear:)]) {
                [self.delegate swipeBarDidDisappear:self];
            }
        }
    }];
}

#pragma mark - Getters/Setters

- (void)setBarView:(UIView *)view
{
    _barView = view;
    
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, _barView.frame.size.width, _barView.frame.size.height)];
    
//    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, _barView.frame.size.width, 200)];
    
    [self addSubview:_barView];
}

- (void)setPadding:(float)padding
{
    _padding = padding;
    CGRect oldFrame = self.frame;
    NSLog(@"old frame = %f %f %f %f",oldFrame.origin.x,oldFrame.origin.y,oldFrame.size.width,oldFrame.size.height);
//    float yOrigin = self.parentView.frame.size.height - padding;
//    CGRect newFrame = CGRectMake(oldFrame.origin.x, yOrigin, oldFrame.size.width, oldFrame.size.height);
    CGRect newFrame = CGRectMake(oldFrame.origin.x, 91, oldFrame.size.width, oldFrame.size.height);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        newFrame = CGRectMake(oldFrame.origin.x, 195, self.frame.size.width, self.frame.size.height);
    }
    
    [self setFrame:newFrame];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
