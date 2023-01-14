#!/usr/bin/python3
# copy clipboard to primary every time it changes
# https://unix.stackexchange.com/a/660344/119298
import signal, gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk

# callback with args (Gtk.Clipboard, Gdk.EventOwnerChange)
def onchange(cb, event):
    text = clipboard.wait_for_text() # convert contents to text in utf8
    primary.set_text(text, -1) # -1 to auto set length

    signal.signal(signal.SIGINT, signal.SIG_DFL) # allow ^C to kill
    primary = Gtk.Clipboard.get(Gdk.SELECTION_PRIMARY)
    clipboard = Gtk.Clipboard.get(Gdk.SELECTION_CLIPBOARD)
    clipboard.connect('owner-change', onchange) # ask for events
    Gtk.main() # loop forever


