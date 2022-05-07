

using Gst;

namespace Goldsearch {

  public class Bus {

    private Element pipeline_bombe;
    private Element pipeline_monets;

    public Bus (Element pipeline_bombe, Element pipeline_monets) {
        this.pipeline_bombe = pipeline_bombe;
        this.pipeline_monets = pipeline_monets;
    }

    public void parse_message (Message message){
      if (message != null) {
        switch (message.type) {
        case Gst.MessageType.ERROR:
          GLib.Error err;
          string debug_info;

          message.parse_error (out err, out debug_info);
          stderr.printf ("Error received from element %s: %s\n", message.src.name, err.message);
          stderr.printf ("Debugging information: %s\n", (debug_info != null)? debug_info : "none");
          break;

        case Gst.MessageType.EOS:
          stdout.puts ("End-Of-Stream reached.\n");

          if(message.src == this.pipeline_bombe){
            this.pipeline_bombe.seek_simple (Gst.Format.TIME,  Gst.SeekFlags.FLUSH | Gst.SeekFlags.KEY_UNIT, 0);
            this.pipeline_bombe.set_state (Gst.State.NULL);
          }

          if(message.src == this.pipeline_monets){
            this.pipeline_monets.seek_simple (Gst.Format.TIME,  Gst.SeekFlags.FLUSH | Gst.SeekFlags.KEY_UNIT, 0);
            this.pipeline_monets.set_state (Gst.State.NULL);
          }
          break;

        case Gst.MessageType.STATE_CHANGED:
            Gst.State old_state;
            Gst.State new_state;
            Gst.State pending_state;

            message.parse_state_changed (out old_state, out new_state, out pending_state);
            break;
        }
      }
    }
  }
}
