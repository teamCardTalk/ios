//
//  DetailTableViewController.h
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 14..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"
#import "CTBasicViewController.h"
#import "CTChatCell.h"
#import "GetChats.h"

@interface CTDetailViewController : CTBasicViewController

@property (strong, nonatomic) CardModel* card;
@property (strong, nonatomic) NSMutableArray* chats;
@property (strong, nonatomic) GetChats* getChat;
@property (strong, nonatomic) UIImage* balloonImage;

@end
