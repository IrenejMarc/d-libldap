/**
	Exposes the C library stuff.

	Only meant to be used internally.
 */
module ldap.clib;


extern(C)
{
	struct ldap_common;
	struct ldap;
	extern(C) int ldap_bind(ldap *ld, const char* dn, const char* passwd, int authmethod);
	extern(C) int ldap_simple_bind_s(ldap* ld, const char* who, const char* passwd);
	extern(C) ldap* ldap_init (const char* host, int port);
}

 /*
 struct ldap {
 	// thread shared
 	ldap_common	*ldc;

 	// thread specific
 	int		ld_errno;
 	char	*ld_error;
 	char	*ld_matched;
 	char	**ld_referrals;
 };
 */
