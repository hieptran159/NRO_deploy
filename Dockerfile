# Build stage
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src

COPY src/SERVER/NRO_Server.csproj ./SERVER/
RUN dotnet restore SERVER/NRO_Server.csproj

COPY src/SERVER ./SERVER
WORKDIR /src/SERVER
RUN dotnet publish -c Release -o /app

# Runtime stage
FROM mcr.microsoft.com/dotnet/runtime:5.0
WORKDIR /app
COPY --from=build /app .

EXPOSE 14445
ENTRYPOINT ["dotnet", "NRO_Server.dll"]
