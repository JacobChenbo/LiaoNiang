//
//  CalculateSlideView.m
//  LiaoNiang
//
//  Created by Jacob on 8/24/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "CalculateSlideView.h"
#import "CalculateSlideHeaderView.h"
#import "CalculateSlideCell.h"

#define kSlideWidth    kScreenWidth - 60

@interface CalculateSlideView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation CalculateSlideView

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (id)init {
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.dataSource = [[JCGlobay sharedInstance].calculateTools mutableCopy];
    
    self.frame = CGRectMake(0, 0, kSlideWidth, kScreenHeight);
    UITableView *tableView = [UITableView new];
    [self addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableView.superview);
    }];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = UIColorFromRGB(0x464646);
    
    CalculateSlideHeaderView *headerView = [[CalculateSlideHeaderView alloc] initWithFrame:CGRectMake(0, 0, kSlideWidth, 200)];
    tableView.tableHeaderView = headerView;
    
    UIView *coverView = [UIView new];
    coverView.backgroundColor = UIColorFromRGBA(0x000000, 0.3);
    coverView.alpha = 0.0;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapCoverView)];
    [coverView addGestureRecognizer:tapGesture];
    self.coverView = coverView;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:panGesture];
}

- (void)showSlide {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.coverView.frame = [UIScreen mainScreen].bounds;
    
    [window addSubview:self.coverView];
    [window addSubview:self];
    
    self.left = -kSlideWidth;
    
    @weakify(self);
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self);
        self.left = 0;
        self.coverView.alpha = 1.0;
    }];
}

- (void)hideSlide {
    @weakify(self);
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self);
        self.left = -kSlideWidth;
        self.coverView.alpha = 0.0;
    } completion:^(BOOL isFinished) {
        @strongify(self);
        [self removeFromSuperview];
        [self.coverView removeFromSuperview];
    }];
}

- (void)onTapCoverView {
    [self hideSlide];
}

- (void)panGesture:(UIPanGestureRecognizer *)panGestureRecoginzer {
    switch (panGestureRecoginzer.state) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint point = [panGestureRecoginzer translationInView:self];
            NSLog(@"point: %f", point.x);
            if (point.x < 0) {
                self.right = kSlideWidth + point.x;
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGPoint velocity = [panGestureRecoginzer velocityInView:self];
            NSLog(@"velocity: %f", velocity.x);
            if (velocity.x <= -20) {
                [self hideSlide];
            } else {
                @weakify(self);
                [UIView animateWithDuration:0.25 animations:^{
                    @strongify(self);
                    self.left = 0;
                    self.coverView.alpha = 1.0;
                }];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CalculateSlideCell *cell = [CalculateSlideCell cellWithTableView:tableView];
    cell.toolModel = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CalculateToolModel *model = [self.dataSource objectAtIndex:indexPath.row];
    if (self.itemSelectedBlock) {
        self.itemSelectedBlock(model.index);
    }
}

@end
