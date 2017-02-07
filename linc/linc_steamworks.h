#pragma once

#include <hxcpp.h>

#include "../lib/steam/steam_api.h"

namespace linc {

    namespace steam {

        class CallResultCreateItem
        {

        public:

            void setCallResult(uint64 handle){ 

              m_callResultCreateItem.Set(handle, this, &CallResultCreateItem::ReceiveCallResult);

            };

            void ReceiveCallResult(CreateItemResult_t *pResult, bool bIOFailure){ 
                printf("\nCreateItemCallResult Received!\n"); 
                m_ResultEnum = pResult->m_eResult; 
                m_PublishedFileId = pResult->m_nPublishedFileId;
                m_HasResult = true; 
                m_UserNeedsToAcceptWorkshopLegalAgreement = pResult->m_bUserNeedsToAcceptWorkshopLegalAgreement;
            }

            int GetCallResult(){ return m_ResultEnum; }
            bool GetNeedsToAcceptLicenseAgreement(){ return m_UserNeedsToAcceptWorkshopLegalAgreement; }

            bool HasResult(){ return m_HasResult; }

        private:

            CCallResult<CallResultCreateItem, CreateItemResult_t> m_callResultCreateItem;
            int m_ResultEnum;
            bool m_HasResult;
            bool m_UserNeedsToAcceptWorkshopLegalAgreement;
            PublishedFileId_t m_PublishedFileId;

        };

            //UserStats
        extern hx::Null<int> getStat(::String name);
        extern hx::Null<Float> getStatf(::String name);
        extern hx::Null<bool> getAchievement(::String name);

            //RemoteStorage
        bool fileWrite(::String name, ::Array<unsigned char> src, int length);
        int fileRead(::String name, ::Array<unsigned char> dest, int length);

            //UGC
        static uint64 createItem(int64 appid, int filetype) { return SteamUGC()->CreateItem(appid, static_cast<EWorkshopFileType>(filetype)); }

            //callfunction & callback
        static CallResultCreateItem callresultItem;
        static void setCallResult_CreateItem(uint64 handle){ callresultItem.setCallResult(handle); }

        static hx::Null<bool> getCallResult_CreateItem_HasResult(){ return callresultItem.HasResult(); }
        static hx::Null<int> getCallResult_CreateItem_GetResult(){ return callresultItem.GetCallResult(); }
        static hx::Null<bool> getCallResult_CreateItem_AcceptLicenseAgreement(){ return callresultItem.GetNeedsToAcceptLicenseAgreement(); }

        typedef ::cpp::Function < Void(Dynamic) > UserCallbackHandler;
        extern void set_callback(UserCallbackHandler fn);

    } //steam namespace

} //linc namespace
