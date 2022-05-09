# Zadanie 1. Technologie Chmurowe

## Budowanie obrazu Docker
Żeby zbudować obraz dla dockera musisz:

- skopiować repo

- zbudować obraz za pomocą polecenia:

```
DOCKER_BUILDKIT=1 docker build -t servertcp .
```

Żeby uruchomić wpisz:
```
 docker run -t -p 8080:8080 --name zadanie servertcp:latest 
```

