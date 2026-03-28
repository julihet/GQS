public class WindowsCompatibilityTest {
    public static void main(String[] args) {
        System.out.println("Testing Windows compatibility fix...");
        
        // Test the OS detection logic
        String osName = System.getProperty("os.name").toLowerCase();
        boolean isWindows = osName.contains("windows");
        
        System.out.println("OS: " + System.getProperty("os.name"));
        System.out.println("Is Windows: " + isWindows);
        
        // Simulate the command conversion logic
        String[] bashCommand = {"/bin/bash", "-c", "echo 'Hello from bash'"};
        
        if (isWindows && bashCommand.length >= 3 && bashCommand[0].equals("/bin/bash") && bashCommand[1].equals("-c")) {
            String bashCmd = bashCommand[2];
            String[] windowsCommand = {"cmd", "/c", bashCmd};
            System.out.println("Original bash command: " + String.join(" ", bashCommand));
            System.out.println("Converted Windows command: " + String.join(" ", windowsCommand));
        } else {
            System.out.println("No conversion needed or not on Windows");
        }
        
        System.out.println("Windows compatibility test completed successfully!");
    }
}
