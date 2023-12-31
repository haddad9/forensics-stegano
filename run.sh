#!/bin/bash

directory="./images"

# Function to handle errors
handle_error() {
    local exit_code=$?
    echo "Error occurred with code $exit_code"
    # Add additional error handling logic here if needed
}

# Set up error handling
trap 'handle_error' ERR

if [ -d "$directory" ]; then
    # Iterate through files in the directory
    for file in "$directory"/*.*; do
        if [ -f "$file" ]; then
            # Perform operations within a try-catch block
            {
                # Perform "cat" operation on the file
                # put the name of the file into var
                filename=$(basename -- "$file")
                cat "$filename"
                # Add your existing code here
                steghide extract -sf "images"/"$filename" -xf "$directory"/res/"$filename".steghide.txt -p ""
                lsbsteg decode -i "$file" -o "$directory"/res/"$filename".lsbsteg.txt
                openstego extract -sf "$file" -p "" -xd "$directory"/res/"$filename".openstego.txt
                stegextract "$file"  -p "" -P "$directory"/res/"$filename".stegextract.txt
                stegpy "$file" gg>> "$directory"/res/"$filename".stegpy.txt
                stegseek "$file" "$directory"/res/"$filename".stegseek.txt
                outguess -r "$file" "$directory"/res/"$filename".outguess.txt
                zsteg "$file" > "$directory"/res/"$filename".zsteg.txt
                stegextract "$file" -xf -sf -z -p "" -P "$directory"/res/"$filename".stegextract.txt
                stegopit "$file" "$directory"/res/"$filename".stegopit.txt
                stegolsb "$file" "$directory"/res/"$filename".stegolsb.txt
                stegopvd "$file" "$directory"/res/"$filename".stegopvd.txt
                paddinganograph "$file" "$directory"/res/"$filename".paddinganograph.txt
                png-parser "$file" "$directory"/res/"$filename".png-parser.txt 
            } || {
                # Error handling block
                echo "Error processing file: $file"
                continue  # Skip to the next iteration
            }
        fi
    done
else
    echo "Directory '$directory' not found."
fi
