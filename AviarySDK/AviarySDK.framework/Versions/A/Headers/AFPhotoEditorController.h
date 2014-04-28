//
//  AFPhotoEditorViewController.h
//  AviarySDK
//
//  Copyright (c) 2014 Aviary. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Options for defining a set of premium add ons to enable.
 */
typedef NS_OPTIONS(NSUInteger, AFPhotoEditorPremiumAddOn) {
    /** The option indicating no premium add ons.*/
    AFPhotoEditorPremiumAddOnNone = 0,
    /** The option indicating the high resolution premium add on.*/
    AFPhotoEditorPremiumAddOnHiRes = 1 << 0,
    /** The option indicating the white labeling premium add on.*/
    AFPhotoEditorPremiumAddOnWhiteLabel = 1 << 1,
};

@class AFPhotoEditorController;
@class AFPhotoEditorSession;
@protocol AFInAppPurchaseManager;

/**
 Implement this protocol to be notified when the user is done using the editor.
 You are responsible for dismissing the editor when you (and/or your user) are
 finished with it.
 */
@protocol AFPhotoEditorControllerDelegate <NSObject>
@optional

/**
 Implement this method to be notified when the user presses the "Done" button.
 
 The edited image is passed via the `image` parameter. The size of this image may
 not be equivalent to the size of the input image, if the input image is larger
 than the maximum image size supported by the SDK. Currently (as of 9/19/12), the
 maximum size is {1024.0, 1024.0} pixels on all devices.
 
 @param editor The photo editor controller.
 @param image The edited image.
 
 
 */
- (void)photoEditor:(AFPhotoEditorController *)editor finishedWithImage:(UIImage *)image;

/**
 Implement this method to be notified when the user presses the "Cancel" button.
 
 @param editor The photo editor controller.
 */
- (void)photoEditorCanceled:(AFPhotoEditorController *)editor;

@end

/**
 This class encapsulates the Aviary SDK's photo editor. Present this view controller to provide the user with a fast
 and powerful image editor. Be sure that you don't forget to set the delegate property
 to an object that conforms to the AFPhotoEditorControllerDelegate protocol.
 */
@interface AFPhotoEditorController : UIViewController

/**
 Configures the SDK's API Key and Secret. You must provide these before instantiating an
 instance of AFPhotoEditorController. Not doing so will throw an exception. All API keys and secrets
 are validated with Aviary's server. If the provided key and secret do not match the ones created for
 your application, a UIAlertView will be displayed alerting you to the failed validation.
 
 @param apiKey your app's API key
 @param secret your app's secret
 */
+ (void)setAPIKey:(NSString *)apiKey secret:(NSString *)secret;

/**
 Configures the Premium add-ons that SDK will use. By default there are no premium add-ons enabled.
 The SDK will validate these add-ons on the server.
 
 @param premiumAddOns bitmask of the add-ons to enable
 */
+ (void)setPremiumAddOns:(AFPhotoEditorPremiumAddOn)premiumAddOns;

/**
 Initialize the photo editor controller with an image.
 
 @param image The image to edit.
 */
- (instancetype)initWithImage:(UIImage *)image;

/**
 The photo editor's delegate.
 */
@property (nonatomic, weak) id<AFPhotoEditorControllerDelegate> delegate;

/**
 An AFPhotoEditorSession instance that tracks user actions within the photo editor. This can be used for high-resolution
 processing.
 */
@property (nonatomic, strong, readonly) AFPhotoEditorSession *session;

/**
 @return The SDK version number.
 */
+ (NSString *)versionString;

@end

@interface AFPhotoEditorController (InAppPurchase)

/**
 The handler object for purchasing consumable content. In order for in-app
 purchase to function correctly, you must add the object returned by this method
 as an observer of the default SKPaymentQueue. In your app delegate's
 -finishedLaunchingWithOptions: method, you should call startObservingTransactions
 on the in app purchase manager.
 
 Please see the Aviary iOS SDK In-App Purchase Guide for more information about
 in-app purchases.
 
 Please refer to AFInAppPurchaseManager.h for the definition of the AFInAppPurchaseManager protocol

 @see AFInAppPurchaseManager
 @see AFInAppPurchaseManagerDelegate
 @see [AFInAppPurchaseManager startObservingTransactions] and [AFInAppPurchaseManager stopObservingTransactions]
 
 @return The manager.
 */
+ (id<AFInAppPurchaseManager>)inAppPurchaseManager;

@end
