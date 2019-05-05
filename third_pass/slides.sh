#!/bin/bash
catimg () {
        if [[ -x `which convert` ]]
        then
                zsh $ZSH/plugins/catimg/catimg.sh $@
        else
                echo "catimg need convert (ImageMagick) to work)"
        fi
}
feh -. DockerFail.png
catimg DockerFail.png
echo "Docker, the good, the bad, and the ugly"
read
# don't judge me, I just wanted to make it run.
for i in `ls ./**/*.md`; do
  slides="$slides $i"
done

xmodmap ~/dotfiles/.kensington_remote


# 56-bottom 71-top
vim "+noremap n :next<CR>" "+noremap p :prev<CR>" "+noremap <Home> :prev<CR>" "+noremap <End> :next<CR>"$slides


