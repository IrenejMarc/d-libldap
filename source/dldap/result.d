module dldap.result;

import dldap.c.ldap_h;
import dldap.c.ldap_int;

import dldap.connection;
import dldap.constants;

struct LDAPMessage
{
	private
	{
		ldapmsg* message;
		LDAPConnection connection;
	}


	package
	{
		this(ldapmsg* msg, LDAPConnection conn)
		{
			message = msg;
			connection = conn;

			type = message.lm_msgtype.to!LDAPResultType;
			dn = connection.getDN(message);
			attributes = connection.getAttributes(msg);
		}
	}

	public
	{
		LDAPResultType type;
		string dn;
		string[string] attributes;

		string opIndex(string attr)
		{
			return attributes[attr];
		}
	}

	~this()
	{
	}
}

struct LDAPResult
{
	private ldapmsg *result;
	private LDAPConnection connection;

	int opApply(int delegate(ref LDAPMessage msg) dg)
	{
		int r = 0;
		for (
				ldapmsg* msg = connection.firstMessage(result);
				msg != null;
				msg = connection.nextMessage(msg))
		{
			auto m = LDAPMessage(msg, connection);

			if (m.type == LDAPResultType.result)
				continue;

			r = dg(m);

			if (r) break;
		}

		return r;
	}

	this(LDAPConnection conn, ldapmsg* res)
	{
		result = res;
		connection = conn;
	}

	~this()
	{
		ldap_msgfree(result);
	}
}
