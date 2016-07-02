/**
	Exposes include/ldap.h

	Only meant to be used internally.
 */
module dldap.c.ldap_h;

import dldap.c.ldap_int;
import dldap.c.liblber.lber_int;

nothrow:
extern(C):


// Init
ldap* ldap_init (const char* host, int port);
int ldap_initialize (ldap** ldp, const char* uri);

// Bind -- deprecated. TODO: ldap_sasl_bind(_s)
int ldap_bind(ldap *ld, const char* dn, const char* passwd, int authmethod);
int ldap_simple_bind_s(ldap* ld, const char* who, const char* passwd);

// Unbind 
int ldap_unbind_s(ldap* ld);
int ldap_unbind(ldap* ld);

// Search
int ldap_search_s(
		ldap *ld, 
		const char *base, 
		int scope_, 
		const char *filter,
		char **attrs, 
		int attrsonly,
		ldapmsg **res);

char* ldap_err2string(int err);

// Message
int ldap_msgfree(ldapmsg* msg);
char *ldap_get_dn(ldap *ld, ldapmsg *entry);
ldapmsg* ldap_first_message(ldap* ld, ldapmsg* result);
ldapmsg* ldap_next_message(ldap* ld, ldapmsg* message);

// Attributes
char* ldap_first_attribute(ldap* ld, ldapmsg* entry, berelement** berptr);
char* ldap_next_attribute(ldap* ld, ldapmsg* entry, berelement* ber);

// Attribute values
char** ldap_get_values(ldap* ld, ldapmsg* entry, char* attr);
void ldap_value_free(char** vals);

// membfree
void ldap_memfree(void* p);
