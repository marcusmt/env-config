if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx PATH $PATH $HOME/Applications/mavend/bin
set -gx PATH $PATH $HOME/Applications/mavend/mvn/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/1002/google-cloud-sdk/path.fish.inc' ]; . '/home/1002/google-cloud-sdk/path.fish.inc'; end

starship init fish | source
