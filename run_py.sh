#!/bin/bash

directory="./images"

if [ -d "$directory" ]; then
    # Initialize the result file

    # Iterate through files in the directory
    for file in "$directory"/*.*; do
        if [ -f "$file" ]; then
            # Perform "cat" operation on the file
            # put the name of the file into var
            filename=$(basename -- "$file")
            steghide extract -sf "images"/"$filename" -xf "$directory"/res/"$filename".txt -p ""
            lsbsteg decode -i "$file" -o "$directory"/res/"$filename"
            openstego extract -sf "$file" -p "" -xd "$directory"/res/"$filename"
            stegoveritas "$file" -o "$directory"/res/"$filename"
            


            temp_file=$(mktemp)
            lsbsteg encode -i "$file" -o "$temp_file"
            # Append filename to the result file
            echo "$filename" >> "$directory"/res/tes.txt

            # Append contents of the file to the result file
            awk '{ gsub(/[^[:print:][:space:]]/, ""); print }' "$file" >> "$directory"/res/tes.txt
        fi
    done
else
    echo "Directory '$directory' not found."
fi
