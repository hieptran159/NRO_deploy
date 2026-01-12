FROM mcr.microsoft.com/dotnet/sdk:5.0
WORKDIR /app

COPY src/SERVER ./
RUN dotnet build -c Debug
RUN cp config.json bin/Debug/net5.0/

# Copy RES folder to the build output directory
RUN cp -r RES bin/Debug/net5.0/

EXPOSE 14445
CMD ["sh", "-c", "sleep 10 && dotnet bin/Debug/net5.0/NRO_Server.dll"]