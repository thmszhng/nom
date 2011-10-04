//  FoodRandomizer.h
//  Nom
//
//  Created on 11-08-26.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "FoodRandomizer.h"

@interface Entry: NSObject
{
}
@property (readwrite, assign) Class type;
@property (readwrite, assign) int weight;
@end
@implementation Entry
@synthesize type;
@synthesize weight;
@end

NSMutableArray *allFood = nil;

@implementation FoodRandomizer

+(void) initialize
{
    if (allFood == nil)
        allFood = [NSMutableArray new];
}
+(void) addFood: (Class) type weight: (int) weight
{
    Entry *e = [Entry new];
    e.type = type;
    e.weight = weight;
    [allFood addObject: e];
}

Class randomInArray(id<NSFastEnumeration> array)
{
    int totalWeight = 0;
    for (Entry *e in array) totalWeight += e.weight;
    int r = random() % totalWeight;
    for (Entry *e in array)
    {
        if (r < e.weight) 
        {
            return e.type;
        }
        r -= e.weight;
    }
    [NSException raise: @"FailureError" format: @"Failed to generate a random food"];
    return [NSObject class]; // shouldn't happen
}

+(Class) randomFood
{
    return randomInArray(allFood);
}
+(Class) randomFoodExcept: (Class) exclude, ...
{
    NSMutableArray *rest = [[allFood mutableCopy] autorelease];
    va_list args;
    va_start(args, exclude);
    for (Class arg = exclude; arg != Nil; arg = va_arg(args, Class))
    {
        id toRemove = nil;
        for (Entry *e in rest)
        {
            if (e.type == arg)
            {
                toRemove = e;
                break;
            }
        }
        if (toRemove) [rest removeObject: toRemove];
    }
    va_end(args);
    return randomInArray(rest);
}

@end
