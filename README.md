# fcitx-remote-osx

CLI 切换输入法

默认英文输入法 ABC  
中文输入法 搜狗

可修改源代码更改

安装方式

```bash
git clone https://github.com/zeekrs/fcitx-remote-osx.git

xcodebuild clean install -project fcitx-remote.xcodeproj    -target fcitx-remote -configuration Release DSTROOT="/"

fcitx-remote  [OPTION]

       -c     inactivate input method

       -o     activate input method

       -t     switch between active/inactive

       -n     display current imname

       -s imname
              switch to the input method uniquely identified by imname

       [no option]
              display fcitx state, 0 for close, 1 for inactive, 2 for active

       -h     display help and exit

```
