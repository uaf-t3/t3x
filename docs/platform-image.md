<!-- The steps taken to customize the default Raspberry Pi OS for T3 use as a T3X image -->
## Steps Taken to Customize Default RPiOS for T3 use as a T3X Image.

- [ ] Change Wallpaper
  - Go to the start menu and click Preferences>Appearance Settings
  - Click on “Picture” and select your desired wallpaper image
  - You can also mess around with the theme colors as well but that isn't necessary.
  
- [ ] Import Necessary Programs and applications
  - See [sanity.t3x](https://github.com/uaf-t3/t3x/blob/main/scripts/sanity.t3x) for the script that installs the packages.
  - See [packages.txt](https://github.com/uaf-t3/t3x/blob/main/lib/packages.txt) for list of packages that till be downloaded by [sanity.t3x](https://github.com/uaf-t3/t3x/blob/main/scripts/sanity.t3x).

- [ ] Set up Chromium Homepage and Bookmarks
  - The website weve put as the homepage in past images is [t3.alaska.edu](https://t3.alaska.edu/)
  - The Bookmarks get set to The NodeRed Flow Editor, The Node Red Dashboard, and the above listed [t3.alaska.edu](https://t3.alaska.edu/)