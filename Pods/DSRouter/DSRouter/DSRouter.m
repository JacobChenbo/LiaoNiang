//
//  DSRouter.m
//  Routable
//
//  Created by Jacob on 5/26/16.
//  Copyright © 2016 TurboProp Inc. All rights reserved.
//

#import "DSRouter.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@implementation DSRouter

+ (instancetype)sharedRouter {
    static DSRouter *_sharedRouter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedRouter = [[DSRouter alloc] init];
    });
    return _sharedRouter;
}

//really unnecessary; kept for backward compatibility.
+ (instancetype)newRouter {
    return [[self alloc] init];
}

@end

@interface RouterParams : NSObject

@property (readwrite, nonatomic, strong) DSRouterOptions *routerOptions;
@property (readwrite, nonatomic, strong) NSDictionary *openParams;
@property (readwrite, nonatomic, strong) NSDictionary *extraParams;
@property (readwrite, nonatomic, strong) NSDictionary *controllerParams;

@end

@implementation RouterParams

- (instancetype)initWithRouterOptions: (DSRouterOptions *)routerOptions openParams: (NSDictionary *)openParams extraParams: (NSDictionary *)extraParams{
    [self setRouterOptions:routerOptions];
    [self setExtraParams: extraParams];
    [self setOpenParams:openParams];
    return self;
}

- (NSDictionary *)controllerParams {
    NSMutableDictionary *controllerParams = [NSMutableDictionary dictionaryWithDictionary:self.routerOptions.defaultParams];
    [controllerParams addEntriesFromDictionary:self.extraParams];
    [controllerParams addEntriesFromDictionary:self.openParams];
    return controllerParams;
}
//fake getter. Not idiomatic Objective-C. Use accessor controllerParams instead
- (NSDictionary *)getControllerParams {
    return [self controllerParams];
}
@end

@interface DSRouterOptions ()

@property (readwrite, nonatomic, strong) Class openClass;
@property (readwrite, nonatomic, copy) RouterOpenCallback callback;
@end

@implementation DSRouterOptions

//Explicit construction
+ (instancetype)routerOptionsWithPresentationStyle: (UIModalPresentationStyle)presentationStyle
                                   transitionStyle: (UIModalTransitionStyle)transitionStyle
                                     defaultParams: (NSDictionary *)defaultParams
                                            isRoot: (BOOL)isRoot
                                           isModal: (BOOL)isModal
                          hidesBottomBarWhenPushed: (BOOL)hidesBottomBarWhenPushed
                                 shouldPushInModal: (BOOL)shouldPushInModal{
    DSRouterOptions *options = [[DSRouterOptions alloc] init];
    options.presentationStyle              = presentationStyle;
    options.transitionStyle                = transitionStyle;
    options.defaultParams                  = defaultParams;
    options.shouldOpenAsRootViewController = isRoot;
    options.modal                          = isModal;
    options.hidesBottomBarWhenPushed       = hidesBottomBarWhenPushed;
    options.shouldPushInModal              = shouldPushInModal;
    return options;
}

+ (instancetype)routerOptionsWithPresentationStyle: (UIModalPresentationStyle)presentationStyle
                                   transitionStyle: (UIModalTransitionStyle)transitionStyle
                                     defaultParams: (NSDictionary *)defaultParams
                                            isRoot: (BOOL)isRoot
                                           isModal: (BOOL)isModal
                          hidesBottomBarWhenPushed: (BOOL)hidesBottomBarWhenPushed{
    return [self routerOptionsWithPresentationStyle:presentationStyle
                                    transitionStyle:transitionStyle
                                      defaultParams:defaultParams
                                             isRoot:isRoot
                                            isModal:isModal
                           hidesBottomBarWhenPushed:hidesBottomBarWhenPushed
                                  shouldPushInModal:NO];
}

