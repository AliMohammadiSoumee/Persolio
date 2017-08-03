//
//  MATTextField.h
//  mactehrannew
//
//  Created by hAmidReza on 8/1/17.
//  Copyright © 2017 archibits. All rights reserved.
//

#import "_viewBase.h"

typedef enum : NSUInteger {
	MATTextFieldRequirementTypeNone,
	MATTextFieldRequirementTypeRequired,
	MATTextFieldRequirementTypeOptional,
} MATTextFieldRequirementType;

typedef enum : NSUInteger {
	MATTextFieldTypeTextField,
	MATTextFieldTypeTextView,
} MATTextFieldType;

@protocol _MATTextField_FieldAndViewSharedProtocol <NSObject>

-(BOOL)resignFirstResponder;
-(BOOL)becomeFirstResponder;

@property(nullable,nonatomic,strong) UIFont *font;
@property(nullable,nonatomic,strong) UIColor *textColor;
@property(nonatomic) NSTextAlignment textAlignment;
@property(null_resettable,nonatomic,copy) NSString *text;

@end

typedef _Nonnull id <_MATTextField_FieldAndViewSharedProtocol> textFieldOrView;

@protocol MATTextFieldDelegate <NSObject>

- (void)textFieldOrViewDidBeginEditing:(textFieldOrView)textFieldOrView;
- (BOOL)textFieldOrView:(textFieldOrView)textFieldOrView shouldChangeCharactersInRange:(NSRange)range replacementString:(nullable NSString*)string;

@end

@interface MATTextField : _viewBase

/**
 creates a new instance of the MATTextField. you can call new on this class in that case it will create an object with type: MATTextFieldTypeTextField

 @param type either MATTextFieldTypeTextField or MATTextFieldTypeTextView.
 @return the instance
 */
-(instancetype)initWithType:(MATTextFieldType)type;

/**
 default: NSTextAlignmentLeft
 */
@property (assign, nonatomic) NSTextAlignment textAlignment;

/**
 titleLabel text. default: NaN
 */
@property (retain, nonatomic) UIFont* font;

/**
 the control is in active state;
 */
@property (assign, nonatomic, readonly) BOOL isActive;

/**
 default: rgba(48, 125, 252, 1.000)
 */
@property (retain, nonatomic) UIColor* titleLabelActiveColor UI_APPEARANCE_SELECTOR;

/**
 default: rgba(109, 109, 109, 1.000)
 */
@property (retain, nonatomic) UIColor* titleLabelNormalColor UI_APPEARANCE_SELECTOR;

/**
 defaults to 20.0f;
 */
@property (assign, nonatomic) CGFloat titleLabelActiveHeight UI_APPEARANCE_SELECTOR;


/**
 default: rgba(48, 125, 252, 1.000)
 */
@property (retain, nonatomic) UIColor* dividerActiveColor UI_APPEARANCE_SELECTOR;

/**
 default: rgba(109, 109, 109, 1.000)
 */
@property (retain, nonatomic) UIColor* dividerNormalColor UI_APPEARANCE_SELECTOR;

/**
 defaults to 2;
 */
@property (assign, nonatomic) CGFloat dividerActiveHeight UI_APPEARANCE_SELECTOR;

/**
 defaults to 1;
 */
@property (assign, nonatomic) CGFloat dividerNormalHeight UI_APPEARANCE_SELECTOR;




/**
 default: 16.0f
 */
@property (assign, nonatomic) CGFloat topPadding UI_APPEARANCE_SELECTOR;

/**
 top margin to titleLabelactive state view. default: 8
 */
@property (assign, nonatomic) CGFloat textFieldTopMargin UI_APPEARANCE_SELECTOR;

/**
 bottom margin to divider. default: 8
 */
@property (assign, nonatomic) CGFloat textFieldBottomMargin UI_APPEARANCE_SELECTOR;


/**
 default: rgba(139, 139, 139, 1.000)
 */
@property (retain, nonatomic) UIColor* placeholderColor;

/**
 default 0
 */
@property (assign, nonatomic) CGFloat titleLabelSideMargins UI_APPEARANCE_SELECTOR;


/**
 top margin to bottom of textfield. default: 16
 */
@property (assign, nonatomic) CGFloat helperLabelTopMargin UI_APPEARANCE_SELECTOR;

/**
  default: rgba(139, 139, 139, 1.000)
 */
@property (retain, nonatomic) UIColor* _Nullable helperLabelNormalColor UI_APPEARANCE_SELECTOR;


/**
 textcolor for textfield. default: rgba(33, 33, 33, 1.000)
 */
@property (retain, nonatomic) UIColor* _Nullable textFieldColor UI_APPEARANCE_SELECTOR;


/**
 sets the text for elements

 @param title text for the titleLabel which on focus will move on to the top of the textfield
 @param placeholder placeholder appears on textfield when its empty while focused
 @param helper the helper text which appears under textfield
 @param value the text for textfield
 */
-(void)setTitle:(nullable NSString*)title placeholder:(nullable NSString*)placeholder helperText:(nullable NSString*)helper value:(nullable NSString*)value errorText:(nullable NSString*)errorString;

/**
 it will set both titleLabelActiveColor & dividerActiveColor. default: rgba(48, 125, 252, 1.000)
 */
@property (retain, nonatomic) UIColor* _Nullable primaryTintColor UI_APPEARANCE_SELECTOR;



/**
 default: MATTextFieldRequirementTypeNone
 */
@property (assign, nonatomic) MATTextFieldRequirementType requirementType;



/**
 text for titlelabel. default: nil
 */
@property (retain, nonatomic) NSString* _Nullable titleText;


/**
 text for placeholder. default: nil
 */
@property (retain, nonatomic) NSString* _Nullable placeholderText;



/**
 text for helper. default: nil
 */
@property (retain, nonatomic) NSString* _Nullable helperText;


/**
 switches to control to disabled state.
 */
@property (assign, nonatomic) BOOL disabled;


/**
 type of the MATTextField. default: MATTextFieldTypeTextField
 */
@property (assign, nonatomic, readonly) MATTextFieldType type;


/**
 a block to validate the string. return true and false.
 */
@property (copy, nonatomic) BOOL (^ _Nullable validateString)(NSString* _Nullable value);


/**
 if you have different errors for different values use this block. otherwise the error label's text will be equal to errorText.
 */
@property (copy, nonatomic) NSString* (^_Nullable errorForString)(NSString* _Nullable value);

/**
 used in validation. default: rgba(252, 31, 74, 1.000)
 */
@property (retain, nonatomic) UIColor* _Nullable errorColor;

/**
 used in validation. default: _str(@"Error!")
 */
@property (retain, nonatomic) NSString* _Nullable errorText;


/**
 counts the characters and validates the max number of characters entered. See: maxLength. default: false
 */
@property (assign, nonatomic) BOOL showsCounterLabel;

/**
 default: 100. it won't be considered if showsCounterLabel == false;
 */
@property (assign, nonatomic) NSUInteger maxLength;

/**
	if you want a custom string generation for counter label use this block. works only if showsCounterLabel == false;
 */
@property (copy, nonatomic) NSString* (^counterString)(NSUInteger length, NSUInteger maxLength);


/**
 delegate for the textview/textfield.
 */
@property (weak, nonatomic) id<MATTextFieldDelegate> delegate;

/**
 text to set for textfield/textview
 */
@property (retain, nonatomic) NSString* _Nullable text;

@end
