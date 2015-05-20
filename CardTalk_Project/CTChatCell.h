//
//  CTChatCell.h
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 14..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"

@interface CTChatCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *baloonImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (strong, nonatomic) ChatModel* chat;


@end