+ (instancetype)routerOptionsWithPresentationStyle: (UIModalPresentationStyle)presentationStyle
                                   transitionStyle: (UIModalTransitionStyle)transitionStyle
                                     defaultParams: (NSDictionary *)defaultParams
                                            isRoot: (BOOL)isRoot
                                           isModal: (BOOL)isModal {
    return [self routerOptionsWithPresentationStyle:presentationStyle
                                    transitionStyle:transitionStyle
                                      defaultParams:defaultParams
                                             isRoot:isRoot
                                            isModal:isModal
                           hidesBottomBarWhenPushed:NO];
}
//Default construction; like [NSArray array]
+ (instancetype)routerOptions {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:nil
                                             isRoot:NO
                                            isModal:NO];
}

//Custom class constructors, with heavier Objective-C accent
+ (instancetype)routerOptionsAsModal {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:nil
                                             isRoot:NO
                                            isModal:YES];
}
+ (instancetype)routerOptionsWithPresentationStyle:(UIModalPresentationStyle)style {
    return [self routerOptionsWithPresentationStyle:style
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:nil
                                             isRoot:NO
                                            isModal:NO];
}
+ (instancetype)routerOptionsWithTransitionStyle:(UIModalTransitionStyle)style {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:style
                                      defaultParams:nil
                                             isRoot:NO
                                            isModal:NO];
}
+ (instancetype)routerOptionsForDefaultParams:(NSDictionary *)defaultParams {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:defaultParams
                                             isRoot:NO
                                            isModal:NO];
}
+ (instancetype)routerOptionsAsRoot {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:nil
                                             isRoot:YES
                                            isModal:NO];
}
+ (instancetype)routerOptionsHidesBottomBarWhenPushed {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:nil
                                             isRoot:NO
                                            isModal:NO
                           hidesBottomBarWhenPushed:YES];
}
+ (instancetype)routerOptionsPushInModal {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:nil
                                             isRoot:NO
                                            isModal:NO
                           hidesBottomBarWhenPushed:NO
                                  shouldPushInModal:YES];
}


//Exposed methods previously supported
+ (instancetype)modal {
    return [self routerOptionsAsModal];
}
+ (instancetype)withPresentationStyle:(UIModalPresentationStyle)style {
    return [self routerOptionsWithPresentationStyle:style];
}
+ (instancetype)withTransitionStyle:(UIModalTransitionStyle)style {
    return [self routerOptionsWithTransitionStyle:style];
}
+ (instancetype)forDefaultParams:(NSDictionary *)defaultParams {
    return [self routerOptionsForDefaultParams:defaultParams];
}
+ (instancetype)root {
    return [self routerOptionsAsRoot];
}

//Wrappers around setters (to continue DSL-like syntax)
- (DSRouterOptions *)modal {
    [self setModal:YES];
    return self;
}
- (DSRouterOptions *)withPresentationStyle:(UIModalPresentationStyle)style {
    [self setPresentationStyle:style];
    return self;
}
- (DSRouterOptions *)withTransitionStyle:(UIModalTransitionStyle)style {
    [self setTransitionStyle:style];
    return self;
}
- (DSRouterOptions *)forDefaultParams:(NSDictionary *)defaultParams {
    [self setDefaultParams:defaultParams];
    return self;
}
- (DSRouterOptions *)root {
    [self setShouldOpenAsRootViewController:YES];
    return self;
}
@end

@interface JCRouter ()

// Map of URL format NSString -> RouterOptions
// i.e. "users/:id"
@property (readwrite, nonatomic, strong) NSMutableDictionary *routes;
// Map of final URL NSStrings -> RouterParams
// i.e. "users/16"
@property (readwrite, nonatomic, strong) NSMutableDictionary *cachedRoutes;

/*
 * 判断当前open的url是否包含“?”
 * 如果包含“?”，则根据“?”解析url，并做跳转 i.e. "users?id=1&name=2"
 * 如果不包含“?”，则根据路径解析url，并做跳转（默认为这种情况） i.e. "users/1/2"
 */
@property (readwrite, nonatomic, assign) BOOL isURLFormatWithQuestionMark;

@end

