module dldap.constants;
import dldap.c.lber_types;

// #define LDAP_SUCCESS 0x00 // ldap.h:586
const int LDAP_SUCCESS = 0;


/* ldap-int.h: 186
#define LDAP_UNINITIALIZED	0x0
#define LDAP_INITIALIZED	0x1
#define LDAP_VALID_SESSION	0x2
#define LDAP_TRASHED_SESSION	0xFF
*/

const int LDAP_UNINITIALIZED = 0x0;
const int LDAP_UNINITIALISED = LDAP_UNINITIALIZED;
const int LDAP_INITIALIZED = 0x1;
const int LDAP_VALID_SESSION = 0x2;
const int LDAP_TRASHED_SESSION = 0xFF;

// ldap.h:567
enum LDAPScope : ber_int_t
{
	base = 0x000,
	oneLevel = 0x001,
	one = oneLevel,
	subtree = 0x002,
	sub = subtree,
	subordinate = 0x003, // OpenLDAP extension
	default_ = -1 // OpenLDAP extension
};

enum LDAPResultType : ber_tag_t
{
	bind = 0x61U,
	entry = 0x64U,
	reference = 0x73U,
	result = 0x65U,
	modify = 0x67U,
	add = 0x69U,
	delete_ = 0x6bU,
	moddn = 0x6dU,
	modrdn = moddn,
	rename = moddn,
	compare = 0x6fU,
	extended = 0x78U,
	intermediate = 0x79U
}
