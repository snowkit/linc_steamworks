#ifndef _LINC_STEAMWORKS_H_
#define _LINC_STEAMWORKS_H_

#include "../lib/steam/steam_api.h"

#include <hxcpp.h>

namespace linc {

    namespace steam {

            //UserStats
        extern hx::Null<int> getStat(::String name);
        extern hx::Null<Float> getStatf(::String name);
        extern hx::Null<bool> getAchievement(::String name);

            //RemoteStorage
        bool fileWrite(::String name, ::Array<unsigned char> src, int length);
        int fileRead(::String name, ::Array<unsigned char> dest, int length);

        typedef ::cpp::Function < Void(Dynamic) > UserCallbackHandler;
        extern void set_callback(UserCallbackHandler fn);

    } //steam namespace

} //linc namespace


#endif //_LINC_STEAMWORKS_H_