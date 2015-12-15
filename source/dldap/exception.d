module dldap.exception;

import std.exception;

class LDAPException : Exception
{
	this(string msg)
	{
		super(msg);
	}
}
