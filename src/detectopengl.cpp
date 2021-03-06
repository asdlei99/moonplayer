#include <mpv/client.h>
#include <QSurfaceFormat>
#include <QSettings>

#ifdef Q_OS_MAC
void detectOpenGL()
{
  // Request OpenGL 4.1 if possible on OSX, otherwise it defaults to 2.0
  // This needs to be done before we create the QGuiApplication
  //
  QSurfaceFormat format = QSurfaceFormat::defaultFormat();
  format.setMajorVersion(3);
  format.setMinorVersion(2);
  format.setProfile(QSurfaceFormat::CoreProfile);
  QSurfaceFormat::setDefaultFormat(format);
}
#endif

#ifdef Q_OS_LINUX
// Attempt to reuse mpv's code for detecting whether we want GLX or EGL (which
// is tricky to do because of hardware decoding concerns). This is not pretty,
// but quite effective and without having to duplicate too much GLX/EGL code.
static QString probeHwdecInterop()
{
    QString result;
    mpv_handle *mpv = mpv_create();
    if (!mpv)
        return "";
    mpv_set_option_string(mpv, "hwdec-preload", "auto");
    mpv_set_option_string(mpv, "opengl-hwdec-interop", "auto");
    // Actually creating a window is required. There is currently no way to keep
    // this window hidden or invisible.
    mpv_set_option_string(mpv, "force-window", "yes");
    // As a mitigation, put the window in the top/right corner, and make it as
    // small as possible by forcing 1x1 size and removing window borders.
    mpv_set_option_string(mpv, "geometry", "1x1+0+0");
    mpv_set_option_string(mpv, "border", "no");
    if (mpv_initialize(mpv) < 0)
        return "";
    char *str = mpv_get_property_string(mpv, "hwdec-interop");
    if (str)
    {
        qInfo("Detected OpenGL backend: %s", str);
        result = str;
        mpv_free(str);
    }
    mpv_terminate_destroy(mpv);
    return result;
}

void detectOpenGL()
{
    QString hwdec = QSettings("moonsoft", "moonplayer").value("Video/hwdec").toString();
    if (hwdec == "vaapi")
        qputenv("QT_XCB_GL_INTEGRATION", "xcb_egl");
    else if (hwdec == "auto")
    {
        if (probeHwdecInterop() == "vaapi-egl")
            qputenv("QT_XCB_GL_INTEGRATION", "xcb_egl");
    }
}
#endif
