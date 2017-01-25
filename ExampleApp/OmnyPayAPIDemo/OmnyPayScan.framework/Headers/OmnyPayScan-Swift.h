// Generated by Apple Swift version 3.0.1 (swiftlang-800.0.58.6 clang-800.0.42.1)
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
#if defined(__has_feature) && __has_feature(modules)
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class ScanResult;
@class ScanConfig;
@class UIViewController;
@class NSError;
@class UIView;

/**
  A final class that can be used to scan machine readable codes like QRCode, BarCode etc.
  This class provides a singleton instance that is initialized with a default configuration of \code
  ScanConfig
  \endcode type. For most of the purposes this singleton instance should be enough.
  For any custom usage a new instance of this class can be created by providing a custom configuration.
*/
SWIFT_CLASS("_TtC11OmnyPayScan11OmnyPayScan")
@interface OmnyPayScan : NSObject
/**
  A shared instance of \code
  OmnyPayScan
  \endcode, initialized with default \code
  ScanConfig
  \endcode
*/
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) OmnyPayScan * _Nonnull sharedInstance;)
+ (OmnyPayScan * _Nonnull)sharedInstance;
/**
  A block that is called when scanning is completed.
  It takes a \code
  ScanResult
  \endcode as parameter and returns nothing.
*/
@property (nonatomic, copy) void (^ _Nullable didScanHandler)(ScanResult * _Nonnull);
/**
  Configuration of \code
  OmnyPayScan
  \endcode instance. It is a read-only property
*/
@property (nonatomic, readonly, strong) ScanConfig * _Nonnull configuration;
/**
  Creates an instance of \code
  OmnyPayScan
  \endcode
  \param configuration An object of \code
  ScanConfig
  \endcode type. If nothing is passed in this parameter default scan configuration is used.


  returns:
  An instance of \code
  OmnyPayScan
  \endcode
*/
- (nonnull instancetype)initWith:(ScanConfig * _Nonnull)configuration OBJC_DESIGNATED_INITIALIZER;
/**
  Present a scan view modally over provided viewcontroller
  \param viewController A view controller over which scan view to be presented

  \param animated Pass \code
  true
  \endcode to animate the presentation; otherwise, pass \code
  false
  \endcode.

  \param handler The block to execute after the presentation finishes. This block has no return value and takes two parameters. You may specify nil for this parameter.
  This completion handler takes the following parameters:
  \code
  success
  \endcode - A Boolean to indicate whether presentation is successful.
  \code
  error
  \endcode - An NSError object that indicates why the presentation failed, or nil if the presentation is successful.

*/
- (void)presentScanViewWithOver:(UIViewController * _Nonnull)viewController animated:(BOOL)animated handler:(void (^ _Nullable)(BOOL, NSError * _Nullable))handler;
/**
  Dismisses the scan view that was presented modally over the view controller passed in \code
  presentScanView(over:animated:hadler)
  \endcode
  If \code
  scanMode
  \endcode property of receiver object’s config (\code
  ScanConfig
  \endcode) is \code
  Single
  \endcode then scan view is automatically dismissed once a single code is scanned. In all other cases the presenting view controller is responsible for dismissing the scan view it presented.
  \param animated Pass \code
  true
  \endcode to animate the dismissal; otherwise, pass \code
  false
  \endcode.

  \param completion The block to execute after the scan view is dismissed. This block has no return value and takes no parameter. You may specify nil for this parameter.

*/
- (void)dismissScanViewWithAnimated:(BOOL)animated completion:(void (^ _Nullable)(void))completion;
/**
  Add a scan view as subview to a UIView
  \param view Parent view that adds the scan view as subview

  \param handler The block to execute after the scan view is added. This block has no return value and takes two parameters. You may specify nil for this parameter.
  This completion handler takes the following parameters:
  \code
  success
  \endcode - A Boolean to indicate whether scan view is added successfully.
  \code
  error
  \endcode - An NSError object if the scan view is not added, nil otherwise.

*/
- (void)addScanViewInside:(UIView * _Nonnull)view handler:(void (^ _Nullable)(BOOL, NSError * _Nullable))handler;
/**
  Remove the scan view from it’s superview.
*/
- (void)removeScanView;
/**
  Start the scanning operation.
  If \code
  startScanningImmediately
  \endcode property of receiver object’s config (\code
  ScanConfig
  \endcode) is set to \code
  true
  \endcode scanning starts automatically when scan view is presented modally or added as subview, you do not need to call this function.
  Call this function if otherwise.
*/
- (void)start;
/**
  Stop the scanning operation.
  If \code
  scanMode
  \endcode property of receiver object’s config (\code
  ScanConfig
  \endcode) is set to \code
  Single
  \endcode then scanning automatically stops as soon as a single code is scanned and scan view is dismissed.
  In case of \code
  Batch
  \endcode scan mode call this function to stop scanning explicitly.
*/
- (void)stop;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

