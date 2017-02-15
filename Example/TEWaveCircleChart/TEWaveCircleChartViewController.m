//
//  TEWaveCircleChartViewController.m
//  TEWaveCircleChart
//
//  Created by kingdomrain on 02/15/2017.
//  Copyright (c) 2017 kingdomrain. All rights reserved.
//

#import "TEWaveCircleChartViewController.h"
#import <TEWaveCircleChart/TEWaveCircleChart.h>

@interface TEWaveCircleChartViewController ()

@end

@implementation TEWaveCircleChartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    TEWaveCircleChart *circleChart = [[TEWaveCircleChart alloc]init];
    circleChart.frame = CGRectMake(0, 0, 300, 300);
    circleChart.layer.cornerRadius = 150;
    [circleChart performSelector:@selector(setParam: :) withObject:@"totle" withObject:@"100"];
    [self.view addSubview:circleChart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
