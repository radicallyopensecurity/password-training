@echo off
setlocal EnableDelayedExpansion

REM Stop all containers of this demo
call stop.bat

REM Define the keywords to match in image names
set KEYWORDS=beef juice caddy

REM Initialize CONTAINER_IDS
set CONTAINER_IDS=

REM List all running containers and filter by image name
for /f "tokens=1,2" %%i in ('docker ps --format "{{.ID}} {{.Image}}" ^| findstr /r "%KEYWORDS%"') do (
    set CONTAINER_IDS=%%i !CONTAINER_IDS!
)

REM Check if there are any containers to stop and remove
if defined CONTAINER_IDS (
    echo There are still containers running that are based on an image matching '%KEYWORDS%'. These are probably leftovers from an earlier version/run.
    echo more details by 'docker ps' filtered to these ids:
    echo.
    for %%i in (!CONTAINER_IDS!) do (
        docker ps --filter "id=%%i" --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}"
    )
    echo.
    echo To prevent problems, please stop and remove these containers
    echo by running: 'docker rm -f !CONTAINER_IDS!'
    exit /b -1
)

REM Pull the latest images
docker-compose -f build-resources/docker-compose.yml pull

REM Attempt to bring up the services
docker-compose -f build-resources/docker-compose.yml --project-name beef-compose up -d --remove-orphans 2>&1
