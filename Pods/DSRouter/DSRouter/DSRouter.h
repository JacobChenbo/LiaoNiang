//
//  DSRouter.h
//  Routable
//
//  Created by Jacob on 5/26/16.
//  Copyright © 2016 TurboProp Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JCRouter;

typedef void (^RouterOpenCallback)(NSDictionary *params);

@interface DSRouterOptions : NSObject


/**
 @return A new instance of `DSRouterOptions` with its properties explicitly set
 @param presentationStyle The `UIModalPresentationStyle` attached to the mapped `UIViewController`
 @param transitionStyle The `UIModalTransitionStyle` attached to the mapped `UIViewController`
 @param defaultParams The default parameters which are passed when opening the URL
 @param isRoot The boolean `shouldOpenAsRootViewController` property is set to
 @param isModal The boolean that sets a modal presentation format
 */
+ (instancetype)routerOptionsWithPresentationStyle: (UIModalPresentationStyle)presentationStyle
                                   transitionStyle: (UIModalTransitionStyle)transitionStyle
                                     defaultParams: (NSDictionary *)defaultParams
                                            isRoot: (BOOL)isRoot
                                           isModal: (BOOL)isModal;

+ (instancetype)routerOptionsWithPresentationStyle: (UIModalPresentationStyle)presentationStyle
                                   transitionStyle: (UIModalTransitionStyle)transitionStyle
                                     defaultParams: (NSDictionary *)defaultParams
                                            isRoot: (BOOL)isRoot
                                           isModal: (BOOL)isModal
                          hidesBottomBarWhenPushed: (BOOL)hidesBottomBarWhenPushed;

+ (instancetype)routerOptionsWithPresentationStyle: (UIModalPresentationStyle)presentationStyle
                                   transitionStyle: (UIModalTransitionStyle)transitionStyle
                                     defaultParams: (NSDictionary *)defaultParams
                                            isRoot: (BOOL)isRoot
                                           isModal: (BOOL)isModal
                          hidesBottomBarWhenPushed: (BOOL)hidesBottomBarWhenPushed
                                 shouldPushInModal: (BOOL)shouldPushInModal;

/**
 @return A new instance of `DSRouterOptions` with its properties set to default
 */
+ (instancetype)routerOptions;

///-------------------------------
/// @name Options DSL
///-------------------------------
/**
 @return A new instance of `DSRouterOptions`, setting a modal presentation format.
 */
+ (instancetype)routerOptionsAsModal;
/**
 @return A new instance of `DSRouterOptions`, setting a `UIModalPresentationStyle` style.
 @param style The `UIModalPresentationStyle` attached to the mapped `UIViewController`
 */
+ (instancetype)routerOptionsWithPresentationStyle:(UIModalPresentationStyle)style;
/**
 @return A new instance of `DSRouterOptions`, setting a `UIModalTransitionStyle` style.
 @param style The `UIModalTransitionStyle` attached to the mapped `UIViewController`
 */
+ (instancetype)routerOptionsWithTransitionStyle:(UIModalTransitionStyle)style;
/**
 @return A new instance of `DSRouterOptions`, setting the defaultParams
 @param defaultParams The default parameters which are passed when opening the URL
 */
+ (instancetype)routerOptionsForDefaultParams:(NSDictionary *)defaultParams;
/**
 @return A new instance of `DSRouterOptions`, setting the `shouldOpenAsRootViewController` property to `YES`
 */
+ (instancetype)routerOptionsAsRoot;

+ (instancetype)routerOptionsHidesBottomBarWhenPushed;

+ (instancetype)routerOptionsPushInModal;

//previously supported
/**
 @remarks not idiomatic objective-c naming for allocation and initialization, see +routerOptionsAsModal
 @return A new instance of `DSRouterOptions`, setting a modal presentation format.
 */
+ (instancetype)modal;
/**
 @remarks not idiomatic objective-c naming for allocation and initialization, see + routerOptionsWithPresentationStyle:
 @return A new instance of `DSRouterOptions`, setting a `UIModalPresentationStyle` style.
 @param style The `UIModalPresentationStyle` attached to the mapped `UIViewController`
 */
+ (instancetype)withPresentationStyle:(UIModalPresentationStyle)style;
/**
 @remarks not idiomatic objective-c naming for allocation and initialization see +routerOptionsWithTransitionStyle:
 @return A new instance of `DSRouterOptions`, setting a `UIModalTransitionStyle` style.
 @param style The `UIModalTransitionStyle` attached to the mapped `UIViewController`
 */
