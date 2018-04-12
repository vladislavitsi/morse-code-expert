//
//  MorseCodeRecognizer.m
//  morse-code-expert
//
//  Created by Vladislav Kleschenko on 4/11/18.
//  Copyright © 2018 Vladislav Kleschenko. All rights reserved.
//

#import "MorseCodeRecognizer.h"

#define LINE_INTERVAL 0.2
#define NEXT_LETTER_INTERVAL 0.6

@interface MorseCodeRecognizer ()

@property (nonatomic, strong) UITouch *touch;
@property (nonatomic, strong) NSDate *touchBeganTime;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, readonly) void (^recognizedLetterBlock)(NSString *);
@property (nonatomic, strong) NSMutableString *chart;

@end

@implementation MorseCodeRecognizer

- (instancetype)initWithTarget:(id)target action:(SEL)action alphabet:(NSDictionary<NSString *,NSString *> *)alphabet recognizedLetterBlock:(void (^)(NSString *))recognizedLetterBlock {
    if (self = [super initWithTarget:target action:action]) {
        _alphabet = [alphabet copy];
        _recognizedLetterBlock = recognizedLetterBlock;
        self.chart = [NSMutableString string];
        [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    }
    return self;
}

// Began.
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (touches.count > 1)	 {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
    
    [self.timer invalidate];
    self.timer = nil;
    
    if (self.touch == nil) {
        self.touchBeganTime = [NSDate date];
        self.touch = [touches anyObject];
    }
}

- (NSString *)checkResult {
    NSString *recognizedLetter = self.alphabet[self.chart];
//    NSLog(@"%@ -> %@", self.chart, recognizedLetter);
    return recognizedLetter;
}

// End.
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.touchBeganTime];
//    NSLog(@"%f", timeInterval);
    if (timeInterval < LINE_INTERVAL) {
        [self.chart appendString:@"*"];
    }else {
        [self.chart appendString:@"-"];
    }
    
    self.timer = [NSTimer timerWithTimeInterval:NEXT_LETTER_INTERVAL repeats:NO block:^(NSTimer *timer) {
        NSString *letter = [self checkResult];
        if (letter != nil) {
            self.recognizedLetterBlock(letter);
            self.state = UIGestureRecognizerStateEnded;
        }else {
            self.state = UIGestureRecognizerStateFailed;
        }
    }];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    self.touch = nil;
    self.touchBeganTime = nil;
}

// Reset.
- (void)reset {
    [super reset];
    self.touch = nil;
    self.touchBeganTime = nil;
    self.timer = nil;
    self.chart = [NSMutableString string];
}

@end
