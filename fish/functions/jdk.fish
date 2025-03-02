function jdk
    set -l jdk_version $argv[1]
    set -l install_dir "/opt/jdk$jdk_version"
    set -l jdk_bin "$install_dir/bin"

    # Remove previous JDK versions from PATH (if they exist)
    set -gx PATH (string replace -a -- "/opt/jdk[0-9]+/bin" "" "$PATH")

    # Add the new JDK to PATH and JAVA_HOME
    set -gx JAVA_HOME "$install_dir"
    set -gx PATH "$jdk_bin:$PATH"

    echo "JAVA_HOME set to: $JAVA_HOME"
    echo "PATH updated to include: $jdk_bin"

    # Verify the JDK installation
    java -version
    javac -version
end
