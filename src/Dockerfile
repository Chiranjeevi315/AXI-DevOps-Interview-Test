# Use the official .NET Core SDK image for the base runtime
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

# Use the official .NET Core SDK image for the build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["SuperService.csproj", "."]
RUN dotnet restore "./SuperService.csproj"
COPY . .
RUN dotnet build "SuperService.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "SuperService.csproj" -c Release -o /app/publish

# Final stage/image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SuperService.dll"]
