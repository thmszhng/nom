//  FoodRandomizer.h
//  Nom
//
//  Created on 11-08-26.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

@interface FoodRandomizer: NSObject
{
}
+(void) initialize;
+(void) addFood: (Class) food weight: (int) weight;

+(Class) randomFood;
+(Class) randomFoodExcept: (Class) exclude;
@end