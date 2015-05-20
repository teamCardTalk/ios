//
//  CardTitle.m
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 27..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import "CardTitle.h"

@implementation CardTitle

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) textFieldDidBeginEditing:(UITextField*) textField {
    self.text = @"";
    self.textColor = [UIColor blackColor];
}

@end
