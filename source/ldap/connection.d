module ldap.connection;

import ldap.constants;
import ldap.exception;
import ldap.clib;

import std.string;
import std.conv : to;

// TODO: docs

struct LDAPConnection
{
	private
	{
		ldap.clib.ldap* ld;
	}

	this(const string host, const ushort port)
	{
		ld = ldap_init(host.toStringz, port);
	}

	void simpleBindS(string dn, string pass)
	{
		int status = ldap_simple_bind_s(ld, cast(const char*)dn.toStringz, cast(const char*)pass.toStringz);
		if (status != LDAP_SUCCESS)
			throw new LDAPException("Connection failed, error status: " ~ status.to!string);
	}
}
