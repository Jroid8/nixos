#!@fish@
test -n "$PATH"; and set -x PATH @path@ $PATH; or set -x PATH @path@

cd $HOME/.local/share/qutebrowser/

#### Clean History ####
test -e history.sqlite-shm && exit 1
60 * 60 * 24 * 3 = 259200
set expirationTime (math (date +%s) - 259200)
sqlite3 history.sqlite "DELETE FROM History WHERE atime <= $expirationTime"

#### Clean Site Data ####
cd webengine
set sdcex $HOME/.config/qutebrowser/sitedata-clean-exceptions
set exceptions (cat sdcex)

set sqliteDelCond
for ex in $exceptions
    if test -n "$ex"
        set sqliteDelCond $sqliteDelCond "(host_key NOT LIKE '$ex')"
    end
end
set sqliteDelCond (string join " AND " $sqliteDelCond)
set sqliteDelCond (string replace -a \* % $sqliteDelCond | string replace -a ? _ $sqliteDelCond)

sqlite3 Cookies "DELETE FROM cookies WHERE $sqliteDelCond"
rm -r Favicons Favicons-journal 'Service Worker' WebStorage

cd IndexedDB
for d in *
    set u (string split _0 $d)[1]
    for e in $exceptions
        if string match -q $e $u
            set d ''
            break
        end
    end
    if test -n "$d"
        rm -r $d
    end
end
cd ..

echo "import plyvel
from fnmatch import fnmatch
from urllib.parse import urlsplit

exceptions = open('$sdcex').read().splitlines()
db = plyvel.DB('Local Storage/leveldb')
wb = db.write_batch()
for key, _ in db:
    if key.startswith(b'_'):
        netloc = urlsplit(key.decode()[1:]).netloc
        if all(not fnmatch(netloc, pat) for pat in exceptions):
            wb.delete(key)
wb.write()" | python -
