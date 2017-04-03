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
enum IdentityDocumentType : NSInteger;

/// An instance that represents the configuration of identity scanner. Apart from documentType and country, a custom dictionary can also be provided for any other information that an application wants to pass.
SWIFT_CLASS("_TtC15OmnyPayIdentity14IdentityConfig")
@interface IdentityConfig : NSObject
/// A read-only property to get an <code>IdentityDocumentType</code> configured to be scanned.
@property (nonatomic, readonly) enum IdentityDocumentType documentType;
/// Property to initially display a particular country as selected. By default, USA will be selected.
@property (nonatomic, readonly, copy) NSString * _Nonnull preselectedCountry;
/// A convenience initializer that initializes <code>IdentityConfig</code> from another identityConfig object
/// \param config A <code>IdentityConfig</code> object
///
///
/// returns:
/// An instance of <code>IdentityConfig</code>
- (nonnull instancetype)initWithConfiguration:(IdentityConfig * _Nonnull)config;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

@class NSDate;

/// An object of <code>IdentityDocument</code> represents the result of identity scan operation. This object contains details regarding the identity document that was scanned.
SWIFT_CLASS("_TtC15OmnyPayIdentity16IdentityDocument")
@interface IdentityDocument : NSObject
/// A read only string value of id identified from scanned document.
@property (nonatomic, readonly, copy) NSString * _Nullable idNumber;
/// A read only string value of first name of person identified from scanned document.
@property (nonatomic, readonly, copy) NSString * _Nullable firstName;
/// A read only string value of last name of person identified from scanned document.
@property (nonatomic, readonly, copy) NSString * _Nullable lastName;
/// A read only value representing date of birth of person identified from scanned document.
@property (nonatomic, readonly, strong) NSDate * _Nullable dob;
/// A read only string value containing the address identified from scanned document.
@property (nonatomic, readonly, copy) NSString * _Nullable address;
/// A read only string value representing the city identified from scanned document.
@property (nonatomic, readonly, copy) NSString * _Nullable city;
/// A read only string value representing the originating country identified from scanned document.
@property (nonatomic, readonly, copy) NSString * _Nullable originatingCountry;
/// A read only string value representing the sub division area where person identified from scanned document resides.
@property (nonatomic, readonly, copy) NSString * _Nullable subdivision;
/// A read only string value representing the pin/postal code of area where the person identified from scanned document resides.
@property (nonatomic, readonly, copy) NSString * _Nullable postCode;
/// A read only <code>IdentityDocumentType</code> which represents the type of document that was scanned.
@property (nonatomic, readonly) enum IdentityDocumentType documentType;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


@interface IdentityDocument (SWIFT_EXTENSION(OmnyPayIdentity))
/// The textual representation used when written to an output stream, in the form of a cURL command.
@property (nonatomic, readonly, copy) NSString * _Nonnull debugDescription;
@end

/// <code>IdentityDocumentType</code> represents the type of document to be scanned.
typedef SWIFT_ENUM(NSInteger, IdentityDocumentType) {
/// Driver License
  IdentityDocumentTypeDriverLicense = 0,
/// Passport
  IdentityDocumentTypePassport = 1,
/// Identity Card
  IdentityDocumentTypeIdentityCard = 2,
/// Visa
  IdentityDocumentTypeVisa = 3,
};

@class NSError;

/// An object of <code>IdentityResult</code> represents the results of identity scan operation. This object contains a <code>IdentityDocument</code> value that contains the properties of the document scanned.It also contains an error if scanning fails.
SWIFT_CLASS("_TtC15OmnyPayIdentity14IdentityResult")
@interface IdentityResult : NSObject
/// <code>IdentityDocument</code> value that contains the properties of the document scanned.
@property (nonatomic, readonly, strong) IdentityDocument * _Nullable identitydocument;
/// An error that tells the reason in case document scanning fails.
@property (nonatomic, readonly, strong) NSError * _Nullable error;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

@class UIViewController;

/// A final class that can be used to scan a credit card.
/// This class provides a singleton instance that is initialized with a default configuration of <code>IdentityConfig</code> type. For most of the purposes this singleton instance should be enough.
/// For any custom usage a new instance of this class can be created by providing a custom configuration.
SWIFT_CLASS("_TtC15OmnyPayIdentity15OmnyPayIdentity")
@interface OmnyPayIdentity : NSObject
/// A shared instance of <code>OmnyPayIdentity</code>, initialized with default <code>IdentityConfig</code>
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) OmnyPayIdentity * _Nonnull shared;)
+ (OmnyPayIdentity * _Nonnull)shared SWIFT_WARN_UNUSED_RESULT;
/// A block that is called when scanning is completed.
/// It takes a <code>IdentityResult</code> as parameter and returns nothing.
@property (nonatomic, copy) void (^ _Nullable documentDidScanHandler)(IdentityResult * _Nonnull);
/// Creates an instance of <code>OmnyPayIdentity</code>
/// \param configuration An object of <code>IdentityConfig</code> type. If nothing is passed in this parameter default configuration is used.
///
///
/// returns:
/// An instance of <code>OmnyPayIdentity</code>
- (nonnull instancetype)initWith:(IdentityConfig * _Nonnull)configuration OBJC_DESIGNATED_INITIALIZER;
/// Creates an instance of <code>OmnyPayIdentity</code> with default <code>IdentityConfig</code>.
///
/// returns:
/// An instance of <code>OmnyPayIdentity</code>
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
/// Present a identity scan view modally over provided viewcontroller
/// \param viewController A view controller over which identity scan view is to be presented.
///
/// \param animated Pass <code>true</code> to animate the presentation; otherwise, pass <code>false</code>.
///
/// \param handler The block to execute after the presentation finishes. This block has no return value and takes two parameters. You may specify nil for this parameter.
/// This completion handler takes the following parameters:
/// <code>success</code> - A Boolean to indicate whether presentation is successful.
/// <code>error</code> - An NSError object that indicates why the presentation failed, or nil if the presentation is successful.
///
- (void)presentIdentityScanViewWithOver:(UIViewController * _Nonnull)viewController animated:(BOOL)animated handler:(void (^ _Nullable)(BOOL, NSError * _Nullable))handler;
/// Dismiss identity scan view
/// \param animated Pass <code>true</code> to animate the dismissal; otherwise, pass <code>false</code>.
///
/// \param completion The block to execute after dismissing the identity scan view. This block has no return value and does not take any parameter.
///
- (void)dismissIdentityScanViewWithAnimated:(BOOL)animated completion:(void (^ _Nullable)(void))completion;
@end

#pragma clang diagnostic pop
