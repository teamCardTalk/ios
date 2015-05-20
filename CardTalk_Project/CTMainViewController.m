//
//  MasterViewController.m
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 13..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import "CTMainViewController.h"


@interface CTMainViewController ()

@end

@implementation CTMainViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
   
    [self initializeView];
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initializeView {
    self.cards = [[NSMutableArray alloc] init];
    self.getCards = [[GetCards alloc] init];
    [self registerGetCardNotificationObserver];
    [self registerReloadNotificationObserver];
}

- (void) registerGetCardNotificationObserver {
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(reloadTableViewNotification:) name:@"getCards" object:nil];
}

- (void) registerReloadNotificationObserver {
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(reloadData:) name:@"reload" object:nil];
}

- (void) reloadTableViewNotification:(NSNotification*)notification {
    NSArray* cardDictionaryArray = [notification.userInfo objectForKey:@"cards"];
    NSLog(@"%@", cardDictionaryArray);
    self.cards = [[NSMutableArray alloc] init];
    for (NSDictionary* cardDict in cardDictionaryArray) {
        [self.cards insertObject:[[CardModel alloc] initWithCardDict:cardDict] atIndex:0];
    }
    

    [self reloadTable];

    NSLog(@"network %@", [notification.userInfo objectForKey:@"cards"]);
}

- (void) reloadData:(NSNotification*) notification {
    [self reloadTable];
}

- (void) reloadTable {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void) getData {
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://125.209.195.202:3000/card/all"]];
    NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:request delegate:self.getCards];
    NSLog(@"start!");
}

- (void)insertNewObject:(id)sender {

    CardModel* card = [self readCardsFromServer];
    [self.cards insertObject:card atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if (![[segue identifier] isEqualToString:@"writeDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CardModel *card = self.cards[indexPath.row];
        CTDetailViewController* detailTableViewController = [segue destinationViewController];
        detailTableViewController.card = card;
    }
}

#pragma mark - Table View

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.cards removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [self reloadTable];
    }
}

@end
