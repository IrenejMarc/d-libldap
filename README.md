# **d-libldap** (alternatively, ldldapl - **L**ightweight **D** **LDAP** **L**ibrary)

## Requirements
 - libldap ([OpenLDAP's](http://www.openldap.org/devel/gitweb.cgi?p=openldap.git;a=summary))
 - standard D tools (dub, dmd, whatever, ...)

## Building
As with every other dub project out there, just run `dub` inside the project's directory. If you're using an IDE, you're on your own.

Will later be turned into a library project. Just a program while initial development is still ongoing.

## Current features
 - A simple wrapper around the basic LDAP features
   - connect
   - bind
   - basic search
 - That's it, really. For now.

## Documentation
Documentation will be written inside the source itself somewhere in the future. For now, the goal is to get the basics working.


## Future plans
 - Fix the use of deprecated LDAP functions
 - Add support modifying and adding new records

## Licence
MIT

## Usage example
```d
import std.stdio;
import std.string;

import ldap.d;


void main()
{
	auto ldap = new LDAPConnection("ldap.example.com", 389);
	// simpleBindS will throw if an error occurs
	ldap.simpleBindS("cn=someuser,cn=users,dc=example,dc=com", "SomePassword");

	auto result = ldap.search(
			"cn=users,dc=example,dc=com", // base
			LDAPScope.subtree,
			"(&(objectClass=user)(|(sAMAccountName=foo)(sAMAccountName=bar)))",
			["name", "distinguishedName"]); // attributes to fetch

	foreach(entry; result)
	{
		writefln("Message type: %s", entry.type);
		writefln("DN: %s", entry.dn);
		writefln("Attributes: %s", entry.attributes);
	}

	ldap.unbindS();
}
```
