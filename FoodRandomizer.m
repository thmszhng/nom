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
int totalWeight = 0;

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
    totalWeight += weight;
}

+(Class) randomFood
{
    int r = random() % totalWeight;
    for (Entry *e in allFood)
    {
        if (r < e.weight) return e.type;
        r -= e.weight;
    }
    return [NSObject class]; // shouldn't happen
}
+(Class) randomFoodExcept: (Class) exclude
{
    Entry *ex = nil;
    for (Entry *e in allFood)
    {
        if (e.type == exclude)
        {
            ex = e;
            break;
        }
    }
    if (ex == nil) return [self randomFood];
    int r = random() % (totalWeight - ex.weight);
    for (Entry *e in allFood)
    {
        if (ex == e) continue;
        if (r < e.weight) return e.type;
        r -= e.weight;
    }
    return [NSObject class]; // shouldn't happen
}

@end
