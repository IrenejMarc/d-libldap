module dldap.connection;

import dldap.constants;
import dldap.exception;
import dldap.result;
import dldap.c.all;
import dldap.c.liblber.lber_int;

import std.string;
import std.conv : to;

import std.stdio;
// TODO: docs

const(char*) cString(inout string str)
{
	return cast(const char*)str.toStringz;
}

char** cString(inout string[] strs, bool nullTerminate = true)
{
	if (strs == null)
		return null;

	char*[] r;

	foreach (s; strs)
		r ~= cast(char*)s.toStringz;	

	if (nullTerminate)
		r ~= null;

	return r.ptr;
}

class LDAPConnection
{
	private
	{
		ldap* ld;
	}

	this(const string host, const ushort port)
	{
		ld = ldap_init(host.cString, port);
	}

	bool simpleBindS(string dn, string pass)
	{
		int status = ldap_simple_bind_s(
				ld, dn.cString, 
				pass.cString);

		if (status != LDAP_SUCCESS)
			return false;

		return true;
	}

	alias bind = simpleBindS;

	void unbindS()
	{
		ldap_unbind_s(ld);
	}

	void unbind()
	{
		ldap_unbind(ld);
	}

	LDAPResult search(
			string base, 
			LDAPScope searchScope, 
			string filter,
			string[] attrs = null, 
			bool attrsonly = false)
	{
		ldapmsg* msgs = new ldapmsg;

		char** cAttrs = attrs.cString;

		int status = ldap_search_s(
				ld, 
				base.cString, 
				searchScope.to!int, 
				filter.cString, 
				cAttrs, 
				attrsonly ? 1 : 0,
				&msgs);

		return LDAPResult(this, msgs);
	}

	// Functions used internally, working with C pointers
	package
	{
		ldapmsg* firstMessage(ldapmsg* res)
		{
			return ldap_first_message(ld, res);
		}

		ldapmsg* nextMessage(ldapmsg* msg)
		{
			return ldap_next_message(ld, msg);
		}

		string getDN(ldapmsg* msg)
		{
			return ldap_get_dn(ld, msg).fromStringz.to!string;
		}

		string[string] getAttributes(ldapmsg* msg)
		{
			berelement* ber;
			string[string] result;

			for (
					auto attr = ldap_first_attribute(ld, msg, &ber);
					attr != null;
					attr = ldap_next_attribute(ld, msg, ber))
			{
				auto vals = ldap_get_values(ld, msg, attr);
				if (vals != null)
				{
					for (int i = 0; vals[i] != null; ++i)
						result[attr.fromStringz.to!string] = vals[i].fromStringz.to!string;

					ldap_value_free(vals);
				}
				ldap_memfree(attr);
			}
			return result;
		}
	}
}
