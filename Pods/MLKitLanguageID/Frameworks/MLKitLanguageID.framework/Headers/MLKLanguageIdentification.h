#import <Foundation/Foundation.h>

@class MLKIdentifiedLanguage;
@class MLKLanguageIdentificationOptions;

NS_ASSUME_NONNULL_BEGIN

/** The [BCP 47 language tag](https://tools.ietf.org/rfc/bcp/bcp47.txt) for an undetermined
 * language. */
extern NSString *const MLKUndeterminedLanguageTag NS_SWIFT_NAME(IdentifiedLanguage.undetermined);

/**
 * A block that handles a language identification result.
 *
 * @param languageTag The identified language tag for the text, `IdentifiedLanguage.undetermined` if
 * no language was identified, or `nil` if there was an error.
 * @param error The error or `nil`.
 */
typedef void (^MLKIdentifyLanguageCallback)(NSString *_Nullable languageTag,
                                            NSError *_Nullable error)
    NS_SWIFT_NAME(IdentifyLanguageCallback);

/**
 * A block that handles the result of identifying possible languages.
 *
 * @param identifiedLanguages The list of identified languages for the text, or `nil` in case of an
 * error. If no languages were identified, the result will consist of a single element with the
 * language `IdentifiedLanguage.undetermined` and confidence 1.
 * @param error The error or `nil`.
 */
typedef void (^MLKIdentifyPossibleLanguagesCallback)(
    NSArray<MLKIdentifiedLanguage *> *_Nullable identifiedLanguages, NSError *_Nullable error)
    NS_SWIFT_NAME(IdentifyPossibleLanguagesCallback);

/**
 * The `LanguageIdentification` class that identifies the main language or possible languages for
 * the given text.
 */
NS_SWIFT_NAME(LanguageIdentification)
@interface MLKLanguageIdentification : NSObject

/**
 * Gets a language identification instance with the default options.
 *
 * @return A new instance of `LanguageIdentification` with the default options.
 */
+ (MLKLanguageIdentification *)languageIdentification NS_SWIFT_NAME(languageIdentification());

/**
 * Gets a language identification instance with the given options.
 *
 * @param options The options used for language identification.
 * @return A new instance of `LanguageIdentification` with the given options.
 */
+ (MLKLanguageIdentification *)languageIdentificationWithOptions:
    (MLKLanguageIdentificationOptions *)options NS_SWIFT_NAME(languageIdentification(options:));

/**
 * Identifies the main language for the given text.
 *
 * @param text The input text to use for identifying the language. Inputs longer than 200 characters
 *     are truncated to 200 characters, as longer input does not improve the detection accuracy.
 * @param completion Handler to call back on the main queue with the identified language tag or
 *     error.
 */
- (void)identifyLanguageForText:(NSString *)text
                     completion:(MLKIdentifyLanguageCallback)completion
    NS_SWIFT_NAME(identifyLanguage(for:completion:));

/**
 * Identifies possible languages for the given text.
 *
 * @param text The input text to use for identifying the language. Inputs longer than 200 characters
 *     are truncated to 200 characters, as longer input does not improve the detection accuracy.
 * @param completion Handler to call back on the main queue with identified languages or error.
 */
- (void)identifyPossibleLanguagesForText:(NSString *)text
                              completion:(MLKIdentifyPossibleLanguagesCallback)completion
    NS_SWIFT_NAME(identifyPossibleLanguages(for:completion:));

/**
 * Unavailable.
 */
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
