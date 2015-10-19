Ad Video Player
==============

(case)Classes Setup -
--------

 **Implementation:**

> - Import Header **#import "VideoPlayer.h"**
> - call this function where you'd like to start Video.
> - `[VideoPlayer playMediaWithURL: andVastTagURL: andShowUpSecondForMidrollAd:];`

 **Running:**
> - Just run your project and test your video playing action


(case)Framework Setup -
--------

 **Implementation:**

> - Import AdPlayer.framework + AdPlayerUI.bundle into your project.
> - To get framework works correctly you've to imbedd it as the following :
**Your Project > Target > General > Embedded Binaries >** pick AdPlayer.framework from your project list.
Remove duplicated instance of **AdPlayer.framework** from **Linked Frameworks and Libraries** if found.
> - In  your class `#import <AdPlayer/VideoPlayer.h>`
> - call this function where you'd like to start video `[VideoPlayer playMediaWithURL: andVastTagURL: andShowUpSecondForMidrollAd:];`

 **Running & Testing:**
> - You've to use a physical device to run the current **Example Project**.
> - If you'd like to test on simulator, use **Debug-iphonesimulator** build.
> - If you'd like to test on Physical device, use **Debug-iphoneos** build.

 **Congrats! You're ready to go!**
