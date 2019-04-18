//
//  AWPlaceHolderTextView.h
//
//  Created by iMac-1 on 2017/9/8.
//  Copyright © 2017年 iOS_Awei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AWPlaceHolderTextView : UITextView

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UILabel *placeHolderLabel;

-(void)textChanged:(NSNotification*)notification;

@end
