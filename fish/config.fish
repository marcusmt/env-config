if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx PATH $PATH:$HOME/Applications/mavend/bin:$HOME/Applications/mavend/mvn

# The next line updates PATH for the Google Cloud SDK.
source $HOME/google-cloud-sdk/path.fish.inc

starship init fish | source