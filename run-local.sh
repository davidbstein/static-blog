mkdir compiled-site
echo "- starting server"
cd compiled-site
python -m SimpleHTTPServer 8888 &
PYTHON_PID=$!
cd ..

start_it () {
    echo "- building directory structure"
    cd content
    find * -type d -exec mkdir ../compiled-site/\{\} \;
    cd ..
    echo "- copying static content"
    rm -rf compiled-site/external
    cp -rf external compiled-site/external
    rm -rf compiled-site/static
    cp -rf static compiled-site/static

    echo "- compiling templates"
    for f in $(find content -type f); do
        python build_content.py $f
    done

    echo "- compiling coffee"
    # -w to turn on watching
    coffee -m -o compiled-site/compiled-coffee -c coffee
}


int_handler() {
    echo "killed - insuring webserver is dead."
    kill $PYTHON_PID
    exit 1
}
trap 'int_handler' INT


while true; do
    new=$(
        find "." -not \( -type d -name ".?*" -prune \) -not -path "./compiled-site*" -print0 2>/dev/null |
        xargs -0 stat -f "%m %z %N" |
        md5)
    if [ "$new" != "$old" ]; then
        old=$new;
        start_it || echo "err!";
    fi
    sleep 0.5
done
