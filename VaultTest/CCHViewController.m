//
//  CCHViewController.m
//  VaultTest
//
//  Created by Kevin Lee on 6/26/14.
//  Copyright (c) 2014 Context Hub. All rights reserved.
//

#import "CCHViewController.h"
#import <ContextHub/ContextHub.h>



@interface CCHViewController ()
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (nonatomic, strong) NSArray *items;
@end

@implementation CCHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)createTapped:(id)sender {
//    NSDictionary *item = @{@"name":@"kevin"};
    NSArray *item = @[@"Kevin", @"Chris", @"Sitting", @"Tree"];
    NSArray *tags = @[@"integration"];

    CCHVault *vault = [CCHVault sharedInstance];
    [vault createItem:item tags:tags completionHandler:^(NSDictionary *response, NSError *error) {
        NSLog(@"response %@", response);
        NSLog(@"%@", error);
    }];
}

- (IBAction)getTapped:(id)sender {
    CCHVault *vault = [CCHVault sharedInstance];
    [vault getItemsWithTags:@[@"integration"] completionHandler:^(NSArray *responses, NSError *error) {
        NSLog(@"RESPONSE %@", responses);
        NSLog(@"ERROR: %@", error);
        self.items = responses;
    }];
}

- (IBAction)updateTapped:(id)sender {
    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithDictionary:[self.items firstObject]];
    [item setValue:@"Kalvin" forKeyPath:@"data.name"];
    
    CCHVault *vault = [CCHVault sharedInstance];
    
    [vault updateItem:item completionHandler:^(NSDictionary *response, NSError *error) {
        NSLog(@"RESPONSE %@", response);
        NSLog(@"ERROR: %@", error);
    }];
}

- (IBAction)deleteTapped:(id)sender {
    CCHVault *vault = [CCHVault sharedInstance];
    id lastItem = [self.items firstObject];
    [vault deleteItem:lastItem completionHandler:^(NSDictionary *response, NSError *error) {
        NSLog(@"RESPONSE %@", response);
        NSLog(@"ERROR %@", error);
    }];
     
}

- (IBAction)getItemTapped:(id)sender {
    CCHVault *vault = [CCHVault sharedInstance];
    id lastItem = [self.items lastObject];
    [vault getItemWithId:[lastItem valueForKeyPath:@"vault_info.id"] completionHandler:^(NSDictionary *response, NSError *error) {
        NSLog(@"RESPONSE %@", response);
        NSLog(@"ERROR %@", error);
    }];
}

- (IBAction)createUntaggedTapped:(id)sender {
    NSDictionary *item = @{@"name":@"untagged-kevin"};

    CCHVault *vault = [CCHVault sharedInstance];
    [vault createItem:item tags:nil completionHandler:^(NSDictionary *response, NSError *error) {
        NSLog(@"response %@", response);
        NSLog(@"%@", error);
    }];
}

- (IBAction)getUntaggedTapped:(id)sender {
    CCHVault *vault = [CCHVault sharedInstance];
    [vault getItemsWithTags:nil completionHandler:^(NSArray *responses, NSError *error) {
        NSLog(@"RESPONSE %@", responses);
        NSLog(@"ERROR: %@", error);
        self.items = responses;
    }];
}

- (IBAction)queryItemsTapped:(id)sender {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", @"kevin"];
    NSLog(@"Predicate %@", predicate);
    NSExpression *lhs = [NSExpression expressionForKeyPath:@"this.data.name"];
    NSExpression *rhs = [NSExpression expressionForConstantValue:@"kevin"];
    NSPredicate *comp = [NSComparisonPredicate predicateWithLeftExpression:lhs rightExpression:rhs modifier:NSDirectPredicateModifier type:NSEqualToPredicateOperatorType options:NSCaseInsensitivePredicateOption];
    NSArray *filter = [self.items filteredArrayUsingPredicate:comp];
    NSLog(@"Items %@", filter);
    NSLog(@"predicate %@", comp);
    
    [[CCHVault sharedInstance] getItemsWithTags:@[@"integration"] keyPath:@"name" value:@"Kalvin" completionHandler:^(NSArray *responses, NSError *error) {
        NSLog(@"RESPONSE %@", responses);
        NSLog(@"ERROR: %@", error);
        
    }];
    
}

- (IBAction)addTagTapped:(id)sender {
    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithDictionary:[self.items firstObject]];
//    NSMutableDictionary *vaultInfo = [item objectForKey:@"vault_info"];
//    [vaultInfo setObject:@[@"integration", @"added"] forKey:@"tags"];
    [item setValue:@[@"integration", @"added"] forKeyPath:@"vault_info.tags"];
    
    
    CCHVault *vault = [CCHVault sharedInstance];
    NSLog(@"Item :%@", item);
    [vault updateItem:item completionHandler:^(NSDictionary *response, NSError *error) {
        NSLog(@"RESPONSE %@", response);
        NSLog(@"ERROR: %@", error);
    }];
}

- (IBAction)removeTagTapped:(id)sender {
    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithDictionary:[self.items firstObject]];
    //    NSMutableDictionary *vaultInfo = [item objectForKey:@"vault_info"];
    //    [vaultInfo setObject:@[@"integration", @"added"] forKey:@"tags"];
    [item setValue:@[@"Kevin"] forKeyPath:@"vault_info.tags"];
    
    
    CCHVault *vault = [CCHVault sharedInstance];
    NSLog(@"Item :%@", item);
    [vault updateItem:item completionHandler:^(NSDictionary *response, NSError *error) {
        NSLog(@"RESPONSE %@", response);
        NSLog(@"ERROR: %@", error);
    }];
}

- (IBAction)addSubscriptionTapped:(id)sender {
    [[CCHVault sharedInstance] addSubscriptionForTags:@[@"integration"] completionHandler:^(NSError *error) {
        NSLog(@"ERROR: %@", error);
    }];
}

- (IBAction)removeSubscriptionTapped:(id)sender {
    [[CCHVault sharedInstance] removeSubscriptionForTags:@[@"integration"] completionHandler:^(NSError *error) {
        NSLog(@"ERROR: %@", error);
    }];
}

- (IBAction)printSubscriptions:(id)sender {
    [[CCHSubscriptionService sharedInstance] getSubscriptionsWithCompletion:^(NSDictionary *subscriptions, NSError *error) {
        NSLog(@"Subscriptions: %@",subscriptions);
        NSLog(@"ERROR:  %@", error);
    }];
}

@end
