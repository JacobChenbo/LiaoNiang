//
//  BaseViewController.m
//  LiaoNiang
//
//  Created by Jacob on 8/22/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "BaseCalculateViewController.h"
#import "CustomNavBarView.h"
#import "UIResponder+FirstResponder.h"

@interface BaseCalculateViewController()<UIScrollViewDelegate>

@property (nonatomic, strong) CustomNavBarView *navBar;

@property (nonatomic, assign) CGFloat contentOffsetY;

@end

@implementation BaseCalculateViewController

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    
    NSLog(@"%@ viewDidLoaddd",[self class]);
    
    [super viewDidLoad];

    [self setupBaseViews];
}

- (void)setupBaseViews {
    self.view.backgroundColor = kBackgroundColor;
    
    @weakify(self);

    UITapGestureRecognizer *tap = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        @strongify(self);
        [self.view endEditing:YES];
    }];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    
    HXNoneReuseAutoHeightTabelView *tableView = [[HXNoneReuseAutoHeightTabelView alloc] init];
//    [tableView bk_whenTapped:^{
//        @strongify(self);
//        [self.tableView endEditing:YES];
//    }];
    self.tableView = tableView;
    tableView.scrollView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableView.superview).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    UIView *TopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 220)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 220)];
    imageView.image = [UIImage imageNamed:@"top"];
    [TopView addSubview:imageView];
    
    UIView *titleBgView = [UIView new];
    [TopView addSubview:titleBgView];
    [titleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(titleBgView.superview);
        make.bottom.equalTo(titleBgView.superview).offset(-10);
        make.size.mas_equalTo(CGSizeMake(200, 24));
    }];
    titleBgView.backgroundColor = UIColorFromRGBA(0x000000, 0.6);
    
    UILabel *navTitle = [UILabel new];
    [TopView addSubview:navTitle];
    [navTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(navTitle.superview);
        make.height.equalTo(@44);
    }];
    navTitle.textAlignment = NSTextAlignmentCenter;
    navTitle.font = [UIFont boldSystemFontOfSize:17];
    navTitle.textColor = [UIColor whiteColor];
    navTitle.text = self.navTitle;
    
    [tableView addCellView:TopView cellHeight:220];
    
    CustomNavBarView *navBar = [[CustomNavBarView alloc] init];
    [self.view addSubview:navBar];
    [navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(navBar.superview);
        make.height.equalTo(@64);
    }];
    navBar.title.text = self.navTitle;
    [navBar setBackActionBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.navBar = navBar;
    
    [self scrollViewDidScroll:tableView.scrollView];
}

#pragma mark Keyboard

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSValue *value = [info valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [self.view convertRect:[value CGRectValue] toView:nil];
    CGFloat keyboardHeight = keyboardRect.size.height;
    
    id firstResponder = [UIResponder currentFirstResponder];
    if ([firstResponder isKindOfClass:[UITextField class]]) {
        [self scrollViewByTextField:firstResponder keyboardHeight:keyboardHeight];
    }
}

- (void)scrollViewByTextField:(UITextField *)textField keyboardHeight:(float)keyboardHeight {
    CGFloat keyboardY = kScreenHeight - keyboardHeight;
    CGRect frame = [textField convertRect:textField.bounds toView:nil];
    CGFloat offsetD = keyboardY - (frame.origin.y + frame.size.height) - 64;
    if (offsetD < 0) {
        @weakify(self);
        [UIView animateWithDuration:0.3 animations:^{
            @strongify(self);
            self.contentOffsetY = - offsetD;
            self.tableView.scrollView.contentOffset = CGPointMake(0, self.tableView.scrollView.contentOffset.y - offsetD);
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    @weakify(self)
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        @strongify(self);
        self.tableView.scrollView.contentOffset = CGPointMake(0, self.tableView.scrollView.contentOffset.y - self.contentOffsetY);
    } completion:NULL];
}

#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > 220 - 64) {
        [self.navBar updateNavBarWithStatus:NO];
    } else {
        [self.navBar updateNavBarWithStatus:YES];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.tableView endEditing:YES];
}

- (double)roundDecimal:(double)plato number:(NSInteger)places {
    if (places < 0) {
        return 0;
    }
    if (places > 10) {
        return 0;
    }
    
    double rounded = round(plato * pow(10, places)) / pow(10, places);
    NSString *stringRounded = [NSString stringWithFormat:@"%f", rounded];
    NSInteger decimalPointPosition = 0;
    
    NSRange decimalPointRange = [stringRounded rangeOfString:@"."];
    if (decimalPointRange.location == NSNotFound) {
        decimalPointPosition = -1;
    } else {
        decimalPointPosition = decimalPointRange.location;
    }
    
    if (decimalPointPosition == 0) {
        stringRounded = [NSString stringWithFormat:@"0%@", stringRounded];
        decimalPointPosition = 1;
    }
    
    if (places != 0) {
        decimalPointRange = [stringRounded rangeOfString:@"."];
        if (decimalPointRange.location == NSNotFound) {
            decimalPointPosition = -1;
        } else {
            decimalPointPosition = decimalPointRange.location;
        }
        
        if (decimalPointPosition == -1) {
            stringRounded = [NSString stringWithFormat:@"%@%@", stringRounded, @"."];
        }
    }
    
    decimalPointPosition = [stringRounded rangeOfString:@"."].location;
    NSInteger currentPlaces = stringRounded.length - 1 - decimalPointPosition;
    
    if (currentPlaces < places) {
        for (NSInteger i = currentPlaces; i < places; i++) {
            stringRounded = [NSString stringWithFormat:@"%@0", stringRounded];
        }
    }
    
    return [stringRounded doubleValue];
}

- (double)convertGravityToPlato:(double)sg n:(double)n{
    var plato = ( - 1 * 616.868) + (1111.14 * sg) - (630.272 * pow(sg, 2)) + (135.997 * pow(sg, 3));

    return [self roundDecimal:plato number:n];
}

- (double)convertPlatoToGravity:(double)plato{
    return (plato / (258.6 - ((plato / 258.2) * 227.1))) + 1;
}

- (double)celsiusToFahrenheit:(double)celsius{
    return (9.0 / 5.0) * celsius + 32;
}

//升转加仑
- (double)litersToGallons:(double)liters{
    return 0.264172052 * liters;
}

//加仑转升
- (double)gallonsToLiters:(double)gallons {
    return 3.78541178 * gallons;
}

//千克转磅
- (double)kilogramsToPounds:(double)kg{
    return 2.20462262 * kg;
}

//克转盎司
- (double)gramToOunce:(double)gram {
    return 0.0352739619 * gram;
}

- (double)quartsToLiters:(double)quarts{
    return 0.946352946 * quarts;
}

- (double)litersToQuarts:(double)liters{
    return 1.05668821 * liters;
}
//盎司转克
- (double)ouncesToGrams:(double)ounces {
    return 28.3495231 * ounces;
}

//糖度转密度
- (double)covertPlatoToGravity:(double)plato {
    return (plato / (258.6 - ((plato / 258.2) * 227.1))) + 1;
}

//密度转糖度
- (double)covertGravityToPlato:(double)sg number:(NSInteger)n {
    if (n <= 0) {
        n = 1;
    }
    
    double plato = (-1 * 616.868) + (1111.14 * sg) - (630.272 * pow(sg, 2)) + (135.997 * pow(sg, 3));
    return [self roundDecimal:plato number:n];
}

@end
