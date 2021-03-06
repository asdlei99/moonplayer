#-------------------------------------------------
#
# Project created by QtCreator 2012-09-08T16:18:28
#
#-------------------------------------------------


QT += core gui network xml widgets
unix:!macx: QT += gui-private x11extras

macx:  TARGET = MoonPlayer
!macx: TARGET = moonplayer
TEMPLATE = app


SOURCES += main.cpp\
    playlist.cpp \
    skin.cpp \
    httpget.cpp \
    downloader.cpp \
    pyapi.cpp \
    settingsdialog.cpp \
    reslibrary.cpp \
    resplugin.cpp \
    mybuttongroup.cpp \
    detailview.cpp \
    utils.cpp \
    mylistwidget.cpp \
    cutterbar.cpp \
    videocombiner.cpp \
    plugin.cpp \
    updatechecker.cpp \
    selectiondialog.cpp \
    danmakuloader.cpp \
    accessmanager.cpp \
    platforms.cpp \
    yougetbridge.cpp \
    downloaderitem.cpp \
    playerview.cpp \
    playercore.cpp \
    danmakudelaygetter.cpp \
    terminal.cpp \
    ykdlbridge.cpp \
    parserbridge.cpp \
    detectopengl.cpp
!macx: SOURCES += localserver.cpp \
    localsocket.cpp


TRANSLATIONS += moonplayer_zh_CN.ts


HEADERS  +=\
    playlist.h \
    skin.h \
    httpget.h \
    downloader.h \
    pyapi.h \
    settings_video.h \
    settings_network.h \
    settingsdialog.h \
    reslibrary.h \
    resplugin.h \
    accessmanager.h \
    mybuttongroup.h \
    detailview.h \
    utils.h \
    mylistwidget.h \
    settings_audio.h \
    cutterbar.h \
    settings_plugins.h \
    videocombiner.h \
    settings_danmaku.h \
    playercore.h \
    plugin.h \
    updatechecker.h \
    selectiondialog.h \
    danmakudelaygetter.h \
    danmakuloader.h \
    platforms.h \
    yougetbridge.h \
    downloaderitem.h \
    playerview.h \
    terminal.h \
    ykdlbridge.h \
    parserbridge.h \
    detectopengl.h
!macx: HEADERS += localserver.h \
    localsocket.h


FORMS    += \
    playlist.ui \
    settingsdialog.ui \
    reslibrary.ui \
    detailview.ui \
    cutterbar.ui \
    selectiondialog.ui \
    playerview.ui


RESOURCES += \
    icons.qrc

# Installation on Linux
unix:!macx {
    usr_share.files += plugins moonplayer_*.qm Version you_get_patched.py upgrade-you-get.sh upgrade-ykdl.sh upgrade-parsers.sh
    usr_share.path = /usr/share/moonplayer
    #icon
    icon.files += moonplayer.png
    icon.path = /usr/share/icons
    #bin
    execute.files += moonplayer
    execute.path = /usr/bin
    #menu
    menu.files += moonplayer.desktop
    menu.path = /usr/share/applications
    INSTALLS += usr_share icon execute menu
}

# Build bundle for Mac OS X
macx {
    FFMPEG.files = /usr/local/opt/ffmpeg/bin/ffmpeg
    FFMPEG.path = Contents/MacOS
    RESFILES.files = upgrade-you-get.sh upgrade-ykdl.sh upgrade-parsers.sh you_get_patched.py plugins Version
    RESFILES.path = Contents/Resources
    TRANS_FILES.files = moonplayer_zh_CN.qm qt_zh_CN.qm
    TRANS_FILES.path = Contents/Resources/translations
    QMAKE_BUNDLE_DATA += RESFILES FFMPEG TRANS_FILES
    QMAKE_INFO_PLIST = Info.plist
    ICON = moonplayer.icns
}

# Windows icon
win32: RC_FILE = icon.rc

# Libraries
unix:!macx: CONFIG += link_pkgconfig
unix:!macx: PKGCONFIG += python2 mpv
unix:!macx: INCLUDEPATH += /usr/include/qtermwidget5
unix:!macx: LIBS += -lqtermwidget5

macx: INCLUDEPATH += /System/Library/Frameworks/Python.framework/Versions/2.7/include/python2.7 \
    /usr/local/include
macx: LIBS += -F /System/Library/Frameworks -framework CoreFoundation \
    -L/usr/lib -ldl \
    -L/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/config -lpython2.7 \
    -L/usr/local/lib -lmpv

win32: INCLUDEPATH += C:\\Python27\\include
win32: LIBS += C:\\Python27\\libs\\python27.lib
win32: INCLUDEPATH += D:\\Develop\\libmpv\\include
win32: LIBS += D:\\Develop\\libmpv\\32\\mpv.lib
