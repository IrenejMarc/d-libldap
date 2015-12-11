module ldap.exception;

import std.exception;

class LDAPException : Exception
{
	this(string msg)
	{
		super(msg);
	}
}
