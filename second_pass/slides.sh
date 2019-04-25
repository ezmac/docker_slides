#!/bin/bash
catimg () {
        if [[ -x `which convert` ]]
        then
                zsh $ZSH/plugins/catimg/catimg.sh $@
        else
                echo "catimg need convert (ImageMagick) to work)"
        fi
}
catimg docker_fail_whale.png
read
# don't judge me, I just wanted to make it run.
for i in `ls ./*.md`; do
  slides="$slides $i"
done

vim "+noremap n :next<CR>" "+noremap p :prev<CR>" $slides


