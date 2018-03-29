FROM microsoft/aspnetcore-build:2.0
WORKDIR /source

RUN apt-get update && apt-get install -y bash

COPY tests/Transcoder.SmokeTests/Transcoder.SmokeTests.csproj ./tests/Transcoder.SmokeTests/
RUN dotnet restore tests/Transcoder.SmokeTests/Transcoder.SmokeTests.csproj

COPY ./tests/Transcoder.SmokeTests ./tests/Transcoder.SmokeTests

RUN dotnet build tests/Transcoder.SmokeTests/Transcoder.SmokeTests.csproj

RUN chmod +x tests/Transcoder.SmokeTests/wait-for-it.sh

ENTRYPOINT [ "bash", "tests/Transcoder.SmokeTests/container-start.sh" ]
