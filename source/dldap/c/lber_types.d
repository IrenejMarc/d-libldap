/**
	Exposes the C library stuff.

	Only meant to be used internally.
 */
module dldap.c.lber_types;

alias ber_int_t = int;
alias ber_sint_t = int;
alias ber_uint_t = int;
alias ber_tag_t = long;
alias ber_socket_t = int;
alias ber_len_t = long;

nothrow:
extern(C):


