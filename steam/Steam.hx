package steam;

//:todo: friends persona name
//:todo: cloud save calls
//:todo: callbacks

typedef UGCUpdateHandle = cpp.UInt64;
typedef UGCPublishedFileID = cpp.UInt64;
typedef SteamAPICall = cpp.UInt64;

@:keep
@:include('linc_steamworks.h')
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('steamworks'))
#end

extern class Steam {

    @:native('linc::steam::set_callback')
    static function setCallback( func:cpp.Callable<Dynamic->Void> ): Void;

    @:native('SteamAPI_Init')
    static function init(): Bool;

    @:native('SteamAPI_Shutdown')
    static function shutdown(): Void;

    @:native('SteamAPI_IsSteamRunning')
    static function isSteamRunning(): Bool;

    @:native('SteamAPI_RunCallbacks')
    static function runCallbacks(): Void;

    @:native('SteamUser')
    static function user() : Dynamic;

    // @:native('SteamFriends')
    // static function friends() : Dynamic;

    // @:native('SteamUtils')
    // static function utils() : Dynamic;

    // @:native('SteamMatchmaking')
    // static function matchmaking() : Dynamic;

    @:native('SteamUserStats')
    static function userStats() : UserStats;

    // @:native('SteamApps')
    // static function apps() : Dynamic;

    // @:native('SteamNetworking')
    // static function networking() : Dynamic;

    // @:native('SteamMatchmakingServers')
    // static function matchmakingServers() : Dynamic;

    @:native('SteamRemoteStorage')
    static function remoteStorage() : RemoteStorage;

    // @:native('SteamScreenshots')
    // static function screenshots() : Dynamic;

    // @:native('SteamHTTP')
    // static function HTTP() : Dynamic;

    // @:native('SteamUnifiedMessages')
    // static function unifiedMessages() : Dynamic;

    // @:native('SteamController')
    // static function controller() : Dynamic;

    @:native('SteamUGC')
    static function ugc() : UGC;

    // @:native('SteamAppList')
    // static function appList() : Dynamic;

    // @:native('SteamMusic')
    // static function music() : Dynamic;

    // @:native('SteamMusicRemote')
    // static function musicRemote() : Dynamic;

    // @:native('SteamHTMLSurface')
    // static function HTMLSurface() : Dynamic;

    // @:native('SteamInventory')
    // static function inventory() : Dynamic;

    // @:native('SteamVideo')
    // static function video() : Dynamic;

} //SteamAPI

@:enum abstract RemoteStoragePlatform(Int) from Int to Int {
    var k_RemoteStoragePlatformNone        = 0;
    var k_RemoteStoragePlatformWindows     = (1 << 0);
    var k_RemoteStoragePlatformOSX         = (1 << 1);
    var k_RemoteStoragePlatformPS3         = (1 << 2);
    var k_RemoteStoragePlatformLinux       = (1 << 3);
    var k_RemoteStoragePlatformReserved2   = (1 << 4);
    var k_RemoteStoragePlatformAll         = 0xffffffff;

    public static inline function toString(val:RemoteStoragePlatform) {
        return switch(val) {
            case k_RemoteStoragePlatformNone: 'None';
            case k_RemoteStoragePlatformWindows: 'Windows';
            case k_RemoteStoragePlatformOSX: 'OSX';
            case k_RemoteStoragePlatformPS3: 'PS3';
            case k_RemoteStoragePlatformLinux: 'Linux';
            case k_RemoteStoragePlatformReserved2: 'Reserved2';
            case k_RemoteStoragePlatformAll: 'All';
        }
    }
}

