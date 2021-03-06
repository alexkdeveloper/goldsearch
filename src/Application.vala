

using Gtk;

namespace Goldsearch {

public class Application : Adw.Application {

    private static Application app;
    private Window window = null;

    public Application () {
        Object (application_id: "com.github.alexkdeveloper.goldsearch",
        flags: ApplicationFlags.FLAGS_NONE);
    }

    protected override void activate () {
        if (window != null) {
            window.present ();
            return;
        }
        window = new Window (this);
        window.show();
    }

    public static Application get_instance () {
        if (app == null)
            app = new Application ();
        return app;
    }

    public static int main (string[] args) {
        Intl.bindtextdomain (Config.GETTEXT_PACKAGE, Config.LOCALEDIR);
        Intl.bind_textdomain_codeset (Config.GETTEXT_PACKAGE, "UTF-8");
        Intl.textdomain (Config.GETTEXT_PACKAGE);
        Gst.init(ref args);
        app = new Application ();
        return app.run (args);
    }
  }
}
