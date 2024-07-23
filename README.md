# wp-maker
I made this little application so I no longer need to decide on what wallpaper I have.
**Disclaimer**: if you don't use hyprland don't worry about get-wall, new-wall, or lockscreen-wp

## Dependancies
[imagemagick](https://imagemagick.org/script/download.php)

if you are on windows download the binary [here](https://imagemagick.org/script/download.php#windows), put the exe in the windows/binaries folder in the repo then rename the exe to magick.exe. If you downloaded imagemagick via chocolatey or winget just change the `$magick_command = "binaries/magick.exe"` to `$magick_command = "magick"` on line 7 of ani-wall.ps1

## CREDITS
The images are from [0x40 Default Hues](https://github.com/mon/0x40-web)

## Breakdown of everything
**ani-wall**: Makes the wallpaper and saves it as result.png
**get-wall** *(linux only)*: Generates 2 wallpapers and tries to set them as wallpaper via hyprpaper. You can use `--lockscreen` to try to set the images as your lockscreen via hyprlock.
**new-wall** *(linux only)*: Launches ani-wall without the lockscreen parameter.
**lockscreen-wp** *(linux only)*: Launches ani-wall with the lockscreen parameter.
# Images Preview
![image info](./readme-assets/12.png)
![image info](./readme-assets/7.png)
![image info](./readme-assets/10.png)