@:enum abstract WorkshopFileType(Int) from Int to Int {

    var k_WorkshopFileTypeFirst = 0;

    var k_WorkshopFileTypeCommunity              = 0;      // normal Workshop item that can be subscribed to
    var k_WorkshopFileTypeMicrotransaction       = 1;      // Workshop item that is meant to be voted on for the purpose of selling in-game
    var k_WorkshopFileTypeCollection             = 2;      // a collection of Workshop or Greenlight items
    var k_WorkshopFileTypeArt                    = 3;      // artwork
    var k_WorkshopFileTypeVideo                  = 4;      // external video
    var k_WorkshopFileTypeScreenshot             = 5;      // screenshot
    var k_WorkshopFileTypeGame                   = 6;      // Greenlight game entry
    var k_WorkshopFileTypeSoftware               = 7;      // Greenlight software entry
    var k_WorkshopFileTypeConcept                = 8;     // Greenlight concept
    var k_WorkshopFileTypeWebGuide               = 9;      // Steam web guide
    var k_WorkshopFileTypeIntegratedGuide        = 10;     // application integrated guide
    var k_WorkshopFileTypeMerch                  = 11;     // Workshop merchandise meant to be voted on for the purpose of being sold
    var k_WorkshopFileTypeControllerBinding      = 12;     // Steam Controller bindings
    var k_WorkshopFileTypeSteamworksAccessInvite = 13;     // internal
    var k_WorkshopFileTypeSteamVideo             = 14;     // Steam video
    var k_WorkshopFileTypeGameManagedItem        = 15;     // managed completely by the game, not the user, and not shown on the web

    // Update k_EWorkshopFileTypeMax if you add values.
    var k_WorkshopFileTypeMax = 16;
}

@:enum abstract RemoteStoragePublishedFileVisibility(Int) from Int to Int {

    var k_RemoteStoragePublishedFileVisibilityPublic = 0;
    var k_RemoteStoragePublishedFileVisibilityFriendsOnly = 1;
    var k_RemoteStoragePublishedFileVisibilityPrivate = 2;

}

@:enum abstract ItemPreviewType(Int) from Int to Int {

    var k_EItemPreviewType_Image = 0;
    var k_EItemPreviewType_YouTubeVideo = 1;
    var k_EItemPreviewType_Sketchfab = 2;
    var k_EItemPreviewType_EnvironmentMap_HorizontalCross = 3;
    var k_EItemPreviewType_EnvironmentMap_LatLong = 4;
    var k_EItemPreviewType_ReservedMax = 255;

}

@:keep
@:include('linc_steamworks.h')
@:native('ISteamRemoteStorage*')
extern class RemoteStorage {

    @:native('linc::steam::fileWrite')
    private static function _fileWrite(filename:String, src:haxe.io.BytesData, length:Int) : Bool;
    inline function fileWrite(filename:String, src:haxe.io.BytesData, length:Int) : Bool return _fileWrite(filename,src,length);

    @:native('linc::steam::fileRead')
    private static function _fileRead(filename:String, dest:haxe.io.BytesData, length:Int) : Int;
    inline function fileRead(filename:String, dest:haxe.io.BytesData, length:Int) : Int return _fileRead(filename,dest,length);

    @:native('FileForget')
    function fileForget(filename:String) : Bool;

    @:native('FileDelete')
    function fileDelete(filename:String) : Bool;

    @:native('SetSyncPlatforms')
    function setSyncPlatforms(filename:String, platform:RemoteStoragePlatform) : Bool;


    // virtual SteamAPICall_t FileShare( const char *pchFile ) = 0;

    // virtual UGCFileWriteStreamHandle_t FileWriteStreamOpen( const char *pchFile ) = 0;
    // virtual bool FileWriteStreamWriteChunk( UGCFileWriteStreamHandle_t writeHandle, const void *pvData, int32 cubData ) = 0;
    // virtual bool FileWriteStreamClose( UGCFileWriteStreamHandle_t writeHandle ) = 0;
    // virtual bool FileWriteStreamCancel( UGCFileWriteStreamHandle_t writeHandle ) = 0;

    // file information
    @:native('FileExists')
    function fileExists(filename:String) : Bool;

    @:native('FilePersisted')
    function filePersisted(filename:String) : Bool;
    
    @:native('GetFileSize')
    function getFileSize(filename:String) : Int;

    @:native('GetFileTimestamp')
    function getFileTimestamp(filename:String) : haxe.Int64;

    // virtual ERemoteStoragePlatform GetSyncPlatforms( const char *pchFile ) = 0;
    @:native('GetSyncPlatforms')
    function getSyncPlatforms(filename:String) : RemoteStoragePlatform;

    // iteration
    @:native('GetFileCount')
    function getFileCount() : Int;
    // virtual const char *GetFileNameAndSize( int iFile, int32 *pnFileSizeInBytes ) = 0;
    // configuration management
    // virtual bool GetQuota( int32 *pnTotalBytes, int32 *puAvailableBytes ) = 0;

    @:native('IsCloudEnabledForAccount')
    function isCloudEnabledForAccount() : Bool;

    @:native('IsCloudEnabledForApp')
    function isCloudEnabledForApp() : Bool;

    @:native('SetCloudEnabledForApp')
    function setCloudEnabledForApp( enabled:Bool ) : Void;

} //RemoteStorage

