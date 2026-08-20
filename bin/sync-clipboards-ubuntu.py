#!/usr/bin/python3
"""Mirror the X11 clipboard selection into the primary selection on change.

Keeps the "middle-click paste" (primary selection) in sync with the regular
clipboard so that anything copied can also be pasted with a middle click.

See: https://unix.stackexchange.com/a/660344/119298
"""

import signal

import gi

gi.require_version("Gtk", "3.0")
from gi.repository import Gdk, Gtk


def copy_clipboard_to_primary(_clipboard, _event):
    """Copy the current clipboard text into the primary selection.

    Args are ignored; the two selections are looked up fresh each time so the
    callback never closes over an object that may outlive the event.
    """
    clipboard = Gtk.Clipboard.get(Gdk.SELECTION_CLIPBOARD)
    primary = Gtk.Clipboard.get(Gdk.SELECTION_PRIMARY)

    text = clipboard.wait_for_text()  # UTF-8 contents of the clipboard
    primary.set_text(text, -1)  # -1 == derive length automatically


def main():
    # Restore default Ctrl-C handling so the process can be interrupted.
    signal.signal(signal.SIGINT, signal.SIG_DFL)

    clipboard = Gtk.Clipboard.get(Gdk.SELECTION_CLIPBOARD)
    clipboard.connect("owner-change", copy_clipboard_to_primary)

    Gtk.main()


if __name__ == "__main__":
    main()
