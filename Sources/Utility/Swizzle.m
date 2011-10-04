//
//  Swizzle.c
//  Nom
//
//  Created by hpp3 on 11-08-29.
//  Copyright 2011 Cisco. All rights reserved.
//

#include "Swizzle.h"

#import <objc/runtime.h>

//....

void Swizzle(Class c, SEL orig, SEL new)
{
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    if(class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    else
        method_exchangeImplementations(origMethod, newMethod);
}