#define ROUTE_NOT_FOUND_FORMAT @"No route found for URL %@"
#define INVALID_CONTROLLER_FORMAT @"Your controller class %@ needs to implement either the static method %@ or the instance method %@"

@implementation JCRouter

- (id)init {
    if ((self = [super init])) {
        self.routes = [NSMutableDictionary dictionary];
        self.cachedRoutes = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)map:(NSString *)format toCallback:(RouterOpenCallback)callback {
    [self map:format toCallback:callback withOptions:nil];
}

- (void)map:(NSString *)format toCallback:(RouterOpenCallback)callback withOptions:(DSRouterOptions *)options {
    if (!format) {
        @throw [NSException exceptionWithName:@"RouteNotProvided"
                                       reason:@"Route #format is not initialized"
                                     userInfo:nil];
        return;
    }
    if (!options) {
        options = [DSRouterOptions routerOptions];
    }
    options.callback = callback;
    [self.routes setObject:options forKey:format];
}

- (void)map:(NSString *)format toController:(Class)controllerClass {
    [self map:format toController:controllerClass withOptions:nil];
}

- (void)map:(NSString *)format toController:(Class)controllerClass withOptions:(DSRouterOptions *)options {
    if (!format) {
        @throw [NSException exceptionWithName:@"RouteNotProvided"
                                       reason:@"Route #format is not initialized"
                                     userInfo:nil];
        return;
    }
    if (!options) {
        options = [DSRouterOptions routerOptions];
    }
    options.openClass = controllerClass;
    [self.routes setObject:options forKey:format];
}

- (void)openExternal:(NSString *)url {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void)open:(NSString *)url {
    [self open:url animated:YES];
}

- (void)open:(NSString *)url animated:(BOOL)animated {
    [self open:url animated:animated extraParams:nil];
}

- (void)open:(NSString *)url
    animated:(BOOL)animated
 extraParams:(NSDictionary *)extraParams
{
    // 判断url是否包含“?”
    self.isURLFormatWithQuestionMark = [self isUrlContainsQuestionMark:url];
    
    RouterParams *params = [self routerParamsForUrl:url extraParams: extraParams];
    DSRouterOptions *options = params.routerOptions;
    
    if (options.callback) {
        RouterOpenCallback callback = options.callback;
        callback([params controllerParams]);
        return;
    }
    
    if (!self.navigationController) {
        if (_ignoresExceptions) {
            return;
        }
        
        @throw [NSException exceptionWithName:@"NavigationControllerNotProvided"
                                       reason:@"Router#navigationController has not been set to a UINavigationController instance"
                                     userInfo:nil];
    }
    
    UIViewController *controller = [self controllerForRouterParams:params];
    
    if (self.navigationController.presentedViewController && !options.shouldPushInModal) {
        [self.navigationController dismissViewControllerAnimated:animated completion:nil];
    }
    
    if ([options isModal]) {
        if ([controller.class isSubclassOfClass:UINavigationController.class]) {
            [self.navigationController presentViewController:controller
                                                    animated:animated
                                                  completion:nil];
        }
        else {
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
            navigationController.modalPresentationStyle = controller.modalPresentationStyle;
            navigationController.modalTransitionStyle = controller.modalTransitionStyle;
            [self.navigationController presentViewController:navigationController
                                                    animated:animated
                                                  completion:nil];
        }
    }
    else if (options.shouldOpenAsRootViewController) {
        [self.navigationController setViewControllers:@[controller] animated:animated];
    }
    else {
        UINavigationController *navigationController = self.navigationController;
        if (options.shouldPushInModal) {
            if ([self.navigationController.presentedViewController isKindOfClass:[UINavigationController class]]) {
                navigationController = (UINavigationController*)self.navigationController.presentedViewController;
            }
        }
        
        controller.hidesBottomBarWhenPushed = options.hidesBottomBarWhenPushed;
        [navigationController pushViewController:controller animated:animated];
        
    }
}
- (NSDictionary*)paramsOfUrl:(NSString*)url {
    return [[self routerParamsForUrl:url] controllerParams];
}

//Stack operations
- (void)popViewControllerFromRouterAnimated:(BOOL)animated {
    if (self.navigationController.presentedViewController) {
        [self.navigationController dismissViewControllerAnimated:animated completion:nil];
    }
    else {
        [self.navigationController popViewControllerAnimated:animated];
    }
}
- (void)pop {
    [self popViewControllerFromRouterAnimated:YES];
}
- (void)pop:(BOOL)animated {
    [self popViewControllerFromRouterAnimated:animated];
}

///////
- (RouterParams *)routerParamsForUrl:(NSString *)url extraParams: (NSDictionary *)extraParams {
    if (!url) {
        //if we wait, caching this as key would throw an exception
        if (_ignoresExceptions) {
            return nil;
        }
        @throw [NSException exceptionWithName:@"RouteNotFoundException"
                                       reason:[NSString stringWithFormat:ROUTE_NOT_FOUND_FORMAT, url]
                                     userInfo:nil];
    }
    
    if ([self.cachedRoutes objectForKey:url] && !extraParams) {
        return [self.cachedRoutes objectForKey:url];
    }
    
    NSArray *givenParts = url.pathComponents;
    NSArray *legacyParts = [url componentsSeparatedByString:@"/"];
    if ([legacyParts count] != [givenParts count]) {
        NSLog(@"DSRouter Warning - your URL %@ has empty path components - this will throw an error in an upcoming release", url);
        givenParts = legacyParts;
    }
    
    __block RouterParams *openParams = nil;
    __block NSMutableArray *givenPartsForOpenURL = nil;
    [self.routes enumerateKeysAndObjectsUsingBlock:
     ^(NSString *routerUrl, DSRouterOptions *routerOptions, BOOL *stop) {
         
         if (!self.isURLFormatWithQuestionMark) {
             // open URL 不包含"?"，一般情况，路径匹配
             NSArray *routerParts = [routerUrl pathComponents];
             if ([routerParts count] == [givenParts count]) {
                 
                 NSDictionary *givenParams = [self paramsForUrlComponents:givenParts routerUrlComponents:routerParts];
                 if (givenParams) {
                     openParams = [[RouterParams alloc] initWithRouterOptions:routerOptions openParams:givenParams extraParams: extraParams];
                     *stop = YES;
                 }
             }
         } else {
             // open URL 包含"?"，根据"?"解析 i.e. "users?id=1&name=2"
             NSArray *routerPartsForOpenURL = [url componentsSeparatedByString:@"?"];
             if (routerPartsForOpenURL.count != 2) {
                 *stop = YES;   // open URL 异常
             }
             NSArray *routerPartsForKey = [(NSString *)routerPartsForOpenURL[0] pathComponents];
             NSArray *routerPartsForParams = [(NSString *)routerPartsForOpenURL[1] componentsSeparatedByString:@"&"];
             givenPartsForOpenURL = [[NSMutableArray alloc] initWithArray:routerPartsForKey];
             for (NSString *param in routerPartsForParams) {
                 [givenPartsForOpenURL addObject:param];
             }
             
             NSArray *routerParts = [routerUrl pathComponents];
             NSDictionary *givenParams = [self paramsForUrlComponents:givenPartsForOpenURL paramsPartForUrlComponets:routerPartsForParams routerUrlComponents:routerParts];
             if (givenParams) {
                 openParams = [[RouterParams alloc] initWithRouterOptions:routerOptions openParams:givenParams extraParams:extraParams];
                 if (routerPartsForParams.count == givenParams.count) {
                     *stop = YES; // 只有当open url的所有参数都匹配上了，才结束查找
                 }
             }
         }
     }];
    
    if (!openParams) {
        if (_ignoresExceptions) {
            return nil;
        }
        @throw [NSException exceptionWithName:@"RouteNotFoundException"
                                       reason:[NSString stringWithFormat:ROUTE_NOT_FOUND_FORMAT, url]
                                     userInfo:nil];
    }
    [self.cachedRoutes setObject:openParams forKey:url];
    return openParams;
}

- (RouterParams *)routerParamsForUrl:(NSString *)url {
    return [self routerParamsForUrl:url extraParams: nil];
}

- (NSDictionary *)paramsForUrlComponents:(NSArray *)givenUrlComponents
                     routerUrlComponents:(NSArray *)routerUrlComponents {
    
    __block NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [routerUrlComponents enumerateObjectsUsingBlock:
     ^(NSString *routerComponent, NSUInteger idx, BOOL *stop) {
         
         NSString *givenComponent = givenUrlComponents[idx];
         if ([routerComponent hasPrefix:@":"]) {
             NSString *key = [routerComponent substringFromIndex:1];
             [params setObject:givenComponent forKey:key];
         }
         else if (![routerComponent isEqualToString:givenComponent]) {
             params = nil;
             *stop = YES;
         }
     }];
    return params;
}

// 新增方法，解析带"?"的参数
- (NSDictionary *)paramsForUrlComponents:(NSArray *)givenUrlComponents
               paramsPartForUrlComponets:(NSArray *)paramsPartComonents
                     routerUrlComponents:(NSArray *)routerUrlComponents {
    __block NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [routerUrlComponents enumerateObjectsUsingBlock:^(NSString *routerComponent, NSUInteger idx, BOOL *stop) {
        NSString *givenComponent = [givenUrlComponents objectAtIndex:idx < givenUrlComponents.count ? idx: givenUrlComponents.count - 1];
        if ([routerComponent hasPrefix:@":"]) {
            NSString *key = [routerComponent substringFromIndex:1];
            // 传进来的参数，有可能数量和顺序都跟map定义的不一样，
            // 所以这里要用key字符串来匹配
            for (NSString *paramPart in paramsPartComonents) {
                // id=1
                NSArray *keyValue = [paramPart componentsSeparatedByString:@"="];
                if (keyValue.count != 2) {
                    params = nil;
                    *stop = YES;   // 参数异常
                }
                if ([keyValue[0] isEqualToString:key]) {
                    [params setObject:keyValue[1] forKey:key];
                    break;
                }
            }
        }
        else if (![routerComponent isEqualToString:givenComponent]) {
            params = nil; // map的key不同
            *stop = YES;
        }
    }];
    return params;
}

- (BOOL)isUrlContainsQuestionMark:(NSString *)url {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        return [url containsString:@"?"];
    } else {
        NSRange range = [url rangeOfString:@"?"];
        return (range.location != NSNotFound);
    }
}

