function gtclone
    git clone git@github.com:marcusmt/$argv[1].git
    cd "$argv[1]"

    git remote add upstream git@github.com:$argv[2]/$argv[1].git
    git fetch upstream

    git checkout $argv[3]
    git pull upstream $argv[3]
end
