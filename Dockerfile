# Use the official .NET runtime image (this is all that's needed for running)
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base

# Set the working directory in the container
WORKDIR /app

# Expose the application port (assuming your app runs on port 80)
EXPOSE 80

# Set the entry point for the application
ENTRYPOINT ["dotnet", "DotNet_Jenkins.dll"]