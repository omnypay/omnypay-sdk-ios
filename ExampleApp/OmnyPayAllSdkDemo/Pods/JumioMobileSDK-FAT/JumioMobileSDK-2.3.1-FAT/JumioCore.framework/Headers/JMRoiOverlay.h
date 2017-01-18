//
//  JMOverlay.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import "JMBaseView.h"
@class JMRoi;
@class JMRoiSettings;

@interface JMRoiOverlay : JMBaseView {
    @protected
    
    UIColor*    _fillColor;
    CGSize      _roiDropShadowOffset;
    CGFloat     _roiDropShadowBlurRadius;
    UIColor*    _roiDropShadowColor;
    
    CGFloat _roiAspectRatio;
    UIEdgeInsets _contentInset;
    
    NSArray * _portraitLayoutConstraints;
    NSArray * _landscapeLayoutConstraints;
    
    NSLayoutConstraint * _portraitRoiAspectRatioConstraint;
    NSLayoutConstraint * _landscapeRoiAspectRatioConstraint;
    
    NSLayoutConstraint * _contentInsetLeftLayoutConstraint;
    NSLayoutConstraint * _contentInsetRightLayoutConstraint;
    NSLayoutConstraint * _contentInsetBottomLayoutConstraint;
    NSLayoutConstraint * _contentInsetTopLayoutConstraint;
    
    NSLayoutConstraint * _portraitRoiOffset;
}

@property (nonatomic, strong) JMRoi * roi;
@property (nonatomic, strong) JMRoiSettings * roiSettings;
@property (nonatomic, assign, readonly) UIEdgeInsets contentInset;
@property (nonatomic, strong, readonly) UIImageView* brandingLogoImageView;

- (instancetype)initWithRoiAspectRatio:(CGFloat)aspectRatio;
- (void)setRoiAspectRatio:(CGFloat)aspectRatio;
- (void)setContentInsets:(UIEdgeInsets)insets;

- (NSLayoutConstraint*)portraitRoiAspectRatioConstraint;
- (NSLayoutConstraint*)landscapeRoiAspectRatioConstraint;

- (NSArray*)portraitLayoutConstraints;
- (void)updateConstraintsFromPortraitConstraints:(NSArray*)constraints;

- (NSArray*)landscapeLayoutConstraints;
- (void)updateConstraintsFromLandscapeConstraints:(NSArray *)constraints;

- (NSArray*)brandingLogoPositionConstraints;
- (void)setBrandingLogoHidden:(BOOL)hidden;
- (void)setRoiOffset:(CGPoint)offset;

@end
