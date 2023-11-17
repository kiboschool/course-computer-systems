#!/bin/bash

# Check if a YAML file is provided
if [ -f "../course.yml" ]; then
    echo "course.yml file does not exist."
    exit 1
fi

yaml_file="./course.yml"
summary_file="./src/SUMMARY.md"

awk '
BEGIN {
    depth = 0; 
    prev_indent = 0;
    name = ""
    path = ""
    was_output = 0
    FS = ""
}

{
    # Skip over comment lines
    if ($0 ~ /^#/) next; 

    # If this is a new list item (starts with hyphen), reset name/path to empty.
    if (match($0, /^[ \t]*-[ \t]*/) != 0) {
        name = ""
        path = ""
        was_output = 0 
    }

    # Remove leading spaces and find the current indentation
    match($0, /^[ \t]*-?[ \t]*/);
    indent = RLENGTH;

    # Determine the depth of the current line in the tree

    if (indent > prev_indent) {
        depth++;
    } else if (indent < prev_indent) {
        depth -= (prev_indent-indent)/4
        
    }
    prev_indent = indent; 

    # Extract the key-value pair.
    key = substr($0, 0, index($0,":")-1)
    sub(/[ \t]*-?[ \t]*/, "", key);
    value = substr($0, index($0,":")+1)
    sub(/[ \t]*/, "", value);

    # Update the current node and parent.
    nodes[depth] = key; 
    parent = (depth > 0) ? nodes[depth-1] : "NONE";

    if (key == "path") {
        path = value
        sub(/src\//, "", path);
    }

    if (key == "name") {
        if (parent == "NONE") {
            printf "# %s\n", value   
        }
        else if (parent == "units") {
            printf "\n---\n"
            printf "\n# %s\n\n", value 
        }
        else if (parent == "activities") {
            name = value
        }
    }

    if (name != "" && path != "" && was_output == 0) {
        printf "- [%s](%s)\n", name, path
        was_output = 1
    }


}

' $yaml_file > $summary_file