enum ScanMode : NSInteger;

/**
  An instance that represents the configuration of scanner. \code
  OmnyPayScan
  \endcode instance can be configured with custom scan mode, code types to scan, whether to start scanning as soon as scanner is presented and a custom dictionary for any other information.
*/
SWIFT_CLASS("_TtC11OmnyPayScan10ScanConfig")
@interface ScanConfig : NSObject
/**
  A read-only property to get \code
  ScanMode
  \endcode value
*/
@property (nonatomic, readonly) enum ScanMode scanMode;
/**
  A read-only property to check whether scanner starts scanning as soon as scanner is presented
*/
@property (nonatomic, readonly) BOOL startScanningImmediately;
/**
  A read-only propery to check what type of code a scanner can scan
*/
@property (nonatomic, readonly, copy) NSArray<NSString *> * _Nonnull codeTypes;
/**
  A convenience initializer that initialize \code
  ScanConfig
  \endcode from another scanconfig object
  \param config A \code
  ScanConfig
  \endcode object


  returns:
  An instance of \code
  ScanConfig
  \endcode
*/
- (nonnull instancetype)initWithConfiguration:(ScanConfig * _Nonnull)config;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


@interface ScanConfig (SWIFT_EXTENSION(OmnyPayScan))
@end

/**
  A type that represents the scanning mode of \code
  OmnyPayScan
  \endcode
  <ul>
    <li>
      Single: Single scan mode. Use this scan mode when a single machine code is to be scanned. Scanner view is dismissed after the scanning completes.
    </li>
    <li>
      Batch:  Batch scan mode. Use this scan mode where multiple machine codes are to be scanned.
      Scanner view continue to scan any code that is detected until \code
      stop()
      \endcode is called on \code
      OmnyPayScan
      \endcode instance. For each code that is scanned, \code
      didScanHandler
      \endcode is executed.
      Scanner view has to be explicitly closed/removed by calling \code
      dismissScanView(animated:, completion:)
      \endcode or \code
      removeScanView()
      \endcode on \code
      OmnyPayScan
      \endcode instance.
    </li>
  </ul>
*/
typedef SWIFT_ENUM(NSInteger, ScanMode) {
/**
  Single scan mode
*/
  ScanModeSingle = 0,
/**
  Batch scan mode
*/
  ScanModeBatch = 1,
};


/**
  An object of \code
  ScanResult
  \endcode represents the results of scan operation. This object contains a string value of scanned code, a meta type of code and an error if scanning fails.
*/
SWIFT_CLASS("_TtC11OmnyPayScan10ScanResult")
@interface ScanResult : NSObject
/**
  A string value of scanned code
*/
@property (nonatomic, readonly, copy) NSString * _Nullable value;
/**
  An type of scanned machine code. It is same as type of AVMetadataMachineReadableCodeObject instances representing the newly emitted metadata by scanner.
*/
@property (nonatomic, readonly, copy) NSString * _Nullable metadataType;
/**
  An error that tells the reason in case scanning fails.
*/
@property (nonatomic, readonly, strong) NSError * _Nullable error;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

#pragma clang diagnostic pop
