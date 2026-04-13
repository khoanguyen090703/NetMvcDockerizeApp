FROM mcr.microsoft.com/dotnet/sdk:10.0 as build
WORKDIR /source

COPY *.sln .
COPY AppDocker1.csproj .
RUN dotnet restore

COPY . .
WORKDIR /source
RUN dotnet publish -c Release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:10.0 as runtime
WORKDIR /app
COPY --from=build /app ./

ENV ASPNETCORE_URLS=http://+:${PORT:-8080}

ENTRYPOINT [ "dotnet", "AppDocker1.dll" ]
