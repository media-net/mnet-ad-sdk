//
//  MNetAdSize.h
//  MNetAdSdk
//
//  Created by kunal.ch on 21/09/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MNetAdSize;

/// Helper function to create MNetAdSize instance
extern MNetAdSize *_Nullable MNetCreateAdSizeFromCGSize(CGSize size);

/// The banner ad size - 320x50
extern CGSize const kMNetBannerAdSize;

/// The medium ad size - 300x250
extern CGSize const kMNetMediumAdSize;

/// Helper function to to CGSize from MNBaseSize
extern CGSize MNetCGSizeFromAdSize(MNetAdSize *_Nonnull adSize);

@interface MNetAdSize : NSObject

/// Initialize with height and width
- (instancetype)initWithWidth:(NSInteger)width andHeight:(NSInteger)height;

/// Adsize height
@property (atomic, nonnull) NSNumber *h;

/// Adsize width
@property (atomic, nonnull) NSNumber *w;

@end
