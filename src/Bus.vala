

using Gst;

namespace Goldsearch {

  public class Bus {

    private Element pipeline_bomb;
    private Element pipeline_coins;

    public Bus (Element pipeline_bomb, Element pipeline_coins) {
        this.pipeline_bomb = pipeline_bomb;
        this.pipeline_coins = pipeline_coins;
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

          if(message.src == this.pipeline_bomb){
            this.pipeline_bomb.seek_simple (Gst.Format.TIME,  Gst.SeekFlags.FLUSH | Gst.SeekFlags.KEY_UNIT, 0);
            this.pipeline_bomb.set_state (Gst.State.NULL);
          }

          if(message.src == this.pipeline_coins){
            this.pipeline_coins.seek_simple (Gst.Format.TIME,  Gst.SeekFlags.FLUSH | Gst.SeekFlags.KEY_UNIT, 0);
            this.pipeline_coins.set_state (Gst.State.NULL);
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
