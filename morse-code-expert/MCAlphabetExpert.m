//
//  MCAlphabetExpert.m
//  morse-code-expert
//
//  Created by Vladislav Kleschenko on 4/12/18.
//  Copyright © 2018 Vladislav Kleschenko. All rights reserved.
//

#import "MCAlphabetExpert.h"

@implementation MCAlphabetExpert

+ (NSDictionary<NSString *,NSString *> *)getAlphabet {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"alphabet" ofType:@"txt"];
    NSString *fileContent = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
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

@end