- (UIViewController *)controllerForRouterParams:(RouterParams *)params {
    SEL CONTROLLER_CLASS_SELECTOR = sel_registerName("allocWithRouterParams:");
    SEL CONTROLLER_SELECTOR = sel_registerName("initWithRouterParams:");
    UIViewController *controller = nil;
    Class controllerClass = params.routerOptions.openClass;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if ([controllerClass respondsToSelector:CONTROLLER_CLASS_SELECTOR]) {
        controller = [controllerClass performSelector:CONTROLLER_CLASS_SELECTOR withObject:[params controllerParams]];
    }
    else if ([params.routerOptions.openClass instancesRespondToSelector:CONTROLLER_SELECTOR]) {
        controller = [[params.routerOptions.openClass alloc] performSelector:CONTROLLER_SELECTOR withObject:[params controllerParams]];
    }
#pragma clang diagnostic pop
    if (!controller) {
        if (_ignoresExceptions) {
            return controller;
        }
        @throw [NSException exceptionWithName:@"DSRouterInitializerNotFound"
                                       reason:[NSString stringWithFormat:INVALID_CONTROLLER_FORMAT, NSStringFromClass(controllerClass), NSStringFromSelector(CONTROLLER_CLASS_SELECTOR),  NSStringFromSelector(CONTROLLER_SELECTOR)]
                                     userInfo:nil];
    }
    
    controller.modalTransitionStyle = params.routerOptions.transitionStyle;
    controller.modalPresentationStyle = params.routerOptions.presentationStyle;
    return controller;
}

@end