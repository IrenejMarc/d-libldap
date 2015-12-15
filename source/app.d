import std.stdio;
import std.string;

import ldap.d;


void main()
{
	auto ldap = new LDAPConnection("10.0.1.3", 389);
	ldap.simpleBindS("cn=someuser,cn=users,dc=example,dc=com", "SomePassword");

	auto r = ldap.search(
			"cn=users,dc=example,dc=com",
			LDAPScope.subtree,
			"(&(objectClass=user)(|(sAMAccountName=foo)(sAMAccountName=bar)))",
			["name"],
			true);
	foreach(m; r)
	{
		writefln("Message type: %s", m.type);
		writefln("DN: %s", m.dn);
		writefln("Attributes: %s", m.attributes);
	}

	ldap.unbindS();
}
