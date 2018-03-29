FROM microsoft/aspnetcore-build:2.0 AS builder
WORKDIR /source

COPY tests/Transcoder.TestServer/Transcoder.TestServer.csproj ./tests/Transcoder.TestServer/
RUN dotnet restore tests/Transcoder.TestServer/Transcoder.TestServer.csproj

COPY ./tests/Transcoder.TestServer ./tests/Transcoder.TestServer
RUN dotnet publish --output /app/ --configuration=Debug tests/Transcoder.TestServer/Transcoder.TestServer.csproj

FROM microsoft/aspnetcore:2.0
WORKDIR /app
COPY --from=builder /app .
RUN mkdir assets
COPY tests/Transcoder.TestServer/assets/test01.flac ./assets/test01.flac

ENTRYPOINT ["dotnet", "Transcoder.TestServer.dll"]
