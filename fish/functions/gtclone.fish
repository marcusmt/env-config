function gtclone
    git clone git@github.com:marcusmt/$argv[2].git
    cd "$argv[2]"
    git remote add upstream git@github.com:$argv[1]/$argv[2].git
    git fetch upstream

    if test (count $argv) -eq 3
        git checkout $argv[3]
        git pull upstream $argv[3]
    end
end
