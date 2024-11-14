# Use the ASP.NET Core runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime

# Set the working directory inside the container
WORKDIR /app

# Copy the compiled application files into the contain

# Set the entry point for the application
ENTRYPOINT ["dotnet", "DotNet_Jenkins.dll"]