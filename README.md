# linc/steamworks
Haxe @:native bindings for the Valve Steamworks SDK.    

**Please note this library is a work in progress.**       
While it has been used in 2 shipped Steam games, it only has as much as was needed for those games. Filling out the rest of the library will take time. Currently mostly `UserStats`, `RemoteStorage` and `UGC` are usable.

To use this library an agreement and account are required.   
Visit https://partner.steamgames.com/ for full details, and the SDK download.

This is a [linc](http://snowkit.github.io/linc/) library.

---

This library works with the Haxe cpp target only.

---
### Install

`haxelib git linc_steamworks https://github.com/snowkit/linc_steamworks.git`

### Usage

Note there is a setup process below.

1. Import the API.
```haxe
#if linc_steamworks
import steam.Steam;
#end
```

2. Initialize the API. It's important that this happen as early as possible in your game. This might mean before the window is created for the overlay to work, depending. See below for usage with snow.

```haxe
bool has_steam = Steam.init();
//use has_steam before calling ANY Steam API's, as it will crash otherwise.
```

3. Set the callbacks to get state back, if needed. A lot of things don't need the callback.

```haxe
static function steamCallbackHandler(val:Dynamic) { ... }
// ...
if(has_steam) Steam.setCallback(cpp.Callable.fromStaticFunction(steamCallbackHandler));
```

4. call update frequently (like every frame)

```haxe
if(has_steam) Steam.runCallbacks();
```

5. Use the API. The API follows the SDK API directly.

```haxe
if(has_steam) Steam.userStats().setAchievement("SOME_ACH_ID");
```

6. Call shutdown

```haxe
Steam.shutdown();
```

### VERY IMPORTANT setup for after install

You need to copy the sdk files to your linc_steamworks folder.

#### Copy the sdk headers

- Make a folder inside lib called steam: `lib/steam/`
- Copy `<sdk>/public/steam/*.h`
- I'd suggest keeping a note of which sdk version you're copying

#### Copy the library files

- Look inside `lib/library/`
- Copy the correct dll/dylib/so into the correct folder 
- Double check the right file/version/os, crashes/confusion otherwise

#### Done 

The folder should look like this:

```
linc_steamworks/
  - lib/
    - steam/
      - *.h
    - library/
      - Mac32/libsteam_api.dylib
      - Mac64/libsteam_api.dylib
      - Linux32/libsteam_api.so
      - Linux64/libsteam_api.so
      - Windows32/steam_api.lib + steam_api.dll
      - Windows64/steam_api64.lib + steam_api64.dll
```

### Usage with snow

In order to call the init function as early as possible, you can listen for the low level snow `ready` event.

```haxe

override function onevent(e:snow.types.Types.SystemEvent) {

    #if linc_steamworks

        if(e.type == snow.types.Types.SystemEventType.se_ready) {
            
            has_steam = Steam.init();
            
            if(has_steam) Steam.setCallback(cpp.Callable.fromStaticFunction(steamCallbackHandler));
            
            trace('Steam initialized! $has_steam');

        } else if (e.type == snow.types.Types.SystemEventType.se_quit) {

            Steam.shutdown();

        }

    #end

} //onevent

```
