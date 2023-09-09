#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * @memberof `LanguageIdentificationOptions`
 * The default confidence threshold for identifying the main language in the given input text.
 */
extern const float kMLKDefaultIdentifyLanguageConfidenceThreshold
    NS_SWIFT_NAME(DefaultIdentifyLanguageConfidenceThreshold);

/**
 * @memberof `LanguageIdentificationOptions`
 * The default confidence threshold for identifying possible languages in the given input text.
 */
extern const float kMLKDefaultIdentifyPossibleLanguagesConfidenceThreshold
    NS_SWIFT_NAME(DefaultIdentifyPossibleLanguagesConfidenceThreshold);

/** Options for `LanguageIdentification`. */
NS_SWIFT_NAME(LanguageIdentificationOptions)
@interface MLKLanguageIdentificationOptions : NSObject

/**
 * The confidence threshold for language identification. The identified languages will have a
 * confidence higher or equal to the confidence threshold. The value should be between 0 and 1.
 * If an invalid value is set, the default value is used instead. The default value for identifying
 * the main language is `DefaultIdentifyLanguageConfidenceThreshold` and for identifying possible
 * languages is `DefaultIdentifyPossibleLanguagesConfidenceThreshold`.
 */
@property(nonatomic, readonly) float confidenceThreshold;

/**
 * Creates a new instance of language identification options with the given confidence threshold.
 * @param confidenceThreshold The confidence threshold for language identification.
 * @return A new instance of `LanguageIdentificationOptions` with the given confidence threshold.
 */
- (instancetype)initWithConfidenceThreshold:(float)confidenceThreshold NS_DESIGNATED_INITIALIZER;

/** Unavailable. Use `init(confidenceThreshold:)` instead. */
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
