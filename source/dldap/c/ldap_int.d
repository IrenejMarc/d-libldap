/**
	Exposes the C library stuff.

	Only meant to be used internally.
 */
module dldap.c.ldap_int;

public import dldap.c.ldap_h;

import dldap.c.liblber.lber_int;
import dldap.c.lber_types;
import std.c.time;

nothrow:
extern(C):

// ldap-int.h:390
struct ldap_common;

// ldap-int.h:480
struct ldap;

// ldap-int.h:148
struct ldapmsg {
	ber_int_t lm_msgid;	/* the message id */
	ber_tag_t lm_msgtype;	/* the message type */
	berelement *lm_ber;	/* TODO: the ber encoded message contents */
	ldapmsg *lm_chain;	/* for search - next msg in the resp */
	ldapmsg *lm_chain_tail;
	ldapmsg *lm_next;	/* next response */
	time_t lm_time;	/* used to maintain cache */
};
