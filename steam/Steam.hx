package steam;

//:todo: friends persona name
//:todo: cloud save calls
//:todo: callbacks

@:keep
@:include('linc_steamworks.h')
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('steamworks'))
extern class Steam {

    @:native('linc::steam::set_callback')
    static function set_callback( func:cpp.Callable<Dynamic->Void> ): Void;

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

    // @:native('SteamUGC')
    // static function UGC() : Dynamic;

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
    function getAchievement(name:String):Bool;

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