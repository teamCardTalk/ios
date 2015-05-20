//
//  DetailTableViewController.m
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 14..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import "CTDetailViewController.h"

#define NUMBEROFSECTION 2

@interface CTDetailViewController ()

@end

@implementation CTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBalloonImage];
    [self initializeView];
    [self getData];
}

- (void) initializeView {
    self.cards = [[NSMutableArray alloc] init];
    self.getChat = [[GetChats alloc] init];
    [self registerGetChatsNotificationObserver];
    [self registerReloadNotificationObserver];
}

- (void) setBalloonImage {
    _balloonImage = [UIImage imageNamed:@"chat_balloon2"];
    [self.balloonImage resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
}

- (void) getData {
    NSString* chatURL = [NSString stringWithFormat:@"http://125.209.195.202:3000/chat/%@", self.card.id];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:chatURL]];
    NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:request delegate:self.getChat];
}

-(void) registerGetChatsNotificationObserver {
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(reloadTableViewNotification:) name:@"getChats" object:nil];
}

-(void) registerReloadNotificationObserver {
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(reloadData:) name:@"detailReload" object:nil];
}

-(void) reloadTableViewNotification:(NSNotification*)notification {
    NSArray* chatDictionaryArray = [notification.userInfo objectForKey:@"chats"];
    self.chats = [[NSMutableArray alloc] init];
    for (NSDictionary* chatDict in chatDictionaryArray) {
        [self.chats insertObject:[[ChatModel alloc] initWithChatDict:chatDict] atIndex:0];
    }
    
    [self reloadTable];
}

-(void) reloadData:(NSNotification*) notification {
    [self reloadTable];
}

- (void) reloadTable {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return NUMBEROFSECTION;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([self isCardSection:section]) {
        return 1;
    } else {
        return self.chats.count;
    }
}

- (BOOL) isCardSection:(NSInteger)section {
    return section == 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    
    if ([self isCardSection:section]) {
        if ([self hasImageAtIndexPath:indexPath]) {
            return [self imageCellAtIndexPath:indexPath];
        } else {
            return [self basicCellAtIndexPath:indexPath];
        }
        
    } else {
        return [self chatCellAtIndexPath:indexPath];
    }
}

- (CTChatCell*) chatCellAtIndexPath:(NSIndexPath*)indexPath {
    CTChatCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CTChatCell" forIndexPath:indexPath];
    [self configureChatCell:cell atIndexPath:indexPath];
    return cell;
}

- (void) configureChatCell:(CTChatCell*)cell atIndexPath:(NSIndexPath*) indexPath {
    ChatModel* chat = self.chats[indexPath.row];
    [self setIconImageViewForCell:cell chatData:chat];
    [self setNicknameForCell:cell achatData:chat];
    [self configureTextForCell:cell chatData:chat];
    [self configureBalloonForCell:cell chatData:chat];
    [self setDateForCell:cell chatData:chat];
}

- (void)setIconImageViewForCell:(CTChatCell*)cell chatData:(ChatModel*)chat {
    [cell.iconImageView setImage:chat.iconImage];
}

- (void)setNicknameForCell:(CTChatCell*)cell achatData:(ChatModel*)chat {
    cell.nickname.text = chat.nickname;
}

- (void)configureBalloonForCell:(CTChatCell*)cell chatData:(ChatModel*)chat {
    
    CGRect balloonRect = cell.text.frame;
    cell.baloonImageView.frame = balloonRect;
    [cell.baloonImageView setImage:self.balloonImage];
}

- (UIImage*)imageResize:(UIImage*)image size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (void)configureTextForCell:(CTChatCell*)cell chatData:(ChatModel*)chat {
    UILabel* label = cell.text;
    label.numberOfLines = 0;
    label.text = chat.content;
}

- (void)setDateForCell:(CTChatCell*)cell chatData:(ChatModel*)chat {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![self isCardSection:indexPath.section]) {
        if ([self isCardSection:indexPath.section]) {
            return [super tableView:tableView heightForRowAtIndexPath:indexPath];
        }
        
        static CTChatCell* sizingCell = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sizingCell = [self.tableView dequeueReusableCellWithIdentifier:@"CTChatCell"];
        });
        
        [self configureChatCell:sizingCell atIndexPath:indexPath];
        return [self calculateChatHeightForConfiguredSizingCell:sizingCell];
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    
}

-(CGFloat) calculateChatHeightForConfiguredSizingCell:(CTChatCell*)sizingCell {
    
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return size.height + 1.0f;
}

- (void) configureImageCell:(CTImageCell*)cell atIndexPath:(NSIndexPath*)indexPath {
    CardModel* card = self.card;
    [self setTitleForCell:cell card:card];
    [self setCharacterImageForCell:cell card:card];
    [self setDateForCell:cell card:card];
    [self setTextContentForCell:cell card:card];
    [self setImageContentForCell:cell card:card];
}

- (void) configureBasicCell:(CTBasicCell*)cell atIndexPath:(NSIndexPath*)indexPath {
    CardModel* card = self.card;
    [self setTitleForCell:cell card:card];
    [self setCharacterImageForCell:cell card:card];
    [self setDateForCell:cell card:card];
    [self setTextContentForCell:cell card:card];
}

- (BOOL) hasImageAtIndexPath:(NSIndexPath *)indexPath {
    return self.card.contentImages.count != 0;
}

- (void) setTextContentForCell:(CTBasicCell*)cell card:(CardModel*)card {
    NSString* content = card.content;
    
    cell.content.text = content;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
