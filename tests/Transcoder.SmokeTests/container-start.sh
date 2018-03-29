#! /bin/bash
bash tests/Transcoder.SmokeTests/wait-for-it.sh -t 9 http://gcf-local/functionstest/us-central1/trackGET
dotnet test tests/Transcoder.SmokeTests/Transcoder.SmokeTests.csproj --no-build
