//
//  CalculateContentViewController.m
//  LiaoNiang
//
//  Created by Jacob on 8/25/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "CalculateContentViewController.h"
#import "CalculateSlideView.h"
#import "Calculate1ViewController.h"
#import "Calculate2ViewController.h"
#import "Calculate3ViewController.h"
#import "Calculate4ViewController.h"
#import "Calculate5ViewController.h"
#import "Calculate6ViewController.h"
#import "Calculate7ViewController.h"
#import "Calculate8ViewController.h"
#import "Calculate9ViewController.h"
#import "Calculate10ViewController.h"

@interface CalculateContentViewController ()

@property (nonatomic, strong) CalculateSlideView *slideView;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIViewController *currentVC;
@property (nonatomic, strong) Calculate1ViewController *c1;
@property (nonatomic, strong) Calculate2ViewController *c2;
@property (nonatomic, strong) Calculate3ViewController *c3;
@property (nonatomic, strong) Calculate4ViewController *c4;
@property (nonatomic, strong) Calculate5ViewController *c5;
@property (nonatomic, strong) Calculate6ViewController *c6;
@property (nonatomic, strong) Calculate7ViewController *c7;
@property (nonatomic, strong) Calculate8ViewController *c8;
@property (nonatomic, strong) Calculate9ViewController *c9;
@property (nonatomic, strong) Calculate10ViewController *c10;

@end

@implementation CalculateContentViewController

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (id)initWithIndex:(NSInteger)index {
    if (self = [super init]) {
        self.currentIndex = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupChildViewControllers];
    [self setupSlideView];
}

- (void)setupSlideView {
    CalculateSlideView *slideView = [[CalculateSlideView alloc] init];
    @weakify(self);
    [slideView setItemSelectedBlock:^(NSInteger index) {
        @strongify(self);
        [self changeCurrentViewControllerByIndex:index];
        [self.slideView hideSlide];
    }];
    self.slideView = slideView;
}

- (void)setupChildViewControllers {
    self.c1 = [[Calculate1ViewController alloc] init];
    
    self.c2 = [[Calculate2ViewController alloc] init];
    
    self.c3 = [[Calculate3ViewController alloc] init];
    
    self.c4 = [[Calculate4ViewController alloc] init];
    
    self.c5 = [[Calculate5ViewController alloc] init];
    
    self.c6 = [[Calculate6ViewController alloc] init];
    
    self.c7 = [[Calculate7ViewController alloc] init];
    
    self.c8 = [[Calculate8ViewController alloc] init];
    
    self.c9 = [[Calculate9ViewController alloc] init];
    
    self.c10 = [[Calculate10ViewController alloc] init];
    
    UISwipeGestureRecognizer *swipeGesture1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    [swipeGesture1 setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeGesture1];
    
    switch (self.currentIndex) {
        case 1:
        {
            [self addChildViewController:self.c1];
            [self.view addSubview:self.c1.view];
            self.currentVC = self.c1;
            break;
        }
        case 2:
        {
            [self addChildViewController:self.c2];
            [self.view addSubview:self.c2.view];
            self.currentVC = self.c2;
            break;
        }
        case 3:
        {
            [self addChildViewController:self.c3];
            [self.view addSubview:self.c3.view];
            self.currentVC = self.c3;
            break;
        }
        case 4:
        {
            [self addChildViewController:self.c4];
            [self.view addSubview:self.c4.view];
            self.currentVC = self.c4;
            break;
        }
        case 5:
        {
            [self addChildViewController:self.c5];
            [self.view addSubview:self.c5.view];
            self.currentVC = self.c5;
            break;
        }
        case 6:
        {
            [self addChildViewController:self.c6];
            [self.view addSubview:self.c6.view];
            self.currentVC = self.c6;
            break;
        }
        case 7:
        {
            [self addChildViewController:self.c7];
            [self.view addSubview:self.c7.view];
            self.currentVC = self.c7;
            break;
        }
        case 8:
        {
            [self addChildViewController:self.c8];
            [self.view addSubview:self.c8.view];
            self.currentVC = self.c8;
            break;
        }
        case 9:
        {
            [self addChildViewController:self.c9];
            [self.view addSubview:self.c9.view];
            self.currentVC = self.c9;
            break;
        }
        case 10:
        {
            [self addChildViewController:self.c10];
            [self.view addSubview:self.c10.view];
            self.currentVC = self.c10;
            break;
        }
            
        default:
            break;
    }
}

- (void)changeCurrentViewControllerByIndex:(NSInteger)index {
    if (index == self.currentIndex) {
        return;
    } else {
        switch (index) {
            case 1:
                [self replaceController:self.currentVC newController:self.c1 oldIndex:self.currentIndex newIndex:index];
                break;
            case 2:
                [self replaceController:self.currentVC newController:self.c2 oldIndex:self.currentIndex newIndex:index];
                break;
            case 3:
                [self replaceController:self.currentVC newController:self.c3 oldIndex:self.currentIndex newIndex:index];
                break;
            case 4:
                [self replaceController:self.currentVC newController:self.c4 oldIndex:self.currentIndex newIndex:index];
                break;
            case 5:
                [self replaceController:self.currentVC newController:self.c5 oldIndex:self.currentIndex newIndex:index];
                break;
            case 6:
                [self replaceController:self.currentVC newController:self.c6 oldIndex:self.currentIndex newIndex:index];
                break;
            case 7:
                [self replaceController:self.currentVC newController:self.c7 oldIndex:self.currentIndex newIndex:index];
                break;
            case 8:
                [self replaceController:self.currentVC newController:self.c8 oldIndex:self.currentIndex newIndex:index];
                break;
            case 9:
                [self replaceController:self.currentVC newController:self.c9 oldIndex:self.currentIndex newIndex:index];
                break;
            case 10:
                [self replaceController:self.currentVC newController:self.c10 oldIndex:self.currentIndex newIndex:index];
                break;
            default:
                break;
        }
    }
}

- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController oldIndex:(NSInteger)oldIndex newIndex:(NSInteger)newIndex {
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
//        if (finished) {
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
            self.currentIndex = newIndex;
//        } else {
//            self.currentVC = oldController;
//            self.currentIndex = oldIndex;
//        }
    }];
}

#pragma mark Recognizer

- (void)swipeGesture:(UISwipeGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:self.view];
    NSLog(@"x: %f, y: %f", point.x, point.y);
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self.slideView showSlide];
    }
}

@end
