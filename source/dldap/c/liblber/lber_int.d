/**
	Exposes the C library stuff.

	Only meant to be used internally.
 */
module dldap.c.liblber.lber_int;

import dldap.c.lber_types;
import dldap.c.lber_types;

nothrow:
extern(C):

struct lber_options
{
	short lbo_valid;
	ushort lbo_options;
	int lbo_debug;
};

struct berelement 
{
	lber_options ber_opts;

	alias ber_valid = ber_opts.lbo_valid;
	alias ber_options = ber_opts.lbo_options;
	alias ber_debug = ber_opts.lbo_debug;

	/*
	 * The members below, when not NULL/LBER_DEFAULT/etc, are:
	 *   ber_buf       Data buffer.  Other pointers normally point into it.
	 *   ber_rwptr     Read/write cursor for Sockbuf I/O.
	 *   ber_memctx    Context passed to ber_memalloc() & co.
	 * When decoding data (reading it from the BerElement):
	 *   ber_end       End of BER data.
	 *   ber_ptr       Read cursor, except for 1st octet of tags.
	 *   ber_tag       1st octet of next tag, saved from *ber_ptr when
	 *                 ber_ptr may be pointing at a tag and is >ber_buf.
	 *                 The octet *ber_ptr itself may get overwritten with
	 *                 a \0, to terminate the preceding element.
	 * When encoding data (writing it to the BerElement):
	 *   ber_end       End of allocated buffer - 1 (allowing a final \0).
	 *   ber_ptr       Last complete BER element (normally write cursor).
	 *   ber_sos_ptr   NULL or write cursor for incomplete sequence or set.
	 *   ber_sos_inner offset(seq/set length octets) if ber_sos_ptr!=NULL.
	 *   ber_tag       Default tag for next ber_printf() element.
	 *   ber_usertag   Boolean set by ber_printf "!" if it sets ber_tag.
	 *   ber_len       Reused for ber_sos_inner.
	 * When output to a Sockbuf:
	 *   ber_ptr       End of encoded data to write.
	 * When input from a Sockbuf:
	 *   See ber_get_next().
	 */

	/* Do not change the order of these 3 fields! see ber_get_next */
	ber_tag_t	ber_tag;
	ber_len_t	ber_len;
	ber_tag_t	ber_usertag;

	char* ber_buf;
	char* ber_ptr;
	char* ber_end;

	char* ber_sos_ptr;
	alias er_sos_inner = ber_len; /* reused for binary compat */

	char* ber_rwptr;
	void* ber_memctx;
};
	
