# Usage: getFile <img_url>

function getFile () {
echo file://$(pwd)/`wget $1 2>&1 | tail -n 2 | sed "s/.*‘//" | sed "s/’.*//"`

}

#  If you're taking notes (in Vim etc.) while doing TryHackMe walkthroughs and want to add local images to you notes, you can do file://<image_path>
# When you open or view it, you can right click the url and select "open link". It will show you the image.

# or just learn about [hyperlink](<image_path>) (hyperlinks in .md files)

# This script will download the image to you current directroy from the url you gave it and give you in the file:/// format so that you can copy
# and paste it to your notes to view later locally.
