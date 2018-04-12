//
//  ViewController.m
//  morse-code-expert
//
//  Created by Vladislav Kleschenko on 4/11/18.
//  Copyright © 2018 Vladislav Kleschenko. All rights reserved.
//

#import "ViewController.h"
#import "MorseCodeRecognizer.h"
#import "MCAlphabetExpert.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIView *canvas;
- (IBAction)onClear;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __weak UILabel *weakTextlabel = self.textLabel;
    MorseCodeRecognizer *morseCodeRecognizer = [[MorseCodeRecognizer alloc] initWithTarget:self action:@selector(handleGesture) alphabet:[MCAlphabetExpert getAlphabet] recognizedLetterBlock:^(NSString *letter) {
        NSLog(@"%@", letter);
        weakTextlabel.text = [weakTextlabel.text stringByAppendingString:letter];
    }];
    [self.canvas addGestureRecognizer:morseCodeRecognizer];
}

- (void)handleGesture {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClear {
    self.textLabel.text = @"";
}
@end
