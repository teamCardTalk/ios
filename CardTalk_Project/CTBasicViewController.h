//  CTTableViewController.h
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 14..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardModel.h"
#import "CTImageCell.h"
#import "CTBasicCell.h"
#import "CTChatCell.h"

@interface CTBasicViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray* cards;


- (CardModel*)readCardsFromServer;
- (BOOL) hasImageAtIndexPath:(NSIndexPath*)indexPath;
- (CTImageCell*) imageCellAtIndexPath:(NSIndexPath*)indexPath;
- (void) setTextContentForCell:(CTBasicCell*)cell card:(CardModel*)card;
- (CTBasicCell*) basicCellAtIndexPath:(NSIndexPath*)indexPath;
- (void) setTitleForCell:(CTBasicCell*)cell card:(CardModel*)card;
- (void) setCharacterImageForCell:(CTBasicCell*)cell card:(CardModel*)card;
- (void) setDateForCell:(CTBasicCell*)cell card:(CardModel*)card;
- (void) setImageContentForCell:(CTImageCell*)cell card:(CardModel*)card;

@end
