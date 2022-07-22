### delds.sh (for zsh)

Simple zsh script to search and delete .DS_Store files in a specific directory (on macOS).

The script shows the found .DS_Store files and ask for confirmation before deleting.

Just execute the script when in the current working directory, or pass a specific directory as argument :
```
cd /working/directory;
/path/to/script/delds.sh
```
OR
```
/path/to/script/delds.sh /specific/directory/to/search
```

Remember to give execution privileges :
```
chmod +x /path/to/script/delds.sh
```

Put the script's path or symbolik link to your $PATH environement variable to use it everywhere.
