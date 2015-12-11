import std.stdio;
import std.string;

import ldap.d;


void main()
{
	auto ldap = LDAPConnection("10.0.1.3", 389);
	ldap.simpleBindS("cn=sshkeys,cn=users,dc=nuclei,dc=co", "SSHKeysForMe");
}
