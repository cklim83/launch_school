Code Challenge: Dynamic Directory Index

In this code challenge, you'll be given a list of requirements. The goal is to create a Sinatra application that satisfies these requirements using what we've covered so far in this course.

Sinatra will, by default, serve any file placed in a public directory that lives in the same directory as the Sinatra application. You can try this out by putting an image or any other file in that directory and then attempting to access it through your application.

Requirements

    1. When a user visits the root path, /, they should be presented with a listing of all of the files in the public directory. The listing for a file should only display the file's name and not the names of any directories.
    2. When a user clicks one of the filenames in the list, they should be taken directly to that file. Take advantage of Sinatra's built-in serving of the public directory.
    3. Create at least 5 files in the public directory to test the listing page.
    4. Add a parameter that controls the sort order of the files on the page. They should be sorted in an ascending (A-Z) order by default, or descending (Z-A) if the parameter has a certain value.
    5. Display a link to reverse the order. The text of the link should reflect the order that will be displayed if it is clicked: "Sort ascending" or "Sort descending".

