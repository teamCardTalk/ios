//
//  CTTableViewController.m
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 14..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import "CTBasicViewController.h"

@interface CTBasicViewController ()

@end

@implementation CTBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tableView.separatorColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CardModel*)readCardsFromServer {
    UIImage* iconImage = [UIImage imageNamed:@"icon2"];
    UIImage* contentImage = [UIImage imageNamed:@"hiasins"];
    NSArray* contentImages = @[contentImage];
    
    CardModel* card = [[CardModel alloc] initWithAuthor:@"노란 광대"
                                                  place:@"시시콜콜한 음악실"
                                                content:@"Remember those #warning statements from before? Yep, those are your troublemakers. You need to implement the table view data source and delegate methods.Implement UITableView Delegate and Data Source Add the following to the top of RWFeedViewController.m, right below the #import statements:You’ll be using RWBasicCell in both the data source and delegate methods and will need to be able to identify it by the Reuse Identifier you set to RWBasicCellIdentifier in the Storyboard.In tableView:cellForRowAtIndexPath:, you call basicCellAtIndexPath: to get an RWBasicCell. As you’ll see later on, it’s easier to add additional types of custom cells if you create a helper method like this instead of returning a cell directing by the data source method."
                                                   date:[NSDate date]
                                              iconImage:iconImage
                                          contentImages:contentImages];
    return card;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cards.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"return cell");
    if ([self hasImageAtIndexPath:indexPath]) {
        return [self imageCellAtIndexPath:indexPath];
    } else {
        if ([self isChatCellAtIndexPath:indexPath]) {
            return [self chatCellAtIndexPath:indexPath];
        } else {
            return [self basicCellAtIndexPath:indexPath];
        }
    }
}

-(CTChatCell*) chatCellAtIndexPath:(NSIndexPath*)indexPath {
    CTChatCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CTChatCell"];
    return cell;
}

- (BOOL) isChatCellAtIndexPath:(NSIndexPath*)indexPath {
    return indexPath.section == 1;
}

- (CTImageCell*) imageCellAtIndexPath:(NSIndexPath*)indexPath {
    CTImageCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CTImageCell" forIndexPath:indexPath];
    [self configureImageCell:cell atIndexPath:indexPath];
    return cell;
}

-(void) configureBasicCell:(CTBasicCell*)cell atIndexPath:(NSIndexPath*)indexPath {
    CardModel* card = self.cards[indexPath.row];
    [self setTitleForCell:cell card:card];
    [self setCharacterImageForCell:cell card:card];
    [self setDateForCell:cell card:card];
    [self setTextContentForCell:cell card:card];
}

- (void) configureImageCell:(CTImageCell*)cell atIndexPath:(NSIndexPath*)indexPath {
    CardModel* card = self.cards[indexPath.row];
    [self setTitleForCell:cell card:card];
    [self setCharacterImageForCell:cell card:card];
    [self setDateForCell:cell card:card];
    [self setTextContentForCell:cell card:card];
    [self setImageContentForCell:cell card:card];
}

- (void) setImageContentForCell:(CTImageCell*)cell card:(CardModel*)card {
    if (card.contentImages.count == 1) {
        UIImage* contentImage = [card.contentImages objectAtIndex:0];
        CGSize imageSize = contentImage.size;
        
        float width = cell.contentImageView.bounds.size.width;
        float imageRatio = imageSize.height / imageSize.width;
        float newHeight = imageRatio * width;
        
        NSDictionary* viewDictionary = @{@"contentImageView":cell.contentImageView};
        NSDictionary* metrics = @{@"height":[NSNumber numberWithFloat:newHeight]};
        NSArray* contentImageViewConstraintHeight = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[contentImageView(height)]"
                                                                                            options:0
                                                                                            metrics:metrics
                                                                                              views:viewDictionary];
        [cell.contentImageView addConstraints:contentImageViewConstraintHeight];
        [cell.contentImageView setImage:contentImage];
    }
}

- (void) setTitleForCell:(CTBasicCell*)cell card:(CardModel*)card {
    cell.author.text = card.author;
    cell.place.text = card.place;
}

- (void) setCharacterImageForCell:(CTBasicCell*)cell card:(CardModel*)card {
    [cell.iconImageView setImage:card.iconImage];
}

- (void) setDateForCell:(CTBasicCell*)cell card:(CardModel*)card {
    cell.date.text = card.dateString;
}

- (void) setTextContentForCell:(CTBasicCell*)cell card:(CardModel*)card {
    NSString* content = card.content;
    if (content.length > 200) {
        content = [NSString stringWithFormat:@"%@... 더보기", [content substringToIndex:200]];
    }
    cell.content.text = content;
}

-(BOOL) hasImageAtIndexPath:(NSIndexPath*)indexPath {
    CardModel* card = self.cards[indexPath.row];
    return card.contentImages.count != 0;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self hasImageAtIndexPath:indexPath]) {
        return [self heightForImageCellAtIndexPath:indexPath];
    } else {
        return [self heightForBasicCellAtIndexPath:indexPath];
    }
}

-(CGFloat) heightForImageCellAtIndexPath:(NSIndexPath*)indexPath {
    
    static CTImageCell* sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:@"CTImageCell"];
    });
    [self configureImageCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

-(CGFloat) heightForBasicCellAtIndexPath:(NSIndexPath*)indexPath {
    if ([self isChatCellAtIndexPath:indexPath]) {
        return 44.0;
    }
    
    static CTBasicCell* sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:@"CTBasicCell"];
    });
    [self configureBasicCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

-(CGFloat) calculateHeightForConfiguredSizingCell:(CTBasicCell*)sizingCell {
    
    [sizingCell.cardView setNeedsLayout];
    [sizingCell.cardView layoutIfNeeded];
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    NSLog(@"%f %f", size.height, size.width);
    
    return size.height + 1.0f;
}

- (CTBasicCell*) basicCellAtIndexPath:(NSIndexPath*)indexPath {
    

    CTBasicCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CTBasicCell" forIndexPath:indexPath];
    [self configureBasicCell:cell atIndexPath:indexPath];
    return cell;
   
}

@end
