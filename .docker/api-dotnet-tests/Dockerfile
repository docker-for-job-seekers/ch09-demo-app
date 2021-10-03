FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["./api-dotnet/api-dotnet.csproj", "./api-dotnet/"]
COPY ["./api-dotnet-tests/api-dotnet-tests.csproj", "./api-dotnet-tests/"]
RUN dotnet restore api-dotnet-tests
COPY ["./api-dotnet", "./api-dotnet"]
COPY ["./api-dotnet-tests", "./api-dotnet-tests"]
CMD dotnet test ./api-dotnet-tests