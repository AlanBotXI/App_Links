This is a sample on how to make a Firemonkey android app open by an URL,
and to detect and read the full URL at runtime. It also has a button to
share using external app like Whatsapp.

This app will open when you write myappurl.com in your android's browser,
then the URL will be displayed in the memo's main form.
If you search, for example, myappurl.com/app, the memo will print 'myappurl.com/app'.

To change the URL that will open the app, you need to modify the corresponding
intent filter defined in AndroidManifestTemplate.xml