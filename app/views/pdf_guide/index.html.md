Use your own PDF
====================

If you obtain a PDF of a housing application, you can use it with
District Housing.  Here are the steps:

1. Use Adobe Acrobat Pro to add fields to the document.  Name these
   fields according to our field name dictionary.
2. Upload the PDF to District Housing from the "Locations" tab.

Field name dictionary
---------------------

Here, we will list some basic fields you can fill in for the main
applicant.

Field value   | What you get
---           | ---
Name          | Full name
FirstName     | First name
MiddleInitial | Middle initial
MiddleName    | Middle name
LastName      | Last name
SSN           | Social security number
DOB           | Date of birth
BirthState    | State of birth
BirthCity     | City of birth
Nationality   | Nationality/citizenship
Gender        |
GenderInitial | First letter of gender
Mail          | Applicant's mailing address (suffixed with Address attributes)
Phone         | Applicant's phone number
HomePhone     | Applicant's home phone number
WorkPhone     | Applicant's work phone number
CellPhone     | Applicant's cell phone number
Email         | Applicant's e-mail address
Address       | Applicant's current residential address
MaritalStatus | Applicant's marital status (Single, Married, Divorced, Widowed)
Occupation    |

Add location metadata
---------------------

You can optionally attach location metadata to your PDF.  If you do
this, you'll be able to see the building it corresponds to on a map.

If you don't do this before uploading the file to District Housing,
you can edit the building location manually from within the Locations
screen.

To add location metadata to your PDF:

1. Open your PDF in Acrobat.
2. Click File menu -> Properties...
3. Click the Custom tab.
4. In the "Name" field, type "Location".
5. In the "Value" field, enter the address of this housing location.
   This should be something that Google Maps could find your building
   with.
6. Click "Add".
7. Click "OK".
8. Save your PDF.

Make fillable PDFs that work well
---------------------------------

There are a few tips you can use to make your new forms nicer.

### Fill the whole space with a single field box

Don't make text fields shorter than they have to be.  Try not to use two
boxes where one will do.  For example, in a field asking for the
applicant's name, use one input field called "Name", not two input
fields called "FirstName" and "LastName".

### Set the font size to 6 points

Small fonts mean more text can fit in the box.

You might be tempted to use the "auto" font size setting, but be warned,
this also makes short text entries very large, and makes the form look
weird.

### Enable the "Multi-line" option

Long fields, like full names and addresses, risk being longer than the
length of the field box.  If "Multi-line" is enabled, then long text will
wrap to a new line, instead of getting chopped.

### Set default properties for new fields

When you set a field to 6 points with multi-line, you should then
right-click it and choose "Use Current Properties as New Defaults".
Labeling PDFs is tedious; this will save you the trouble of setting
those options on every field.
