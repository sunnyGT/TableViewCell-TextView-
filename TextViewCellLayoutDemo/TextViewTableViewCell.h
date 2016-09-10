//
//  TextViewTableViewCell.h
//  TextViewCellLayoutDemo
//
//  Created by Robin on 16/8/20.
//  Copyright © 2016年 Robin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
