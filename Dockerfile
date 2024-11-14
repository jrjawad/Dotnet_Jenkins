# Use the .NET SDK 8.0 image to build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Set the entry point for the application
ENTRYPOINT ["dotnet", "DotNet_Jenkins.dll"]
