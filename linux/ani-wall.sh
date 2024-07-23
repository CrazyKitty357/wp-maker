#!/bin/bash

image_folder="chars"

color_bias="ubiased"

generate_random_color() {
    case "$color_bias" in
        "pastel")
            r=$(printf "%02X\n" $((RANDOM % 128 + 128)))
            g=$(printf "%02X\n" $((RANDOM % 128 + 128)))
            b=$(printf "%02X\n" $((RANDOM % 128 + 128)))
            ;;
        "dark")
            r=$(printf "%02X\n" $((RANDOM % 128)))
            g=$(printf "%02X\n" $((RANDOM % 128)))
            b=$(printf "%02X\n" $((RANDOM % 128)))
            ;;
        "unbiased" | *)
            r=$(printf "%02X\n" $((RANDOM % 256)))
            g=$(printf "%02X\n" $((RANDOM % 256)))
            b=$(printf "%02X\n" $((RANDOM % 256)))
            ;;
    esac
    echo "#$r$g$b"
}


image=$(ls "$image_folder" | shuf -n 1)

random_color=$(generate_random_color)

temp_color_image="temp_color.png"
image_size=$(magick identify -format "%wx%h" "$image_folder/$image")
magick -size "$image_size" "xc:$random_color" "$temp_color_image"

result_image="result.png"
magick "$temp_color_image" "$image_folder/$image" -compose Screen -composite "$result_image"

rm "$temp_color_image"

echo "Blended image saved as $result_image with color $random_color"
export image
export random_color
# kitten icat "$result_image"
