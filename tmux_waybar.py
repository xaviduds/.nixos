import libtmux

# Connect to the tmux server
server = libtmux.Server()

# Get the current session
session = server.find_where({"session_name": "foo"})

# Get the current window
window = session.attached_window

# Print the window number and an asterisk
print(f"Window number: {window.get('window_index')} *")
