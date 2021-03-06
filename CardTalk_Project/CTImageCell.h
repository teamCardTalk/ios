//
//  CTImageCell.h
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 13..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicLabel.h"
#import "CardModel.h"
#import "CTBasicCell.h"

@interface CTImageCell : CTBasicCell

@property (strong, nonatomic) CardModel* card;
@property (weak, nonatomic) IBOutlet DynamicLabel *author;
@property (weak, nonatomic) IBOutlet DynamicLabel *place;
@property (weak, nonatomic) IBOutlet DynamicLabel *date;
@property (weak, nonatomic) IBOutlet DynamicLabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;
@property (weak, nonatomic) IBOutlet UIButton *stareButton;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UIView *cardView;

@end
