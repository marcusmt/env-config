function awsauth
    set -l profile $argv[1]
    set -l token_code $argv[2]
    set -l arn $argv[3]

    # Get the session token using the provided profile and token code
    echo "Getting session token for profile '$profile'..."
    set -l output (aws --profile $profile sts get-session-token --serial-number $arn --token-code $token_code)

    # Extract the credentials from the JSON output
    set -l access_key_id (echo $output | jq -r '.Credentials.AccessKeyId')
    set -l secret_access_key (echo $output | jq -r '.Credentials.SecretAccessKey')
    set -l session_token (echo $output | jq -r '.Credentials.SessionToken')

    # Export the credentials as environment variables
    echo "Setting AWS credentials..."
    set -gx AWS_ACCESS_KEY_ID "$access_key_id"
    set -gx AWS_SECRET_ACCESS_KEY "$secret_access_key"
    set -gx AWS_SESSION_TOKEN "$session_token"

    echo "AWS authentication successful."
end
