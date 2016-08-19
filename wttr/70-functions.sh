wttr() {
  city=$1
  if [ -z "$city" ]; then
    city=$WTTR_CITY_DEFAULT
  fi
  curl $WTTR_URL/$city
}
