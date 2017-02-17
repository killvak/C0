//
//  ViewController.m
//  instabug 0
//
//  Created by Killvak on 17/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

#import "ViewController.h"
#import "HTTPRequests.h"

@interface ViewController ()
@property (nonatomic,strong) HTTPRequests * classC ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _classC =  [[ HTTPRequests alloc]init];
    _classC.activeDatataskCount = 0 ;
    _classC.maxActiveDatataskCount = 1 ;
//    _classC.dataTasks = [[NSMutableOrderedSet alloc]init];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)RequestBtnAct:(id)sender {
    if ([sender tag] == 0) {
        NSLog(@"Get Request");
    NSString *url = @"http://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b1b15e88fa797225412429c1c50c122a1";

        [_classC getJsonResponse:url success:^(NSDictionary *responseDict) {
     NSLog(@"√");
     } failure:^(NSError *error) {
     NSLog(@"X");
     }];
    }else {
        NSLog(@"Post Request");
    }
}


@end
