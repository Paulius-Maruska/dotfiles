# add go path if it exists
# Note: on OS X go installs itself into /usr/local/go
# it is also the default location for linux as well
if [ -x /usr/local/go/bin/go ]; then
    export GOLANG_ROOT=/usr/local/golang
    export GOROOT=/usr/local/go
    export GOPATH=$GOLANG_PROJECTS
    export PATH=$GOROOT/bin:$GOPATH/bin:$PATH
fi

if [ -d $GOLANG_PROJECTS ]; then
    export GOPATH=$GOLANG_PROJECTS
fi
