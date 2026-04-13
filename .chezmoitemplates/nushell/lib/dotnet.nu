# Execute a .NET application.
export extern main [
    --help(-h)        # Display help.
    --info            # Display .NET information.
    --list-sdks       # Display the installed SDKs.
    --list-runtimes   # Display the installed runtimes.
    # Usage: dotnet [runtime-options] [path-to-application] [arguments]

    # runtime-options:
    --additionalprobingpath=<path>   # Path containing probing policy and assemblies to probe for.
    --additional-deps=<path>         # Path to additional deps.json file.
    --depsfile: path                       # Path to <application>.deps.json file.
    --fx-version=<version>           # Version of the installed Shared Framework to use to run the application.
    --roll-forward=<setting>         # Roll forward to framework version  (LatestPatch, Minor, LatestMinor, Major, LatestMajor, Disable).
    --runtimeconfig: path                  # Path to <application>.runtimeconfig.json file.

    path_to_application: path       # The path to an application .dll file to execute.
]

#  ######  ########  ##    ##
# ##    ## ##     ## ##   ##
# ##       ##     ## ##  ##
#  ######  ##     ## #####
#       ## ##     ## ##  ##
# ##    ## ##     ## ##   ##
#  ######  ########  ##    ##

# Add a package or reference to a .NET project.
export extern add [
    --help(-?) # Show command line help.

]
export extern add [
    --help(-?) # Show command line help.

]

# Build a .NET project.
export extern build [

]

# Interact with servers started by a build.
export extern build-server [

]

# Clean build outputs of a .NET project.
export extern clean [

]

# Apply style preferences to a project or solution.
export extern format [

]

# Show command line help.
export extern help [

]

# List project references of a .NET project.
export extern list [

]

# Run Microsoft Build Engine (MSBuild) commands.
export extern msbuild [

]

# Create a new .NET project or file.
export extern new [

]

# Provides additional NuGet commands.
export extern nuget [

]

# Create a NuGet package.
export extern pack [

]

# Publish a .NET project for deployment.
export extern publish [

]

# Remove a package or reference from a .NET project.
export extern remove [

]

# Restore dependencies specified in a .NET project.
export extern restore [

]

# Build and run a .NET project output.
export extern run [

]

# Manage .NET SDK installation.
export extern sdk [

]

# Modify Visual Studio solution files.
export extern sln [

]

# Store the specified assemblies in the runtime package store.
export extern store [

]

# Run unit tests using the test runner specified in a .NET project.
export extern test [

]

# Install or manage tools that extend the .NET experience.
export extern tool [

]

# Run Microsoft Test Engine (VSTest) commands.
export extern vstest [

]

# Manage optional workloads.
export extern workload [

]


Additional commands from bundled tools:
  dev-certs         Create and manage development certificates.
  fsi               Start F# Interactive / execute F# scripts.
  user-jwts         Manage JSON Web Tokens in development.
  user-secrets      Manage development user secrets.
  watch             Start a file watcher that runs a command when files change.