@:keep
@:include('linc_steamworks.h')
@:native('ISteamUserStats*')
extern class UserStats {

    @:native('RequestCurrentStats')
    function requestCurrentStats():Bool;

    @:native('linc::steam::getStat')
    private static function _getStat(name:String):Null<Int>;
    inline function getStat(name:String):Null<Int> return _getStat(name);

    @:native('linc::steam::getStatf')
    private static function _getStatf(name:String):Null<Float>;
    inline function getStatf(name:String):Null<Float> return _getStatf(name);

    @:native('SetStat')
    function setStat(name:String, val:Int):Bool;
    
    @:native('SetStat')
    function setStatf(name:String, val:Float):Bool;

    @:native('UpdateAvgRateStat')
    function updateAvgRateStat(name:String, countThisSession:Float, SessionLength:Float):Bool;

    @:native('linc::steam::getAchievement')
    private static function _getAchievement(name:String):Bool;
    inline function getAchievement(name:String):Bool return _getAchievement(name);

    @:native('SetAchievement')
    function setAchievement(name:String):Bool;

    @:native('ClearAchievement')
    function clearAchievement(name:String):Bool;

    // @:native('GetAchievementAndUnlockTime')
    //:todo: function GetAchievementAndUnlockTime(name:String):{ achieved:Bool, time:Bool }

    @:native('StoreStats')
    function storeStats():Bool;

    @:native('GetAchievementIcon')
    function getAchievementIcon(name:String):Bool;

    @:native('GetAchievementDisplayAttribute')
    private function _getAchievementDisplayAttribute(name:String, key:String):cpp.ConstCharStar;
    inline function getAchievementDisplayAttribute(name:String, key:String):String
        return cast _getAchievementDisplayAttribute(name, key);

    @:native('IndicateAchievementProgress')
    function indicateAchievementProgress(name:String, curProgress:UInt, maxProgress:UInt):Bool;

    @:native('GetNumAchievements')
    function getNumAchievements() : UInt;

    @:native('GetAchievementName')
    private function _getAchievementName(index:UInt):cpp.ConstCharStar;
    inline function getAchievementName(index:UInt) : String return cast _getAchievementName(index);

    @:native('ResetAllStats')
    function resetAllStats( andAchievements:Bool ):Bool; 

} //UserStats

