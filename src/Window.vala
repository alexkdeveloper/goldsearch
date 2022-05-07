
using Gtk;
using Gst;

namespace Goldsearch {

    public class Window : Gtk.Window {

        private Gtk.Image i_1;
		private Gtk.Image i_2;
		private Gtk.Image i_3;
		private Gtk.Image i_4;
		private Gtk.Image i_5;
		private Gtk.Image i_6;
        private Gtk.Image i_7;
		private Gtk.Image i_8;
		private Gtk.Image i_9;
        private Bus bus;
        private Element pipeline_bomb;
        private Element pipeline_coins;
        private int[] mas;
        Gst.Bus bomb_bus;
        Gst.Bus coins_bus;

        public Window (Gtk.Application application) {
            set_application(application);
            try {
                pipeline_bomb = Gst.parse_launch ("playbin uri=resource:/com/github/alexkdeveloper/goldsearch/sounds/bomb.mp3");
                pipeline_coins = Gst.parse_launch("playbin uri=resource:/com/github/alexkdeveloper/goldsearch/sounds/coins.mp3");
              } catch (Error e) {
                 stderr.printf ("Error: %s\n", e.message);
              }
              bus = new Bus (pipeline_bomb, pipeline_coins);
              connect_signals ();
        }

      construct {
        set_title("Gold Search");
        Gtk.HeaderBar headerbar = new Gtk.HeaderBar();
        set_titlebar(headerbar);
        var new_game_button = new Gtk.Button ();
        new_game_button.set_icon_name("input-gaming-symbolic");
        new_game_button.vexpand = false;
      new_game_button.set_tooltip_text("New game");
      new_game_button.clicked.connect(on_new_game_clicked);
      headerbar.pack_start(new_game_button);
       i_1 = new Image ();
       i_1.set_size_request(120,120);
       i_2 = new Image ();
       i_2.set_size_request(120,120);
       i_3 = new Image ();
       i_3.set_size_request(120,120);
       i_4 = new Image ();
       i_4.set_size_request(120,120);
       i_5 = new Image ();
       i_5.set_size_request(120,120);
       i_6 = new Image ();
       i_6.set_size_request(120,120);
       i_7 = new Image ();
       i_7.set_size_request(120,120);
       i_8 = new Image ();
       i_8.set_size_request(120,120);
       i_9 = new Image ();
       i_9.set_size_request(120,120);
       var b_1 = new Button();
       b_1.set_child(i_1);
       var b_2 = new Button();
       b_2.set_child(i_2);
       var b_3 = new Button();
       b_3.set_child(i_3);
       var b_4 = new Button();
       b_4.set_child(i_4);
       var b_5 = new Button();
       b_5.set_child(i_5);
       var b_6 = new Button();
       b_6.set_child(i_6);
       var b_7 = new Button();
       b_7.set_child(i_7);
       var b_8 = new Button();
       b_8.set_child(i_8);
       var b_9 = new Button();
       b_9.set_child(i_9);
       b_1.clicked.connect(() =>{
          show_image(i_1, 1);
       });
       b_2.clicked.connect(() =>{
          show_image(i_2, 2);
       });
       b_3.clicked.connect(() =>{
          show_image(i_3, 3);
       });
       b_4.clicked.connect(() =>{
          show_image(i_4, 4);
       });
       b_5.clicked.connect(() =>{
          show_image(i_5, 5);
       });
       b_6.clicked.connect(() =>{
          show_image(i_6, 6);
       });
       b_7.clicked.connect(() =>{
          show_image(i_7, 7);
       });
       b_8.clicked.connect(() =>{
          show_image(i_8, 8);
       });
       b_9.clicked.connect(() =>{
          show_image(i_9, 9);
       });
        var grid = new Grid();
        grid.halign = Gtk.Align.CENTER;
        grid.valign = Gtk.Align.CENTER;
        grid.margin_bottom = 20;
        grid.margin_top = 20;
        grid.margin_end = 20;
        grid.margin_start = 20;
        grid.row_spacing = 5;
        grid.column_spacing = 5;
        grid.attach(b_1,0,0,1,1);
        grid.attach(b_2,1,0,1,1);
        grid.attach(b_3,2,0,1,1);
        grid.attach(b_4,0,1,1,1);
        grid.attach(b_5,1,1,1,1);
        grid.attach(b_6,2,1,1,1);
        grid.attach(b_7,0,2,1,1);
        grid.attach(b_8,1,2,1,1);
        grid.attach(b_9,2,2,1,1);
        set_child (grid);
        show_barrels();
        generate();
        }
        public void connect_signals(){
            bomb_bus = pipeline_bomb.get_bus ();
            bomb_bus.add_signal_watch ();
            bomb_bus.message.connect (bus.parse_message);
  
            coins_bus = pipeline_coins.get_bus ();
            coins_bus.add_signal_watch ();
            coins_bus.message.connect (bus.parse_message);
        }
        private void on_new_game_clicked(){
            var dialog = new Gtk.MessageDialog(this, Gtk.DialogFlags.MODAL,Gtk.MessageType.QUESTION, Gtk.ButtonsType.OK_CANCEL, _("Start a new game?"));
            dialog.set_title(_("Question"));
            dialog.show ();
            dialog.response.connect((response) => {
                     if (response == Gtk.ResponseType.OK) {
                        show_barrels();
                        generate();
                     }
                     dialog.close();
                 });
        }
        private void generate(){
            mas=new int[9];
            for (int i=0;i<9;i++){
                mas[i]=0;
            }
            int n=Random.int_range(0, 9);
            mas[n]=1;
            int m=0;
            do{
                m=Random.int_range(0, 9);
            }while(m==n);
            mas[m]=2;
            int k=Random.int_range(0, 2);
            int l=0;
            if(k==1){
                do{
                    l=Random.int_range(0, 9);
                }while(l==n||l==m);
                mas[l]=2;
            }
             for(int i=0;i<9;i++){
                if(mas[i]==0){
                    mas[i]=Random.int_range(0, 3)+3;
                }
             }
        }
        private void show_image(Image image, int i){
            image.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[i-1].to_string()+".png");
            if(mas[i-1]==1){
                play_sound("bomb");
                var dialog_alert = new Gtk.MessageDialog(this, Gtk.DialogFlags.MODAL, Gtk.MessageType.INFO, Gtk.ButtonsType.OK, "You found the bomb.\nThe game is over!");
                dialog_alert.set_title(_("Message"));
                dialog_alert.response.connect((_) => { 
                    show_all();
                    dialog_alert.close(); 
                });
                dialog_alert.show();
                return;
            }
            if(mas[i-1]==2){
                play_sound("coins");
            }
        }
        private void show_barrels(){
            i_1.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/barrel.png");
            i_2.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/barrel.png");
            i_3.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/barrel.png");
            i_4.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/barrel.png");
            i_5.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/barrel.png");
            i_6.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/barrel.png");
            i_7.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/barrel.png");
            i_8.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/barrel.png");
            i_9.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/barrel.png");
        }
        private void show_all(){
            i_1.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[0].to_string()+".png");
            i_2.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[1].to_string()+".png");
            i_3.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[2].to_string()+".png");
            i_4.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[3].to_string()+".png");
            i_5.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[4].to_string()+".png");
            i_6.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[5].to_string()+".png");
            i_7.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[6].to_string()+".png");
            i_8.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[7].to_string()+".png");
            i_9.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[8].to_string()+".png");
        }
      private void play_sound(string str){
        if (str == "bomb"){
            pipeline_bomb.set_state(State.PLAYING);
        }else{
            pipeline_coins.set_state(State.PLAYING);
        }
      }
    }
}
