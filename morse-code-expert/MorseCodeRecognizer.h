//
//  MorseCodeRecognizer.h
//  morse-code-expert
//
//  Created by Vladislav Kleschenko on 4/11/18.
//  Copyright © 2018 Vladislav Kleschenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKit/UIGestureRecognizerSubclass.h"

@interface MorseCodeRecognizer : UIGestureRecognizer

@property (nonatomic, readonly) NSDictionary<NSString *, NSString *> *alphabet;

- (instancetype)initWithTarget:(id)target action:(SEL)action alphabet:(NSDictionary<NSString *,NSString *> *)alphabet recognizedLetterBlock:(void (^)(NSString *))recognizedLetterBlock;

@end