@:keep
@:include('linc_steamworks.h')
@:native('ISteamUGC*')
extern class UGC {

    @:native('linc::steam::createItem')
    private static function _createItem(appId:cpp.Int64, fileType:Int):SteamAPICall;
    inline function createItem(appId:cpp.Int64, fileType:Int) : SteamAPICall return _createItem(appId, fileType);

    @:native('linc::steam::setCallResult_CreateItem')
    private static function _setCallResult_CreateItem( handle:SteamAPICall ): Void;
    inline function setCallResult_CreateItem( handle:SteamAPICall ) : Void { _setCallResult_CreateItem(handle); };

    @:native('linc::steam::getCallResult_CreateItem_HasResult')
    private static function _getCallResult_CreateItem_HasResult(): Null<Bool>;
    inline function getCallResult_CreateItem_HasResult() : Null<Bool> { return _getCallResult_CreateItem_HasResult(); };

    @:native('linc::steam::getCallResult_CreateItem_GetResult')
    private static function _getCallResult_CreateItem_GetResult(): Null<Int>;
    inline function getCallResult_CreateItem_GetResult() : Null<Int> { return _getCallResult_CreateItem_GetResult(); };

    @:native('linc::steam::getCallResult_CreateItem_AcceptLicenseAgreement')
    private static function _getCallResult_CreateItem_AcceptLicenseAgreement(): Null<Bool>;
    inline function getCallResult_CreateItem_AcceptLicenseAgreement() : Null<Bool> { return _getCallResult_CreateItem_AcceptLicenseAgreement(); };

    @:native('linc::steam::getCallResult_CreateItem_GetPublishedFileID')
    private static function _getCallResult_CreateItem_GetPublishedFileID(): UGCPublishedFileID;
    inline function getCallResult_CreateItem_GetPublishedFileID() : UGCPublishedFileID { return _getCallResult_CreateItem_GetPublishedFileID(); };

    @:native('linc::steam::setCallResult_SubmitItem')
    private static function _setCallResult_SubmitItem( handle:SteamAPICall ): Void;
    inline function setCallResult_SubmitItem( handle:SteamAPICall ) : Void { _setCallResult_SubmitItem(handle); };

    @:native('linc::steam::getCallResult_SubmitItem_HasResult')
    private static function _getCallResult_SubmitItem_HasResult(): Null<Bool>;
    inline function getCallResult_SubmitItem_HasResult() : Null<Bool> { return _getCallResult_SubmitItem_HasResult(); };

    @:native('linc::steam::getCallResult_SubmitItem_GetResult')
    private static function _getCallResult_SubmitItem_GetResult(): Null<Int>;
    inline function getCallResult_SubmitItem_GetResult() : Null<Int> { return _getCallResult_SubmitItem_GetResult(); };

    @:native('StartItemUpdate')
    function startItemUpdate(appId:cpp.Int64, publishedFileID:UGCPublishedFileID):UGCUpdateHandle;

    @:native('SetItemTitle')
    function setItemTitle(handle:UGCUpdateHandle, title:String):Bool;

    @:native('SetItemDescription')
    function setItemDescription(handle:UGCUpdateHandle, description:String):Bool;

    @:native('SetItemUpdateLanguage')
    function setItemUpdateLanguage(handle:UGCUpdateHandle, language:String):Bool;

    @:native('SetItemMetadata')
    function setItemMetadata(handle:UGCUpdateHandle, language:String):Bool;

    @:native('linc::steam::setItemVisibility')
    private static function _setItemVisibility(handle:UGCUpdateHandle, visibility:Int) : Bool;
    inline function setItemVisibility(handle:UGCUpdateHandle, visibility:Int) : Bool { return _setItemVisibility(handle, visibility); };

    //@:native('SetItemTags')
    //function setItemTags(handle:UGCUpdateHandle, tags:SteamParamStringArray):Bool;

    @:native('SetItemContent')
    function setItemContent(handle:UGCUpdateHandle, contentfolder:String):Bool;

    @:native('SetItemPreview')
    function setItemPreview(handle:UGCUpdateHandle, previewfile:String):Bool;

    @:native('RemoveItemKeyValueTags')
    function removeItemKeyValueTags(handle:UGCUpdateHandle, key:String):Bool;
    
    @:native('AddItemKeyValueTag')
    function addItemKeyValueTag(handle:UGCUpdateHandle, key:String, tag:String):Bool;

    @:native('AddItemPreviewFile')
    function addItemPreviewFile(handle:UGCUpdateHandle, previewfile:String, type:ItemPreviewType):Bool;

    @:native('AddItemPreviewVideo')
    function addItemPreviewVideo(handle:UGCUpdateHandle, videoID:String):Bool;

    @:native('UpdateItemPreviewFile')
    function updateItemPreviewFile(handle:UGCUpdateHandle, index:cpp.UInt32, previewfile:String):Bool;

    @:native('UpdateItemPreviewVideo')
    function updateItemPreviewVideo(handle:UGCUpdateHandle, index:cpp.UInt32, videoID:String):Bool;

    @:native('RemoveItemPreview')
    function removeItemPreview(handle:UGCUpdateHandle, index:cpp.UInt32):Bool;

    @:native('SubmitItemUpdate')
    function submitItemUpdate(handle:UGCUpdateHandle, changeNote:String) : SteamAPICall;
    
    @:native('linc::steam::getNumSubscribedItems')
    private static function _getNumSubscribedItems(): Null<Int>;
    inline function getNumSubscribedItems() : Null<Int> { return _getNumSubscribedItems(); };

    @:native('linc::steam::getSubscribedItemsList')
    private static function _getSubscribedItemsList(maxEntries : Int) : Void;
    inline function getSubscribedItemsList(maxEntries : Int) : Void return _getSubscribedItemsList(maxEntries);

    @:native('linc::steam::getSubscribedItem')
    private static function _getSubscribedItem(value : Int) : Int;
    inline function getSubscribedItem(value : Int) : Int return _getSubscribedItem(value);

    @:native('linc::steam::getSubscribedItemFilepath')
    private static function _getSubscribedItemFilepath(itemID : Int) : cpp.ConstCharStar;
    inline function getSubscribedItemFilepath(itemID : Int) : String return cast _getSubscribedItemFilepath(itemID);

} //UGC