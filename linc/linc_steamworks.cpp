#include <hxcpp.h>
#include "./linc_steamworks.h"


namespace linc {

    namespace steam {

        //UserStats

            hx::Null<int> getStat(::String name) {

                int32 data;
                bool result = SteamUserStats()->GetStat( name, &data );
                if(!result) return null();
                return (int)data;

            } //getStat

            hx::Null<Float> getStatf(::String name) {

                float data;
                bool result = SteamUserStats()->GetStat( name, &data );
                if(!result) return null();
                return data;

            } //getStatf

            hx::Null<bool> getAchievement(::String name) {

                bool value;
                bool result = SteamUserStats()->GetAchievement(name, &value);
                if(!result) return null();
                return value;

            } //getAchievement

        //RemoteStorage

            bool fileWrite(::String name, ::Array<unsigned char> src, int length) {

                return SteamRemoteStorage()->FileWrite(name.c_str(), (const void*)&src[0], length);

            } //fileWrite

            int fileRead(::String name, ::Array<unsigned char> dest, int length) {

                return SteamRemoteStorage()->FileRead(name.c_str(), (void*)&dest[0], length);

            } //fileRead

    //Callback types

        struct Callbacks {
            Callbacks():
                stats_received(this, &Callbacks::on_stats_received),
                stats_stored(this, &Callbacks::on_stats_stored),
                ach_stored(this, &Callbacks::on_ach_stored)
            {
                //constructor
            }

            STEAM_CALLBACK( Callbacks, on_stats_received, UserStatsReceived_t,     stats_received );
            STEAM_CALLBACK( Callbacks, on_stats_stored,   UserStatsStored_t,       stats_stored );
            STEAM_CALLBACK( Callbacks, on_ach_stored,     UserAchievementStored_t, ach_stored );
        };

    //Callback setter
        static UserCallbackHandler callback_fn;
        static Callbacks* callbacks = NULL;

        void set_callback(UserCallbackHandler fn) {

            callback_fn = fn;

            if(callbacks != NULL) {
                delete callbacks;
                callbacks = NULL;
            }

            callbacks = new Callbacks();

        } //set_callback

    //callback handlers

        static void emit_callback(Dynamic val) {
            if(null() != callback_fn) {
                callback_fn(val);
            }
        }

        void Callbacks::on_stats_received( UserStatsReceived_t *_result ) {
            printf("Stats received:%d game:%llu userid:%llu\n",
                (int)_result->m_eResult, 
                _result->m_nGameID,
                _result->m_steamIDUser.ConvertToUint64()
            );
            emit_callback(::String("Stats received!"));
        }

        void Callbacks::on_stats_stored( UserStatsStored_t *_result ) {
            printf("Stats stored:%d game:%llu\n",
                (int)_result->m_eResult, 
                _result->m_nGameID
            );
            emit_callback(::String("Stats stored!"));
        }

        void Callbacks::on_ach_stored( UserAchievementStored_t *_result ) {
            printf("Achievement stored: %s progress:%d/%d group:%d game:%llu\n",
                _result->m_rgchAchievementName, 
                _result->m_nCurProgress,
                _result->m_nMaxProgress,
                _result->m_bGroupAchievement,
                _result->m_nGameID
            );
            emit_callback(::String("Achievement stored!"));
        }        

    } //steam namespace

} //linc namespace
