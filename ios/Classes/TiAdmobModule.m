/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2010-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiAdmobModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiApp.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface TiAdmobModule()<GADInterstitialDelegate> {
    GADInterstitial *interstitial_;
}

@property NSString* adUnitId;

@end

@implementation TiAdmobModule

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"0d005e93-9980-4739-9e41-fd1129c8ff32";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.admob";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] AdMob module loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark - added 1.9.1

- (void)startAdMobIntersBanner:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args)
    NSLog(@"%s%d args %@",__FUNCTION__,__LINE__,args);
    
    _adUnitId = [args objectAtIndex:0];
    NSLog(@"%s%d _adUnitId %@",__FUNCTION__,__LINE__,_adUnitId);
    
    [self loadAdMobIntersBanner];
    
}

- (void)presentInterstitialFromRootViewController:(id)args {
    NSLog(@"%s%d",__FUNCTION__,__LINE__);
    
    [interstitial_ presentFromRootViewController:[TiApp controller]];
}

// AdMobのインタースティシャル広告読み込み
- (void)loadAdMobIntersBanner
{
    NSLog(@"%s%d _adUnitId %@",__FUNCTION__,__LINE__,_adUnitId);
    
    
    interstitial_ = [[GADInterstitial alloc] initWithAdUnitID:_adUnitId];
    
    interstitial_.delegate = self;
    
    GADRequest *request = [GADRequest request];
    
    [interstitial_ loadRequest:request];
    
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Ad Request Lifecycle Notifications

/// Called when an interstitial ad request succeeded. Show it at the next transition point in your
/// application such as when transitioning between view controllers.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"%s%d",__FUNCTION__,__LINE__);
    [self fireEvent:@"interstitialDidReceiveAd"];
}

/// Called when an interstitial ad request completed without an interstitial to
/// show. This is common since interstitials are shown sparingly to users.
- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"%s%d",__FUNCTION__,__LINE__);
    
}

#pragma mark Display-Time Lifecycle Notifications

/// Called just before presenting an interstitial. After this method finishes the interstitial will
/// animate onto the screen. Use this opportunity to stop animations and save the state of your
/// application in case the user leaves while the interstitial is on screen (e.g. to visit the App
/// Store from a link on the interstitial).
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    NSLog(@"%s%d",__FUNCTION__,__LINE__);
    
}

/// Called before the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    NSLog(@"%s%d",__FUNCTION__,__LINE__);
    
}

/// Called just after dismissing an interstitial and it has animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    NSLog(@"%s%d",__FUNCTION__,__LINE__);
    [self loadAdMobIntersBanner];
    
}

/// Called just before the application will background or terminate because the user clicked on an
/// ad that will launch another application (such as the App Store). The normal
/// UIApplicationDelegate methods, like applicationDidEnterBackground:, will be called immediately
/// before this.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    NSLog(@"%s%d",__FUNCTION__,__LINE__);
    
}


#pragma mark Constants

@end