+ (instancetype)withTransitionStyle:(UIModalTransitionStyle)style;
/**
 @remarks not idiomatic objective-c naming for allocation and initialization, see +routerOptionsForDefaultParams:
 @return A new instance of `DSRouterOptions`, setting the defaultParams
 @param defaultParams The default parameters which are passed when opening the URL
 */
+ (instancetype)forDefaultParams:(NSDictionary *)defaultParams;
/**
 @remarks not idiomatic objective-c naming for allocation and initialization, see +routerOptionsAsRoot
 @return A new instance of `DSRouterOptions`, setting the `shouldOpenAsRootViewController` property to `YES`
 */
+ (instancetype)root;

/**
 @remarks not idiomatic objective-c naming; overrides getter to wrap around setter
 @return The same instance of `DSRouterOptions`, setting a modal presentation format.
 */
- (DSRouterOptions *)modal;
/**
 @remarks not idiomatic objective-c naming; wraps around setter
 @return The same instance of `DSRouterOptions`, setting a `UIModalPresentationStyle` style.
 @param style The `UIModalPresentationStyle` attached to the mapped `UIViewController`
 */
- (DSRouterOptions *)withPresentationStyle:(UIModalPresentationStyle)style;
/**
 @remarks not idiomatic objective-c naming; wraps around setter
 @return The same instance of `DSRouterOptions`, setting a `UIModalTransitionStyle` style.
 @param style The `UIModalTransitionStyle` attached to the mapped `UIViewController`
 */
- (DSRouterOptions *)withTransitionStyle:(UIModalTransitionStyle)style;
/**
 @remarks not idiomatic objective-c naming; wraps around setter
 @return The same instance of `DSRouterOptions`, setting the defaultParams
 @param defaultParams The default parameters which are passed when opening the URL
 */
- (DSRouterOptions *)forDefaultParams:(NSDictionary *)defaultParams;
/**
 @remarks not idiomatic objective-c naming; wraps around setter
 @return A new instance of `DSRouterOptions`, setting the `shouldOpenAsRootViewController` property to `YES`
 */
- (DSRouterOptions *)root;

///-------------------------------
/// @name Properties
///-------------------------------

/**
 The property determining if the mapped `UIViewController` should be opened modally or pushed in the navigation stack.
 */
@property (readwrite, nonatomic, getter=isModal) BOOL modal;
/**
 The property determining the `UIModalPresentationStyle` assigned to the mapped `UIViewController` instance. This is always assigned, regardless of whether or not `modal` is true.
 */
@property (readwrite, nonatomic) UIModalPresentationStyle presentationStyle;
/**
 The property determining the `UIModalTransitionStyle` assigned to the mapped `UIViewController` instance. This is always assigned, regardless of whether or not `modal` is true.
 */
@property (readwrite, nonatomic) UIModalTransitionStyle transitionStyle;
/**
 Default parameters sent to the `UIViewController`'s initWithRouterParams: method. This is useful if you want to pass some non-`NSString` information. These parameters will be overwritten by any parameters passed in the URL in open:.
 */
@property (readwrite, nonatomic, strong) NSDictionary *defaultParams;
/**
 The property determining if the mapped `UIViewController` instance should be set as the root view controller of the router's `UINavigationController` instance.
 */
@property (readwrite, nonatomic, assign) BOOL shouldOpenAsRootViewController;

@property (readwrite, nonatomic, assign) BOOL hidesBottomBarWhenPushed;

@property (readwrite, nonatomic, assign) BOOL shouldPushInModal;

@end

@interface JCRouter : NSObject

///-------------------------------
/// @name Navigation Controller
///-------------------------------

/**
 The `UINavigationController` instance which mapped `UIViewController`s will be pushed onto.
 */
@property (readwrite, nonatomic, strong) UINavigationController *navigationController;

/**
 Pop to the last `UIViewController` mapped with the router; this will either dismiss the presented `UIViewController` (i.e. modal) or pop the top view controller in the navigationController. The transition is animated.
 */
- (void)pop;

/**
 Pop to the last `UIViewController` mapped with the router; this will either dismiss the presented `UIViewController` (i.e. modal) or pop the top view controller in the navigationController.
 @param animated Whether or not the transition is animated;
 */

- (void)popViewControllerFromRouterAnimated:(BOOL)animated;
/**
 Pop to the last `UIViewController` mapped with the router; this will either dismiss the presented `UIViewController` (i.e. modal) or pop the top view controller in the navigationController.
 @param animated Whether or not the transition is animated;
 @remarks not idiomatic objective-c naming
 */
- (void)pop:(BOOL)animated;

