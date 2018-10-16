//
//  MNetError.h
//  MNetAdSdk
//
//  Created by kunal.ch on 21/09/18.
//

#import <Foundation/Foundation.h>

@interface MNetError : NSObject

NS_ASSUME_NONNULL_BEGIN

/// Returns the error description
- (NSString *)getErrorDescriptionString;

/// Returns the error reason
- (NSString *)getErrorReasonString;

/// Get the Error object from MNetError
- (NSError *)getError;

NS_ASSUME_NONNULL_END

@end
