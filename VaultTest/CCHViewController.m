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

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationReceived:) name:CCHSubscriptionResourceChangeNotification object:nil];
    
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)notificationReceived:(NSNotification *)notification {
    if (![[notification.userInfo objectForKey:@"resource"] isEqualToString:@"Device"]) {
      NSLog(@"Notification %@", notification);
    }
}

- (IBAction)createTapped:(id)sender {
    NSDictionary *item = @{@"name":@"kalvin"};
    NSArray *tags = @[@"integration"];

    CCHVault *vault = [CCHVault sharedInstance];
    [vault createItem:item tags:tags completionHandler:^(NSDictionary *response, NSError *error) {
        NSLog(@"response %@", response);
        NSLog(@"%@", error);
    }];
}

- (IBAction)getTapped:(id)sender {
//    CCHVault *vault = [CCHVault sharedInstance];
//    [vault getItemsWithTags:@[@"Kevin", @"pipeline"] completionHandler:^(NSArray *responses, NSError *error) {
//        NSLog(@"RESPONSE %@", responses);
//        NSLog(@"ERROR: %@", error);
//        self.items = responses;
//    }];
    
//    [[CCHBeaconService sharedInstance] getBeaconsWithTags:@[@"integration", @"pipeline"] operator:nil completionHandler:^(NSArray *beacons, NSError *error) {
//        NSLog(@"RESPONSE %@", beacons);
//        NSLog(@"ERROR: %@", error);
//    }];

//    [[CCHGeofenceService sharedInstance] getGeofencesWithTags:@[@"integration", @"pipeline"] operator:@"ALL" location:nil radius:0 completionHandler:^(NSArray *geofences, NSError *error) {
//        NSLog(@"RESPONSE %@", geofences);
//        NSLog(@"ERROR: %@", error);
//        
//    }];
//    [vault getItemsWithTags:@[] completionHandler:^(NSArray *responses, NSError *error) {
//        NSLog(@"RESPONSE EMPTY %lu", responses.count);
//
//    }];
//    
//    [vault getItemsWithTags:nil completionHandler:^(NSArray *responses, NSError *error) {
//        NSLog(@"RESPONSE NIL COUNT %lu", responses.count);
//        NSLog(@"RESPONSE NIL %@", responses);
//    }];
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
    
    [[CCHVault sharedInstance] getItemsWithTags:@[@"integration"] keyPath:@"name" value:@"kalvin" completionHandler:^(NSArray *responses, NSError *error) {
        NSLog(@"RESPONSE %@", responses);
        NSLog(@"ERROR: %@", error);
        
    }];
    
    [[CCHVault sharedInstance] getItemsWithTags:nil keyPath:@"name" value:@"kalvin" completionHandler:^(NSArray *responses, NSError *error) {
        NSLog(@"RESPONSE NIL %lu", responses.count);
        
    }];

    [[CCHVault sharedInstance] getItemsWithTags:@[] keyPath:@"name" value:@"kalvin" completionHandler:^(NSArray *responses, NSError *error) {
        NSLog(@"RESPONSE EMPTY %lu", responses.count);
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
    [[CCHSubscriptionService sharedInstance] addSubscriptionsForTags:@[@"PowerCurve"] options:@[CCHOptionVault] completionHandler:^(NSError *error) {
        NSLog(@"ERROR: %@", error);
    }];

    [[CCHSubscriptionService sharedInstance] addSubscriptionsForTags:@[@"test-422"] options:@[CCHOptionVault] completionHandler:^(NSError *error) {
        NSLog(@"ERROR: %@", error);
    }];

//    [[CCHSubscriptionService sharedInstance] addSubscriptionsForTags:@[@"integration", @"Integration", @"remove-me", @"pipeline"] options:@[CCHOptionVault] completionHandler:^(NSError *error) {
//        NSLog(@"ERROR: %@", error);
//        if ([NSThread isMainThread]) {
//            NSLog(@"main thread");
//        } else {
//            NSLog(@"Not main thread");
//        }
//        
//    }];
    NSLog(@"Adding Tags");
    [[CCHSensorPipeline sharedInstance] addElementsWithTags:@[@"geo1", @"geo2", @"pipeline"]];


}

- (IBAction)removeSubscriptionTapped:(id)sender {
//    [[CCHSubscriptionService sharedInstance] removeSubscriptionsForTags:@[@"remove-me"] options:nil completionHandler:^(NSError *error) {
//        NSLog(@"ERROR: %@", error);
//        if ([NSThread isMainThread]) {
//            NSLog(@"main thread");
//        } else {
//            NSLog(@"Not main thread");
//        }
//        
//    }];
    NSLog(@"Removing Tag");
    [[CCHSensorPipeline sharedInstance] removeElementsWithTags:@[@"geo1"]];
}

- (IBAction)printSubscriptions:(id)sender {
    [[CCHSubscriptionService sharedInstance] getSubscriptionsWithCompletionHandler:^(NSDictionary *subscriptions, NSError *error) {
        NSLog(@"Subscriptions: %@",subscriptions);
        if (error) {
            NSLog(@"ERROR:  %@", error);
        }
    }];

//    [[CCHSensorPipeline sharedInstance] triggerEvent:@{@"name":@"button_tapped"} completionHandler:^(NSError *error) {
//
//        
//    }];
    
    CLLocationManager *mgr = [[CLLocationManager alloc] init];
    NSLog(@" Locations Monitored %@", mgr.monitoredRegions);

//    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-8876223462A3"];
//    CLBeaconRegion *jp = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"SAMPLE"];
//    [mgr startMonitoringForRegion:jp];

//    CLCircularRegion *r1 = [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(31., -95.) radius:100 identifier:@"Sand Creek"];
//    CLCircularRegion *r2 = [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(30., -95.) radius:1000 identifier:@"Sand Creek"];
//    
//    if ([r1 isEqual:r2]) {
//        NSLog(@"Eqaul");
//    } else {
//        NSLog(@"Not Eqaul");
//    }
    
}

@end
