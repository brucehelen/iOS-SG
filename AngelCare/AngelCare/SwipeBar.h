//
//  SwipeBar.h
//  AngelBaby
//
//  Created by macmini on 13/6/4.
//  Copyright (c) 2013年 Bill Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SwipeBarDelegate

@optional
- (void)swipeBarDidAppear:(id)sender;
- (void)swipeBarDidDisappear:(id)sender;
- (void)swipebarWasSwiped:(id)sender;
@end

@interface SwipeBar : UIView
{
    BOOL _isHidden;
    BOOL _canMove;
    float _height;
    float _padding;
    float _animationDuration;
}


@property (strong, nonatomic) UIView *parentView;
@property (strong, nonatomic) UIView *barView;
@property (weak, nonatomic) NSObject <SwipeBarDelegate> *delegate;


// Optional initializers
- (id)initWithMainView:(UIView*)view;
- (id)initWithMainView:(UIView*)view barView:(UIView*)barView;

// Set the amount of padding to be displayed above the bottom of the screen
- (void)setPadding:(float)padding;

// Selection of methods to hide/show the bar
// Variety, for your semantics
- (void)show:(BOOL)shouldShow;
- (void)hide:(BOOL)shouldHide;
- (void)toggle;


@end
