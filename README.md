# Quick-Share
A quick and dirty file upload to the file share service transfer.sh

# Read-Me
This is part of a larger application written for an end of year project for my Linux scripting course. A simple script that uses Curl to upload files to Transfer.sh, with options to randomize the filename.
The last URL upload is preserved under the title name.

# How-To-Use
Running the script shows files only in the PWD. Entering a blank string, or invalid filename presents an error and loops back to the initial screen. 

Once the filename is entered an option to randomize the filename will be presented to the user. Pressing enter defaults to NO, while typing 'y' randomizes the filename and preserves the extention.

Once the upload is complete, script loops back to initial screen and presents the last URL upload under the title.

# To-Do
Add a check to determine if Curl is installed.