///-------------------------------
/// @name Mapping URLs
///-------------------------------

/**
 The property controls for throwing exception or not in your app. NOT throwing any exceptions if set to `YES`, default `NO`;
 */
@property (readwrite, nonatomic, assign) BOOL ignoresExceptions;

/**
 Map a URL format to an anonymous callback
 @param format A URL format (i.e. "users/:id" or "logout")
 @param callback The callback to run when the URL is triggered in `open:`
 */
- (void)map:(NSString *)format toCallback:(RouterOpenCallback)callback;
/**
 Map a URL format to an anonymous callback and `DSRouterOptions` options
 @param format A URL format (i.e. "users/:id" or "logout")
 @param callback The callback to run when the URL is triggered in `open:`
 @param options Configuration for the route
 */
- (void)map:(NSString *)format toCallback:(RouterOpenCallback)callback withOptions:(DSRouterOptions *)options;
/**
 Map a URL format to an anonymous callback and `DSRouterOptions` options
 @param format A URL format (i.e. "users/:id" or "logout")
 @param controllerClass The `UIViewController` `Class` which will be instanstiated when the URL is triggered in `open:`
 */
- (void)map:(NSString *)format toController:(Class)controllerClass;
/**
 Map a URL format to an anonymous callback and `DSRouterOptions` options
 @param format A URL format (i.e. "users/:id" or "logout")
 @param controllerClass The `UIViewController` `Class` which will be instanstiated when the URL is triggered in `open:`
 @param options Configuration for the route, such as modal settings
 */
- (void)map:(NSString *)format toController:(Class)controllerClass withOptions:(DSRouterOptions *)options;

///-------------------------------
/// @name Opening URLs
///-------------------------------

/**
 A convenience method for opening a URL using `UIApplication` `openURL:`.
 @param url The URL the OS will open (i.e. "http://google.com")
 */
- (void)openExternal:(NSString *)url;

/**
 Triggers the appropriate functionality for a mapped URL, such as an anonymous function or opening a `UIViewController`. `UIViewController` transitions will be animated;
 @param url The URL being opened (i.e. "users/16")
 @exception RouteNotFoundException Thrown if url does not have a valid mapping
 @exception NavigationControllerNotProvided Thrown if url opens a `UIViewController` and navigationController has not been assigned
 @exception RoutableInitializerNotFound Thrown if the mapped `UIViewController` instance does not implement -initWithRouterParams: or +allocWithRouterParams:
 */
- (void)open:(NSString *)url;

/**
 Triggers the appropriate functionality for a mapped URL, such as an anonymous function or opening a `UIViewController`
 @param url The URL being opened (i.e. "users/16")
 @param animated Whether or not `UIViewController` transitions are animated.
 @exception RouteNotFoundException Thrown if url does not have a valid mapping
 @exception NavigationControllerNotProvided Thrown if url opens a `UIViewController` and navigationController has not been assigned
 @exception RoutableInitializerNotFound Thrown if the mapped `UIViewController` instance does not implement -initWithRouterParams: or +allocWithRouterParams:
 */
- (void)open:(NSString *)url animated:(BOOL)animated;

/**
 Triggers the appropriate functionality for a mapped URL, such as an anonymous function or opening a `UIViewController`
 @param url The URL being opened (i.e. "users/16")
 @param animated Whether or not `UIViewController` transitions are animated.
 @param extraParams more paramters to pass in while opening a `UIViewController`; take priority over route-specific default parameters
 @exception RouteNotFoundException Thrown if url does not have a valid mapping
 @exception NavigationControllerNotProvided Thrown if url opens a `UIViewController` and navigationController has not been assigned
 @exception RoutableInitializerNotFound Thrown if the mapped `UIViewController` instance does not implement -initWithRouterParams: or +allocWithRouterParams:
 */
- (void)open:(NSString *)url animated:(BOOL)animated extraParams:(NSDictionary *)extraParams;

/**
 Get params of a given URL, simply return the params dictionary NOT using a block
 @param url The URL being detected (i.e. "users/16")
 */
- (NSDictionary*)paramsOfUrl:(NSString*)url;

@end

@interface DSRouter : JCRouter

/**
 A singleton instance of `UPRouter` which can be accessed anywhere in the app.
 @return A singleton instance of `UPRouter`.
 */
+ (instancetype)sharedRouter;

/**
 A new instance of `UPRouter`, in case you want to use multiple routers in your app.
 @remarks Unnecessary method; can use [[Routable alloc] init] instead
 @return A new instance of `UPRouter`.
 */
+ (instancetype)newRouter;

@end
