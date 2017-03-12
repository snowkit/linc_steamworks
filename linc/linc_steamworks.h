#pragma once

#include <hxcpp.h>

#include "../lib/steam/steam_api.h"

namespace linc {

    namespace steam {

            //UserStats
        extern hx::Null<int> getStat(::String name);
        extern hx::Null<Float> getStatf(::String name);
        extern hx::Null<bool> getAchievement(::String name);

            //RemoteStorage
        bool fileWrite(::String name, ::Array<unsigned char> src, int length);
        int fileRead(::String name, ::Array<unsigned char> dest, int length);

        #if (HXCPP_API_LEVEL>=330)
            typedef void LincSteamworksVoid;
        #else
            typedef Void LincSteamworksVoid;
        #endif

        typedef ::cpp::Function < LincSteamworksVoid(Dynamic) > UserCallbackHandler;
        extern void set_callback(UserCallbackHandler fn);

    } //steam namespace

} //linc namespace
