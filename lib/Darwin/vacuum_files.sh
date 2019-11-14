home=$HOME
for d in .Trash Downloads; do
  find -d $HOME/$d -print0 -atime +360d | xargs -0 ls -l
done
