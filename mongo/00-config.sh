# where to look for mongo helper scripts
MONGO_SCRIPTS_PATH=$DOTFILES/mongo/scripts

mongoshell() {
  mongo --shell $* $(ls $MONGO_SCRIPTS_PATH/*.js 2>/dev/null)
}
