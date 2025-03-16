#!/usr/bin/fish

# Function to get all projects
function get_projects
    gcloud projects list --format="value(projectId)"
end

# Function to check if GKE is enabled in a project
function is_gke_enabled
    set project_id $argv[1]
    gcloud services list --project="$project_id" --enabled --format="value(config.name)" | grep -q "container.googleapis.com"
    # Exit status 0 if enabled, 1 if not enabled
    return $status
end

# Function to get all GKE clusters in a project
function get_gke_clusters
    set project_id $argv[1]
    gcloud container clusters list --project="$project_id" --format='value[separator=","](name,location)'
end

# Function to create kubectl context for a GKE cluster
function create_kubectl_context
    set project_id $argv[1]
    set cluster_name $argv[2]
    set cluster_location $argv[3]

    gcloud container clusters get-credentials "$cluster_name" \
        --zone="$cluster_location" \
        --project="$project_id"
end

# Main script
function getallgke
    set projects (get_projects)

    if test -z "$projects"
        echo "No GCP projects found."
        return 0
    end

    for project_id in $projects
        echo "Processing project: $project_id"

        # Check if GKE is enabled
        if is_gke_enabled "$project_id"
            echo "  GKE is enabled for project: $project_id"

            set clusters (get_gke_clusters "$project_id")

            if test -z "$clusters"
                echo "  No GKE clusters found in project $project_id."
                continue
            end

            for cluster in $clusters
                set parts (string split --max=2 "," "$cluster")
                set cluster_name $parts[1]
                set cluster_location $parts[2]
                echo "  Processing GKE cluster: $cluster_name in $cluster_location"
                create_kubectl_context "$project_id" "$cluster_name" "$cluster_location"
            end
        else
            echo "  GKE is not enabled for project: $project_id. Skipping."
        end
    end
end
