// Generated by Apple Swift version 3.1 (swiftlang-802.0.48 clang-802.0.38)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if defined(__has_attribute) && __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if defined(__has_attribute) && __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class PIScanResult;
@class PIScanConfig;
@class UIViewController;
@class NSError;

/// A final class that can be used to scan a credit card.
/// This class provides a singleton instance that is initialized with a default configuration of <code>PIScanConfig</code> type. For most of the purposes this singleton instance should be enough.
/// For any custom usage a new instance of this class can be created by providing a custom configuration.
SWIFT_CLASS("_TtC13OmnyPayPIScan13OmnyPayPIScan")
@interface OmnyPayPIScan : NSObject
/// A shared instance of <code>OmnyPayPIScan</code>, initialized with default <code>PIScanConfig</code>
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) OmnyPayPIScan * _Nonnull sharedInstance;)
+ (OmnyPayPIScan * _Nonnull)sharedInstance SWIFT_WARN_UNUSED_RESULT;
/// A block that is called when scanning is completed.
/// It takes a <code>PIScanResult</code> as parameter and returns nothing.
@property (nonatomic, copy) void (^ _Nullable cardDidScanHandler)(PIScanResult * _Nonnull);
/// Creates an instance of <code>OmnyPayPIScan</code>
/// \param configuration An object of <code>PIScanConfig</code> type. If nothing is passed in this parameter default configuration is used.
///
///
/// returns:
/// An instance of <code>OmnyPayPIScan</code>
- (nonnull instancetype)initWith:(PIScanConfig * _Nonnull)configuration OBJC_DESIGNATED_INITIALIZER;
/// Creates an instance of <code>OmnyPayPIScan</code>
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
/// Present a card scan view modally over provided viewcontroller
/// \param viewController A view controller over which card scan view is to be presented.
///
/// \param animated Pass <code>true</code> to animate the presentation; otherwise, pass <code>false</code>.
///
/// \param handler The block to execute after the presentation finishes. This block has no return value and takes two parameters. You may specify nil for this parameter.
/// This completion handler takes the following parameters:
/// <code>success</code> - A Boolean to indicate whether presentation is successful.
/// <code>error</code> - An NSError object that indicates why the presentation failed, or nil if the presentation is successful.
///
- (void)presentCardScanViewWithOver:(UIViewController * _Nonnull)viewController animated:(BOOL)animated handler:(void (^ _Nullable)(BOOL, NSError * _Nullable))handler;
/// Dismiss card scan view
/// \param animated Pass <code>true</code> to animate the dismissal; otherwise, pass <code>false</code>.
///
/// \param completion The block to execute after dismissing the card scan view. This block has no return value and does not take any parameter.
///
- (void)dismissCardScanViewWithAnimated:(BOOL)animated completion:(void (^ _Nullable)(void))completion;
@end


/// An object of <code>PICard</code> represents the result of card scan operation. This object contains details regarding the credit card that was scanned.
SWIFT_CLASS("_TtC13OmnyPayPIScan6PICard")
@interface PICard : NSObject
/// A read only string value to get card alias
@property (nonatomic, readonly, copy) NSString * _Nullable cardAlias;
/// A read only string value to get card expiry date in MM/YY format
@property (nonatomic, readonly, copy) NSString * _Nullable cardExpiryDate;
/// A read only string value to get card holder name
@property (nonatomic, readonly, copy) NSString * _Nullable cardHolderName;
/// A read only string value to get card holder zip
@property (nonatomic, readonly, copy) NSString * _Nullable cardHolderZip;
/// A read only string value to get card issuer name
@property (nonatomic, readonly, copy) NSString * _Nullable cardIssuer;
/// A read only string value to get card number
@property (nonatomic, readonly, copy) NSString * _Nullable cardNumber;
/// A read only string value to get card pin / cvv
@property (nonatomic, readonly, copy) NSString * _Nullable cardPin;
/// A read only string value to get card number in grouped form
@property (nonatomic, readonly, copy) NSString * _Nullable cardNumberGrouped;
/// A read only string value to get card number in masked format
@property (nonatomic, readonly, copy) NSString * _Nullable cardNumberMasked;
/// A read only string value to get month from card expiry date
@property (nonatomic, readonly, copy) NSString * _Nullable cardExpiryMonth;
/// A read only string value to get year from card expiry date
@property (nonatomic, readonly, copy) NSString * _Nullable cardExpiryYear;
/// A read only string value to get UK account number
@property (nonatomic, readonly, copy) NSString * _Nullable cardAccountNumber;
/// A read only string value to get UK sort code
@property (nonatomic, readonly, copy) NSString * _Nullable cardSortCode;
/// A read only String value to determine type of card i.e. Debit Card / Credit Card / Charge Card
@property (nonatomic, readonly, copy) NSString * _Nullable cardType;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


@interface PICard (SWIFT_EXTENSION(OmnyPayPIScan))
/// The textual representation used when written to an output stream, in the form of a cURL command.
@property (nonatomic, readonly, copy) NSString * _Nonnull debugDescription;
@end


/// An instance that represents the configuration of identity scanner. Apart from documentType and country, a custom dictionary can also be provided for any other information that an application wants to pass.
SWIFT_CLASS("_TtC13OmnyPayPIScan12PIScanConfig")
@interface PIScanConfig : NSObject
/// A boolean value to specify whether CVV is required or not.
@property (nonatomic, readonly) BOOL cvvRequired;
/// A boolean value to specify whether expiry date is editable or not.
@property (nonatomic, readonly) BOOL expiryDateEditable;
/// A boolean value to specify whether card holder name is editable or not.
@property (nonatomic, readonly) BOOL cardHolderNameEditable;
/// A boolean value to specify whether card number should be masked or not while editing card details.
@property (nonatomic, readonly) BOOL cardNumberMaskingEnabled;
/// A convenience initializer that initialize <code>PIScanConfig</code> from another PIScanConfig object
/// \param config A <code>PIScanConfig</code> object
///
///
/// returns:
/// An instance of <code>PIScanConfig</code>
- (nonnull instancetype)initWithConfiguration:(PIScanConfig * _Nonnull)config;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// An object of <code>PIScanResult</code> represents the results of card scan operation. This object contains a <code>PICard</code> value that contains the properties of the card scanned. It also contains an error if scanning fails.
SWIFT_CLASS("_TtC13OmnyPayPIScan12PIScanResult")
@interface PIScanResult : NSObject
/// <code>PICard</code> object that contains the properties of the card scanned.
@property (nonatomic, readonly, strong) PICard * _Nullable piCard;
/// An error that tells the reason in case document scanning fails.
@property (nonatomic, readonly, strong) NSError * _Nullable error;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

#pragma clang diagnostic pop
