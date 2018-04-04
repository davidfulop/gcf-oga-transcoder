FROM microsoft/aspnetcore-build:2.0
WORKDIR /source

RUN apt-get update && apt-get install -y bash && apt-get install -y apt-transport-https
RUN apt-get install -y ffmpeg

COPY tests/Transcoder.SmokeTests/Transcoder.SmokeTests.csproj ./tests/Transcoder.SmokeTests/
RUN dotnet restore tests/Transcoder.SmokeTests/Transcoder.SmokeTests.csproj

COPY ./tests/Transcoder.SmokeTests ./tests/Transcoder.SmokeTests

RUN dotnet build tests/Transcoder.SmokeTests/Transcoder.SmokeTests.csproj

ENTRYPOINT [ "bash", "tests/Transcoder.SmokeTests/container-start.sh" ]
