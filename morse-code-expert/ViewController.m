//
//  ViewController.m
//  morse-code-expert
//
//  Created by Vladislav Kleschenko on 4/11/18.
//  Copyright © 2018 Vladislav Kleschenko. All rights reserved.
//

#import "ViewController.h"
#import "MorseCodeRecognizer.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textView;
@property (weak, nonatomic) IBOutlet UIView *canvas;
- (IBAction)onClear;
- (NSDictionary<NSString *, NSString *> *)getAlphabet;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MorseCodeRecognizer *morseCodeRecognizer = [[MorseCodeRecognizer alloc] initWithTarget:self action:@selector(handleGesture) alphabet:[self getAlphabet] recognizedLetterBlock:^(NSString *letter) {
        NSLog(@"%@", letter);
        self.textView.text = [self.textView.text stringByAppendingString:letter];
    }];
    [self.canvas addGestureRecognizer:morseCodeRecognizer];
}

- (void)handleGesture {
}

- (NSDictionary<NSString *, NSString *> *)getAlphabet {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"alphabet" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *fileContent = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *lines = [fileContent componentsSeparatedByString:@"\n"];
    NSMutableDictionary *alphabet = [NSMutableDictionary dictionary];
    for (NSString *line in lines) {
        if (line.length!=0) {
            NSArray *splitedLine = [line componentsSeparatedByString:@";"];
            alphabet[splitedLine[1]] = splitedLine[0];
        }
    }
    return alphabet;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClear {
    self.textView.text = @"";
}

@end
