$image_folder = "chars"
$color_bias = "unbiased"

# I recommend downloading the imagemagick binary here
# https://imagemagick.org/script/download.php#windows
# rename the file to magick.exe and put it in the binaries folder
$magick_command = "binaries/magick.exe"

function Generate-RandomColor {
    param (
        [string]$colorBias
    )
    
    switch ($colorBias) {
        "pastel" {
            $r = "{0:X2}" -f (Get-Random -Minimum 128 -Maximum 256)
            $g = "{0:X2}" -f (Get-Random -Minimum 128 -Maximum 256)
            $b = "{0:X2}" -f (Get-Random -Minimum 128 -Maximum 256)
        }
        "dark" {
            $r = "{0:X2}" -f (Get-Random -Minimum 0 -Maximum 128)
            $g = "{0:X2}" -f (Get-Random -Minimum 0 -Maximum 128)
            $b = "{0:X2}" -f (Get-Random -Minimum 0 -Maximum 128)
        }
        "unbiased" {
            $r = "{0:X2}" -f (Get-Random -Minimum 0 -Maximum 256)
            $g = "{0:X2}" -f (Get-Random -Minimum 0 -Maximum 256)
            $b = "{0:X2}" -f (Get-Random -Minimum 0 -Maximum 256)
        }
        default {
            $r = "{0:X2}" -f (Get-Random -Minimum 0 -Maximum 256)
            $g = "{0:X2}" -f (Get-Random -Minimum 0 -Maximum 256)
            $b = "{0:X2}" -f (Get-Random -Minimum 0 -Maximum 256)
        }
    }
    return "#$r$g$b"
}

$image = Get-ChildItem -Path $image_folder | Get-Random

$random_color = Generate-RandomColor -colorBias $color_bias

$temp_color_image = "temp_color.png"
$image_size = Start-Process -FilePath $magick_command identify -format "%wx%h" "$($image_folder + '\' + $image)"
Start-Process -FilePath $magick_command -size $image_size "xc:$random_color" $temp_color_image

$result_image = "result.png"
Start-Process -FilePath $magick_command $temp_color_image "$($image_folder + '\' + $image)" -compose Screen -composite $result_image

Remove-Item $temp_color_image

Write-Host "Blended image saved as $result_image with color $random_color"
$env:image = $image
$env:random_color = $random_color
Write-Host "if you want to generate more images be sure to rename the new file to anything other than result.png"
Pause
