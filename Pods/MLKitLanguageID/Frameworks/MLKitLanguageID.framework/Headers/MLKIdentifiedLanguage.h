#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** An identified language for the given input text. */
NS_SWIFT_NAME(IdentifiedLanguage)
@interface MLKIdentifiedLanguage : NSObject

/** The [BCP 47 language tag](https://tools.ietf.org/rfc/bcp/bcp47.txt) for the language. */
@property(nonatomic, readonly, copy) NSString *languageTag;

/** The confidence score of the language. */
@property(nonatomic, readonly) float confidence;

/** Unavailable. */
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
