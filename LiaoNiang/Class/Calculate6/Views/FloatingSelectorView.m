//
//  FloatingSelectorView.m
//  LiaoNiang
//
//  Created by Jacob on 16/9/18.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "FloatingSelectorView.h"
#import "UIView+JWMasonryConstraint.h"
@interface FloatingSelectorView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *maskView;
@property (nonatomic, strong) UIView *tableContainerView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FloatingSelectorView

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
//    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CbbArrow"]];
    [self addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(arrowImageView.image.size);
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-16);
    }];
    
    UILabel *titleLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = CommonMainFontColor;
        label;
    });
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self);//.offset(16);
        make.right.equalTo(arrowImageView.mas_left).offset(-5);
    }];
    
    UIButton *maskView = [UIButton new];
//    maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.maskView = maskView;
    
    UIView *tableContainerView = [UIView new];
    self.tableContainerView = tableContainerView;
    tableContainerView.backgroundColor = [UIColor whiteColor];
    tableContainerView.clipsToBounds = NO;
    tableContainerView.layer.shadowColor = [UIColor blackColor].CGColor;
    tableContainerView.layer.shadowOpacity = 1;
    tableContainerView.layer.shadowOffset = CGSizeZero;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.tableView = tableView;
    tableView.clipsToBounds = YES;
    tableView.rowHeight = 40;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView jw_makeCoverOnView:tableContainerView];
    
    
    
    
    @weakify(self);
    [self bk_whenTapped:^{
        @strongify(self);
        [self showTable];
    }];
    
    [maskView bk_addEventHandler:^(id sender) {
        @strongify(self);
        [self hideTable];
    } forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)showTable{
    
    CGRect frame = [self convertRect:self.bounds toView:nil];
    
    CGFloat width = frame.size.width;
    if (self.tableWidthMultiple < 1) {
        self.tableWidthMultiple = 1;
    }
    if (width * self.tableWidthMultiple > kScreenWidth - 2 * kPadding) {
        frame = CGRectMake(kPadding, frame.origin.y, kScreenWidth - 2 * kPadding, frame.size.height);
    } else if (width * self.tableWidthMultiple + frame.origin.x > kScreenWidth - kPadding) {
        frame = CGRectMake(kScreenWidth - kPadding - width * self.tableWidthMultiple, frame.origin.y, width * self.tableWidthMultiple, frame.size.height);
    } else {
        frame = CGRectMake(frame.origin.x, frame.origin.y, width * self.tableWidthMultiple, frame.size.height);
    }
    
    CGSize tableContentSize = self.tableView.contentSize;
    
    CGFloat bottom = 50;
    CGFloat maxHeight = kScreenHeight - bottom - 64;
    
    if (tableContentSize.height > maxHeight) {
        tableContentSize.height = maxHeight;
    }
    
    CGRect tableContainerFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, tableContentSize.height);
    
    CGFloat yToBottom = kScreenHeight - frame.origin.y - bottom;
    
    if (yToBottom<tableContentSize.height) {
        tableContainerFrame.origin.y = kScreenHeight - tableContentSize.height - bottom;
    }
    self.tableContainerView.frame = tableContainerFrame;
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    [self.maskView jw_makeCoverOnView:window];
    
    [self.maskView addSubview:self.tableContainerView];
    
}

- (void)hideTable{
    [self.tableContainerView removeFromSuperview];
    [self.maskView removeFromSuperview];
}

- (void)setTitles:(NSArray<NSString *> *)titles{
    _titles = titles;
    self.titleLabel.text = [titles firstObject]?:@"";
    
    _title = self.titleLabel.text;
    _index = 0;
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.text = self.titles[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.titleLabel.text = self.titles[indexPath.row];
    
    _title = self.titleLabel.text;
    _index = indexPath.row;
    
    [self hideTable];
    !self.selectionDidChangeBlock?:self.selectionDidChangeBlock(self.titles[indexPath.row],indexPath.row);
}

@end
