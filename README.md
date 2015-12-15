# **d-libldap** (alternatively, ldldapl - **L**ightweight **D** **LDAP** **L**ibrary)

## Requirements
 - libldap ([OpenLDAP's](http://www.openldap.org/devel/gitweb.cgi?p=openldap.git;a=summary))
 - standard D tools (dub, dmd, whatever, ...)

## Building
As with every other dub project out there, just run `dub` inside the project's directory. If you're using an IDE, you're on your own.

Will later be turned into a library project. Just a program while initial development is still ongoing.

## Current features
 - A simple wrapper around the ldap struct
   - connect
   - bind
   - search
 - That's it, really. For now.
 
## Documentation
Documentation will be written inside the source itself somewhere in the future. For now, the goal is to get the basics working.
