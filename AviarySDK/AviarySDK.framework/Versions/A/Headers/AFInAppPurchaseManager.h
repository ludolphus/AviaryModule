//
//  AFInAppPurchaseManager.h
//  AviarySDK
//
//  Copyright (c) 2013-2014 Aviary. All rights reserved.
//

#import "AFPhotoEditorProduct.h"

/*
 This key controls the availability of non-consumable in-app purchases in the
 Effects tool. A valid value for this key is a boolean NSNumber (or
 kCFBoolean{True, False}). Pass YES or kCFBooleanTrue to enable in-app purchase
 for effects. This option is disabled by default.
 */
extern NSString *const kAFPhotoEditorEffectsIAPEnabledKey;

@protocol AFInAppPurchaseManager;
@protocol AFInAppPurchaseManagerDelegate;

@protocol AFInAppPurchaseManagerDelegate <NSObject>
@optional

/**
 Deprecated.
 
 If implemented by the photo editor's delegate, this method will be called
 just before requesting information about products available through in-app
 purchase via the StoreKit API. If you wish to provide a custom product identifier,
 then this method should return the product identifier registered in iTunes
 Connect for the provided product.
 
 @param manager The in app purchase manager.
 @param product The product for which to return the product identifier
 registered in iTunes Connect.
 @return The product identifier registered in iTunes Connect.
 
 @see AFPhotoEditorProduct
 */
- (NSString *)inAppPurchaseManager:(id<AFInAppPurchaseManager>)manager productIdentifierForProduct:(AFPhotoEditorProduct *)product DEPRECATED_ATTRIBUTE;

@end

/**
 This protocol is implemented by the object returned by
 [AFPhotoEditorController inAppPurchaseManager]. You should call these
 methods to activate and deactivate in-app purchase.
 
 @see AFPhotoEditorController (inAppPurchaseManager)
 */
@protocol AFInAppPurchaseManager <NSObject>

/**
 Deprecated.
 
 A delegate for handling in-app purchase-related callbacks, including mapping
 internal product identifiers to developer-provided identifiers registered in
 iTunes Connect.
 
 @see AFInAppPurchaseManagerDelegate
 */
@property (nonatomic, weak) id<AFInAppPurchaseManagerDelegate> delegate DEPRECATED_ATTRIBUTE;

/**
 Indicates whether manager is observing transactions.
 
 @return YES if the in-app purchase manager is observing transactions (in-app
 purchase is enabled), NO otherwise.
 */
@property (nonatomic, assign, readonly, getter=isObservingTransactions) BOOL observingTransactions;

/**
 Call this method to start observing transactions. After calling this method,
 isObservingTransactions will return YES.
 */
- (void)startObservingTransactions;

/**
 Call this method to stop observing transactions. After calling this method,
 isObservingTransactions will return NO.
 */
- (void)stopObservingTransactions;

@end