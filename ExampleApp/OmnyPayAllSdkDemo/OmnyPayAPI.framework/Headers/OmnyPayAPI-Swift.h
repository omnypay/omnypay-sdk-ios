// Generated by Apple Swift version 2.3 (swiftlang-800.10.13 clang-800.0.42.1)
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
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
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
#if defined(__has_feature) && __has_feature(modules)
@import ObjectiveC;
@import Foundation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"


/// The Basket represents an active shopping session, which includes product line items, discount offers, payment instrument selections, split tender details and loyalty points.
SWIFT_CLASS("_TtC10OmnyPayAPI6Basket")
@interface Basket : NSObject

/// UUID basket identifier
@property (nonatomic, copy) NSString * _Nullable id;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


@interface Basket (SWIFT_EXTENSION(OmnyPayAPI))
@end



/// The BasketReceipt represents a Payment receipt of active shopping session, which includes product line items, discount offers, selected payment instrument, final reconciled totals for selected payment instrument and loyalty redemption status.
SWIFT_CLASS("_TtC10OmnyPayAPI13BasketReceipt")
@interface BasketReceipt : NSObject

/// UUID payment-instrument identifier
@property (nonatomic, copy) NSString * _Nullable paymentInstrumentId;

/// UUID basket identifier
@property (nonatomic, copy) NSString * _Nullable id;
@end


@interface BasketReceipt (SWIFT_EXTENSION(OmnyPayAPI))
@end


@interface NSDate (SWIFT_EXTENSION(OmnyPayAPI))
@end



/// Type adopting OmnyPayEventDelegate protocol can be used to listen for callbacks that are delivered when any OmnyPay event occurs. All the callback functions are called on main queue. Delegate of OmnyPayEventListener must adopt this protocol.
SWIFT_PROTOCOL("_TtP10OmnyPayAPI20OmnyPayEventDelegate_")
@protocol OmnyPayEventDelegate
@optional

/// Tells the delegate that current basket is updated with new items.
///
/// \param basket Updated Basket.
- (void)didUpdateBasket:(Basket * _Nonnull)basket;

/// Tells the delegate that a payment receipt has been received.
///
/// \param receipt Updated Basket receipt.
- (void)didReceiveReceipt:(BasketReceipt * _Nonnull)receipt;

/// Tells the delegate that a post payment offer has been received.
///
/// \param imageUrl URL of a offer image.
- (void)didReceivePostPaymentOffer:(NSString * _Nonnull)imageUrl;

/// Tells the delegate that the active transaction has been cancelled.
- (void)didCancelTransaction;
@end



/// A singleton object that can be used for listening OmnyPay events.
SWIFT_CLASS("_TtC10OmnyPayAPI20OmnyPayEventListener")
@interface OmnyPayEventListener : NSObject

/// Returns a shared singleton instance of OmnyPayEventListener.
+ (OmnyPayEventListener * _Nonnull)shared;

/// A delegate of OmnyPayEventDelegate type. All the event callbacks are delivered to this delegate instance.
@property (nonatomic, weak) id <OmnyPayEventDelegate> _Nullable delegate;
@end

#pragma clang diagnostic pop
