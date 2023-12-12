#!/bin/bash by haddad 

directory="./images"

if [ -d "$directory" ]; then
    # Initialize the result file

    # Iterate through files in the directory
    for file in "$directory"/*.*; do
        if [ -f "$file" ]; then
            # Perform "cat" operation on the file
            # put the name of the file into var
            filename=$(basename -- "$file")
            steghide extract -sf "images"/"$filename" -xf "$directory"/res/"$filename".steghide.txt -p ""
            lsbsteg decode -i "$file" -o "$directory"/res/"$filename".lsbsteg.txt
            openstego extract -sf "$file" -p "" -xd "$directory"/res/"$filename".openstego.txt
            stegoveritas "$file" -o "$directory"/res/"$filename".stegoveritas.txt
            stegextract "$file" -xf -sf -z -p "" -P "$directory"/res/"$filename".stegextract.txt
            stegpy extract -sf "$file" -p "" -xf "$directory"/res/"$filename".stegpy.txt
            stegseek "$file" "$directory"/res/"$filename".stegseek.txt
            outguess -r "$file" "$directory"/res/"$filename".outguess.txt
            zsteg "$file" > "$directory"/res/"$filename".zsteg.txt
            stegextract "$file" -xf -sf -z -p "" -P "$directory"/res/"$filename".stegextract.txt
            stegopit "$file" "$directory"/res/"$filename".stegopit.txt
            stegolsb "$file" "$directory"/res/"$filename".stegolsb.txt
            stegopvd "$file" "$directory"/res/"$filename".stegopvd.txt
            paddinganograph "$file" "$directory"/res/"$filename".paddinganograph.txt
            png-parser "$file" "$directory"/res/"$filename".png-parser.txt 
        fi
    done
else
    echo "Directory '$directory' not found."
fi
