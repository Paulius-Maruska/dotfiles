docker-compose-up() {
    docker-compose up -d "${*[@]}"
    docker-compose logs -f "${*[@]}"
}
