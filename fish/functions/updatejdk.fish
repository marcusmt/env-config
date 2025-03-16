function update_temurin_jdk
    set -l jdk_version $argv[1] # Get JDK version from argument
    set -l download_path "$HOME/Downloads/TemurinJDK$jdk_version.tar.gz"
    set -l install_dir "/opt/jdk$jdk_version"

    echo "Checking for latest Temurin JDK $jdk_version..."

    # Download the JDK
    echo "Downloading Temurin JDK $jdk_version to $download_path..."
    curl -s "https://api.adoptium.net/v3/assets/latest/$jdk_version/hotspot?os=linux&architecture=x64" | jq '.[] | select(.binary.image_type == "jdk") | .binary.package.link' | xargs curl -Lo "$download_path"

    if test $status -ne 0
        echo "Error: Failed to download Temurin JDK $jdk_version."
        return 1
    end

    # Check if the downloaded file exists
    if not test -f "$download_path"
        echo "Error: Downloaded file not found: $download_path"
        return 1
    end

    # Remove old version if any
    echo "Removing old JDK $jdk_version installation (if any)..."
    sudo rm -rf "$install_dir"

    # Extract the JDK
    echo "Extracting Temurin JDK $jdk_version to $install_dir..."
    sudo mkdir -p "$install_dir" # Create the install directory if it doesn't exist
    sudo tar -xzf "$download_path" --strip-components=1 -C "$install_dir"

    if test $status -ne 0
        echo "Error: Failed to extract Temurin JDK $jdk_version."
        sudo rm -rf "$install_dir"
        return 1
    end

    echo "Temurin JDK $jdk_version updated successfully to $install_dir."
    return 0
end

function updatejdk
    # List of JDK versions to update
    set -l jdk_versions 8 11 17 21 23

    # Update each JDK version
    for jdk_version in $jdk_versions
        update_temurin_jdk $jdk_version
    end

    echo "All specified Temurin JDK versions processed."
end
