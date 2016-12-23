# add go path if it exists
# Note: on OS X go installs itself into /usr/local/go
if [ -x /usr/local/go/bin/go ]; then
    export PATH=/usr/local/go/bin:$PATH
fi

if [ -d $PROJECTS/_golang ]; then
    export GOPATH=$PROJECTS/_golang
fi
