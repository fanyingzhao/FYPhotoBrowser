//
//  FYPhotoViewMacro.h
//  FYPhotoBrowser
//
//  Created by fyz on 2018/8/17.
//  Copyright © 2018年 com.fyz. All rights reserved.
//

#ifndef FYPhotoViewMacro_h
#define FYPhotoViewMacro_h

#define UICOLOR_RGB(r, g, b)               [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.0]
#define UICOLOR_RGB_ALPHA(r, g, b, a)      [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]
#define UICOLOR_HEX(hex)                   [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 \
blue:((float)(hex & 0xFF))/255.0 alpha:1.0]
#define UICOLOR_HEX_ALPHA(hex, a)             [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 \
blue:((float)(hex & 0xFF))/255.0 alpha:a]

#endif /* FYPhotoViewMacro_h */
