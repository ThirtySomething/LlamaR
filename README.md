# LlamaR

`Llama Reborn` - KI updated version of the original `Llama - Location Profiles` app by [KebabApps][url_kebabapps].

## Introduction

The original app enables the user to trigger actions depending on various settings. I've used this e. g. to activate/deactivate silent mode when entering/leaving business. The triggers used have been GSM towers. Biggest benefit from my side have been

- No costs, LLama has been for free on Android Play Store
- Privacy - all information about triggers and so on has been stored on the mobile. No cloud, no provider.

Unfortunately the developer stopped working on this software. It seems also that he's stopped working using the alias [KebabApps][url_kebabapps]. The homepage looks abandoned, the latest post has been from November 21, 2014. Even in the [Google Play store][url_wiki_google_play] the software has been gone - the search result will not contain the software.

The homepage of [KebabApps][url_kebabapps] offers the latest version for download: [`Llama.1.2014.11.20.2330.apk`][file_llama_apk] - I've added it to this repository to preserve the latest state.

## The idea

As far as I know it's possible to [reverse engineer][url_wiki_reverse_engineering] the source code of an [APK file][url_wiki_apk_file]. So I asked myself: Why not [reverse engineer][url_wiki_reverse_engineering] LLama, upgrade it to latest [Android SDK][url_wiki_android_sdk] using [AI][url_wiki_ai] and - if possible - place it in [Google Play store][url_wiki_google_play]?

## The steps

- ~~First of all download and preserve the latest official [APK file][url_wiki_apk_file] of `Llama`~~ done at 24.04.2026
- ~~[Reverse engineer][url_wiki_reverse_engineering] the original [APK file][url_wiki_apk_file] to get the source code~~ done at 24.04.2026

### Reverse engineering

To [reverse engineer][url_wiki_reverse_engineering] the [APK file][url_wiki_apk_file] you need to run `re.bat` with admin privileges. The script will

- Download the Llama apk from this repository on GitHub
- Download latest version of JADX decompiler from GitHub
- Decompile the Llama apk

[file_llama_apk]: ./assets/Llama.1.2014.11.20.2330.apk
[url_7zip]: https://www.7-zip.org
[url_kebabapps]: https://kebabapps.blogspot.com/
[url_wiki_ai]: https://en.wikipedia.org/wiki/Artificial_intelligence
[url_wiki_android_sdk]: https://en.wikipedia.org/wiki/Android_SDK
[url_wiki_apk_file]: https://en.wikipedia.org/wiki/Apk_(file_format)
[url_wiki_google_play]: https://en.wikipedia.org/wiki/Google_Play
[url_wiki_reverse_engineering]: https://en.wikipedia.org/wiki/Reverse_engineering
