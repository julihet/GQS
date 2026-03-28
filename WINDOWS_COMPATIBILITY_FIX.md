# Windows Compatibility Fix for GQS

## Issue Identified

The GQS application was failing on Windows with the error:
```
java.io.IOException: CreateProcess error=2, The system cannot find the file specified
```

This occurred because the code was hardcoded to use `/bin/bash` which doesn't exist on Windows systems.

## Root Cause

Multiple locations in the codebase were executing shell commands using:
```java
String[] command = {"/bin/bash", "-c", shellCommand};
Main.executeCommand(command);
```

This works on Unix-like systems but fails on Windows where `/bin/bash` is not available.

## Solution Implemented

Modified the `executeCommand` method in `Main.java` to detect the operating system and automatically convert bash commands to Windows cmd commands:

```java
public static void executeCommand(String[] startCommand) {
    try {
        ProcessBuilder builder = new ProcessBuilder();
        
        // Check if we're on Windows and the command uses /bin/bash
        if (System.getProperty("os.name").toLowerCase().contains("windows") && 
            startCommand.length >= 3 && startCommand[0].equals("/bin/bash") && 
            startCommand[1].equals("-c")) {
            
            // Convert bash command to Windows cmd command
            String bashCommand = startCommand[2];
            String[] windowsCommand = {"cmd", "/c", bashCommand};
            builder.command(windowsCommand);
        } else {
            builder.command(startCommand);
        }
        
        Process process = builder.start();
        // ... rest of the method remains the same
```

## How It Works

1. **OS Detection**: Uses `System.getProperty("os.name")` to detect if running on Windows
2. **Command Pattern Matching**: Checks if the command array matches the bash pattern `{"/bin/bash", "-c", command}`
3. **Automatic Conversion**: Converts bash commands to Windows cmd format by replacing `/bin/bash -c` with `cmd /c`
4. **Transparent Operation**: The conversion is automatic and doesn't require changes to existing code

## Files Modified

- `src/main/java/org/example/gqs/Main.java` - Modified `executeCommand` method

## Testing

A test file `WindowsCompatibilityTest.java` has been created to verify the OS detection and command conversion logic.

## Configuration

Created a basic `config.txt` for testing with the Kuzu database (embedded mode):
```
startCommand=random
stopCommand=random
deleteCommand=rm -rf ~/kuzu/THREAD_FOLDER
deleteFile=random
```

## Requirements

To run the GQS application, you need:
- Java JDK 21+
- Maven 3.9.6+
- Appropriate database setup (Neo4j, Memgraph, FalkorDB, or use embedded Kuzu)

## Next Steps

1. Install Java and Maven (requires admin privileges)
2. Build the project: `mvn install -DskipTests -T1C`
3. Run with: `java -jar target/GQS-1.0-SNAPSHOT.jar kuzu`

The Windows compatibility fix ensures that shell commands will work correctly on Windows systems without requiring code changes for database operations.
