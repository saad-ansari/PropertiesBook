//
//  Macros.h
//  JobAppPortal
//
//  Created by Muzamil on 5/14/13.
//  Copyright (c) 2013 CubixLabs. All rights reserved.
//

#ifndef JobAppPortal_Macros_h
#define JobAppPortal_Macros_h

#define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )
#define IS_IPOD   ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] )
#define IS_WIDESCREEN ( [ [ UIScreen mainScreen ] bounds ].size.height == 568 )
#define IS_IPHONE_5 ( [ [ UIScreen mainScreen ] bounds ].size.height == 568 )

#endif
#define FRIEND @"friend"
#define LOCATION @"location"
#define FAMILY @"family"