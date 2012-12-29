/*
DHLtrack
Written by Tobias Mädel
t.maedel@alfeld.de
http://tbspace.de
*/
using GLib;
using Curses;
using Soup;


namespace DHLTrack{
  class Main{
		public static int main (string[] args)
		{	
			//Inkorrekte Argumente
			if (args.length != 1)
			{
				//The joy of working with modern languages...
				string id = args[1]; //Building up the URL...
				string url = "http://nolp.dhl.de/nextt-online-public/set_identcodes.do?lang=de&idc=" + id;

				var message = new Message("GET",url);
				var session = new SessionSync();
				session.send_message(message);
			    string htmldata = (string)message.response_body.flatten().data;

			    if (htmldata.contains("<div class=\"error\">")) //DHL gibt bei nicht vorhandener ID den Error in dieser CSS-Klasse heraus.
			    {
			    	//Leider nicht vorhanden.
			    	stdout.printf("Es ist keine Sendung mit der ID " + id + " bekannt!\n");
			    	return 0;
			    }
			    else
			    {
			    	//Status der Sendung extrahieren -- evtl. wäre hier ein RegExp besser... 
			    	string status = htmldata.split("<td class=\"status\">")[1].split("</td>")[0].replace("<div class=\"statusZugestellt\">","").replace("</div>","").strip();
					stdout.printf("Status der Sendung mit ID: "+ id + "\n" + status + "\n");
					return 0;
			    }
			}
			else
			{
				//Falsche Anzahl der Argumente
				stdout.printf("Benutzung: dhltrack [Delivery-ID]\n");
				return 0;
			}

		}
	}
}
