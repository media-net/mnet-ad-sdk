//
//  MNet.h
//  MNetAdSdk
//
//  Created by kunal.ch on 14/09/18.
//

#import "MNetUser.h"
#import <Foundation/Foundation.h>

@interface MNet : NSObject

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MNetGdprConsentStatus) {
    MNetGdprConsentStatusUnknown = 0, // Consent is UNKNOWN
    MNetGdprConsentStatusGiven   = 1, // Consented
    MNetGdprConsentStatusRevoked = 2, // Not consented
};

typedef NS_ENUM(NSInteger, MNetSubjectToGdpr) {
    MNetSubjectoToGdprUnknown = -1, // GDPR applicability is UNKNOWN
    MNetSubjectToGdprDisabled = 0,  // GDPR not applicable
    MNetSubjectToGdprEnabled  = 1,  // GDPR applicable
};

- (instancetype)init __attribute__((unavailable("Please use +initWithCustomerId:")));

@property (atomic, nullable) MNetUser *user;

/// Initialises the MNetAdSdk for a given customer Id.
/// This can be run only once in a session.
/// NOTE: Use the other intializer `initWithCustomerId:appContainsChildDirectedContent`
/// to specify if the app contains child directed content.
/// It defaults to NO in this call.
+ (instancetype)initWithCustomerId:(NSString *)customerId;

/// Initialises the MNetAdSdk for a given customer Id along with
/// specifying if the app contains child directed content.
+ (instancetype)initWithCustomerId:(NSString *)customerId
    appContainsChildDirectedContent:(BOOL)containsChildDirectedContent;

/// The current instance of MNet
+ (instancetype)getInstance;

/// The customer Id of the MNetAdSdk
+ (NSString *_Nullable)getCustomerId;

/// Logs all MNet ad related logs.
/// It is NO by default.
/// *** Do NOT enable logs in production apps ***
+ (void)enableLogs:(BOOL)enabled;

/// Call this method to set the consent for Media.Net.
/// Parameters -
/// ConsentString - NSString representing the consent string
/// ConsentStatus - An enum to specify the consent status.
///                 Enum options -
///                 MNetDfpHbGdprConsentStatusUnknown // Consent is UNKNOWN
///                 MNetDfpHbGdprConsentStatusGiven   // Consented
///                 MNetDfpHbGdprConsentStatusRevoked // Not consented
/// SubjectToGdpr - An enum to specify if subject to GDPR
///                 Enum options -
///                 MNetDfpHbSubjectoToGdprUnknown // GDPR applicability is UNKNOWN
///                 MNetDfpHbSubjectToGdprDisabled // GDPR not applicable
///                 MNetDfpHbSubjectToGdprEnabled  // GDPR applicable
+ (void)updateGdprConsentString:(NSString *)consentString
                  consentStatus:(MNetGdprConsentStatus)status
                  subjectToGdpr:(MNetSubjectToGdpr)subjectToGdpr;

NS_ASSUME_NONNULL_END

@end
