//
//  Subclasser.m
//  Nom
//
//  Created on 11-08-30.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Subclasser.h"
#import <objc/runtime.h>

@implementation NSObject (Subclasser)

+(NSArray *) immediateSubclasses
{
    int numClasses = objc_getClassList(NULL, 0);
    Class *classes = malloc(sizeof(Class) * numClasses);
    if (classes == NULL) return nil;
    numClasses = objc_getClassList(classes, numClasses);
    NSMutableArray *result = [NSMutableArray array];
    while (numClasses--)
    {
        Class cls = classes[numClasses];
        if (class_getSuperclass(cls) == self)
        {
            [result addObject: classes[numClasses]];
        }
    }
    free(classes);
    return result;
}

@end
