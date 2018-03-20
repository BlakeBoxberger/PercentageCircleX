@interface _UIBatteryView : UIView
@property NSInteger chargingState;
@property CGFloat chargePercent;
@property (nonatomic, copy, readwrite) UIColor *fillColor;
@property (nonatomic, retain) UILabel *nz9_percentLabel;
@property (nonatomic, retain) UIView *nz9_circleView;
- (void)nz9_initPercentLabel;
- (void)nz9_initCircleView;
- (UIColor *)nz9_colorFormula;
@end


%hook _UIBatteryView
%property (nonatomic, retain) UILabel *nz9_percentLabel;
%property (nonatomic, retain) UIView *nz9_circleView;

%new
- (void)nz9_initPercentLabel {
	self.nz9_percentLabel = [[UILabel alloc]initWithFrame:CGRectMake(1.75, -1.75, 10, 15)];// CGRectMake(0,0,self.frame.size.width -4, self.frame.size.height - 2)]; // CGRectMake(0, 0, 23, 10)];
	self.nz9_percentLabel.text = [NSString stringWithFormat:@"%i", (int)floor((self.chargePercent * 100))];
	self.nz9_percentLabel.font = [UIFont boldSystemFontOfSize: 9];
	self.nz9_percentLabel.adjustsFontSizeToFitWidth = YES;
	self.nz9_percentLabel.textAlignment = NSTextAlignmentCenter;
}

%new
- (void)nz9_initCircleView {
	self.nz9_circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
	self.nz9_circleView.layer.cornerRadius = 6.5f;
	self.nz9_circleView.layer.borderWidth = 1.25;
}

- (instancetype)initWithFrame:(CGRect)arg1 {
	self = %orig;
	[self nz9_initCircleView];
	[self nz9_initPercentLabel];
	[self addSubview: self.nz9_circleView];
	[self addSubview: self.nz9_percentLabel];
	return self;
}

- (void)setChargePercent:(CGFloat)percent {
	%orig;
	self.nz9_percentLabel.text = [NSString stringWithFormat:@"%i", (int)floor((self.chargePercent * 100))];
	if(percent == 1.0) {
		self.nz9_percentLabel.frame = CGRectMake(1.5, -2.25, 10, 15);
	}
	else {
		self.nz9_percentLabel.frame = CGRectMake(1.75, -1.75, 10, 15);
	}
}

%new
- (UIColor *)nz9_colorFormula {
	self.nz9_percentLabel.textColor = self.fillColor;
	self.nz9_circleView.layer.borderColor = [self.fillColor CGColor];
	return UIColor.clearColor;
}

- (UIColor *)_batteryColor {
	return UIColor.clearColor;
}

- (UIColor *)bodyColor {
	return [self nz9_colorFormula];
}

- (UIColor *)pinColor {
	return [self nz9_colorFormula];
}

- (void)setShowsInlineChargingIndicator:(BOOL)arg1 {
	%orig(NO);
}

%end
