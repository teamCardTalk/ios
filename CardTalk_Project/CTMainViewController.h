//
//  MasterViewController.h
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 13..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTBasicViewController.h"
#import "CardModel.h"
#import "CTImageCell.h"
#import "CTBasicCell.h"
#import "CTDetailViewController.h"
#import "GetCards.h"

@interface CTMainViewController : CTBasicViewController

@property (strong, nonatomic) GetCards* getCards;

@end

