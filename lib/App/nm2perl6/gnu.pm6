use v6.c;
use App::nm2perl6;
unit class App::nm2perl6::gnu is App::nm2perl6;

# There are a bunch of types that aren't yet mapped.
#
my %argument-type =
#	Pc => 'Str',
	b  => 'Bool',
	v  => 'NativeCall::Types::void',
	l  => 'long',
	m  => 'NativeCall::Types::ulong',

	h  => 'uint8',
	t  => 'uint16',
	j  => 'uint32',
	y  => 'ulonglong',

	c  => 'int8',
	s  => 'int16',
	i  => 'int32',
	x  => 'longlong',

	f  => 'num32',
	d  => 'num64',

	a  => 'int8' # Signed char
;

my %unknown-argument-type =
	# Below are some more types that may be encountered, but
	# have no reasonable perl6 equivalents
	#
	# I'm adding '# XXX' so they'll be noted but break compile
	#
	w  => 'wchar_t # XXX',
	n  => '__int128 # XXX',
	o  => 'unsigned __int128 # XXX',
	e  => 'long double, __float80 # XXX',
	g  => '__float128 # XXX',
	z  => 'ellipsis # XXX',
	Dd => 'IEEE 754r decimal floating point (64 bits) # XXX',
	De => 'IEEE 754r decimal floating point (128 bits) # XXX',
	Df => 'IEEE 754r decimal floating point (32 bits) # XXX',
	Dh => 'IEEE 754r half-precision floating point (16 bits) # XXX',
	#DF <number> _ # ISO/IEC TS 18661 binary floating point type _FloatN (N bits)
	Di => 'char32_t # XXX',
	Ds => 'char16_t # XXX',
	Da => 'auto # XXX',
	Dc => 'decltype(auto) # XXX',
	Dn => 'std::nullptr_t (i.e., decltype(nullptr)) # XXX',
;

my regex pascalish-string {
	:my $x = 0;
	( \d+ ) { $x = +$0 }
	( . ** {$x} )
};

method cpp-parameter( Str $str is rw --> Str ) {
	my Bool $R = ?( $str ~~ s{ ^ R } = '' );
	my Bool $P = ?( $str ~~ s{ ^ P } = '' );
	my Bool $K = ?( $str ~~ s{ ^ K } = '' );

	if $str ~~ s{ ^ ( D <[ d e f h i s a c n ]> ) } = '' {
		self.verbose( "Unknown parameter '$0'" );
		return;
	}

	my $modifier = '';
	$modifier ~= '#`{ const } '     if $K and ( $R || $P ); # Not sure about ||
	$modifier ~= '#`{ Reference } ' if $R;

	if $str ~~ s{ ^ <pascalish-string> } = '' {
		return $modifier ~ $1;
	}

	my $letter = $str ~~ s{ ^ ( . ) } = '';
	my $type;

unless %argument-type{~$letter} {
	self.verbose( "Unknown parameter '$letter'" );
	return;
}

	$type ~= '#`{ const } '     if $K;
	$type ~= '#`{ Reference } ' if $R;

	if $P {
		if $letter eq 'c' {
			$type ~= 'Str';
		}
		elsif $letter eq 'v' {
			$type ~= 'Pointer';
		}
		else {
			$type ~= 'Pointer[ ' ~ %argument-type{~$letter} ~ ' ]';
		}
	}
	else {
		$type ~= %argument-type{~$letter};
	}
	$type;
}

method add-symbol( Str $str ) {
	my Bool $is-class;
	my Bool $is-const;
	my Str  @names;
	my Str  @arguments;

	my $scratch = $str;

	# Remove _Z
	#
	$scratch ~~ s{ ^ _Z } = '';

if $scratch ~~ m{ ^ d } {
	self.verbose( "Unknown 'd' prefix" );
	return;
}

	$is-class = True if $scratch ~~ s{ ^ N } = '';
	$is-const = True if $scratch ~~ s{ ^ K } = '';

	while $scratch ~~ s{ ^ :my $x = 0;
			       ( \d+ ) { $x = +$0 }
			       ( . ** {$x} ) } = '' {
		@names.append: ~$1;
	}

	# C2, D0, D1, D2 as well
	#
	@names.append: 'new' if $scratch ~~ s{ ^ C1 } = '';
	$scratch ~~ s{ ^ E } = '' if $is-class;

	# self.cpp-parameter modifies $scratch.
	#
	while $scratch {
		my $new-argument = self.cpp-parameter( $scratch );
		return unless $new-argument;
		next if $new-argument eq 'NativeCall::Types::void';
		@arguments.append: $new-argument;
	}

return unless @names;

my $namespace   = @names[0..*-2].join( '::' );
my $method-name = @names[*-1];

	%.classes{$namespace}<methods>{$method-name}.push: @arguments;
	%.classes{$namespace}<is-class> = True if $is-class;
}

# Value Type name
#
# A absolute
# B
# b BSS section
# D
# D Data section
# G
# g Data section for small objects
# i Indirect
# I Indirect ref to symbol
# N Debugging
# p Stack unwind
# R
# R read-only data
# S
# s Small objects
# T
# t text section
# U undefined
# u unique global symbol
# V
# v Weak object
# W
# w Weak symbol
# - stabs output
# ? Unknown or output-specific
#

# Spec seems to be at:
#
# https://itanium-cxx-abi.github.io/cxx-abi/abi.html#mangling
#
my %builtin-types =
	v	=> 'void',
	w	=> 'wchar_t',
	b	=> 'bool',
	c	=> 'char',
	a	=> 'signed char',
	h	=> 'unsigned char',
	s	=> 'short',
	t	=> 'unsigned short',
	i	=> 'int',
	j	=> 'unsigned int',
	l	=> 'long',
	m	=> 'unsigned long',
	x	=> 'long long, __int64',
	y	=> 'unsigned long long, __int64',
	n	=> '__int128',
	o	=> 'unsigned __int128',
	f	=> 'float',
	d	=> 'double',
	e	=> 'long double, __float80',
	g	=> '__float128',
	z	=> 'ellipsis',
#	Dd # IEEE 754r decimal floating point (64 bits)
#	De # IEEE 754r decimal floating point (128 bits)
#	Df # IEEE 754r decimal floating point (32 bits)
#	Dh # IEEE 754r half-precision floating point (16 bits)
#	DF <number> _ # ISO/IEC TS 18661 binary floating point type _FloatN (N bits)
	Di	=> 'char32_t',
	Ds	=> 'char16_t',
	Da	=> 'auto',
	Dc	=> 'decltype(auto)',
	Dn	=> 'std::nullptr_t (i.e., decltype(nullptr))',
#	u <source-name>	# vendor extended type
;

=begin pod

=head1 NAME

App::nm2perl6::gnu - Unmangle GCC/G++ C++ symbols to valid Perl 6

=head1 SYNOPSIS

=begin code :lang<perl6>

$ nm /path/to/libgecode.so | nm2perl6 > libgecode.pm6

=end code

=head1 DESCRIPTION

Pipe the output from nm(1) into the nm2perl6 binary (or use the filename) and it will generate a set of Perl 6 classes and methods in the (mangled) symbol table. This is useful if you don't have headers for the library, or if you simplly don't want to waste the time trying to untangle the definitions.

It can't distinguish between arrays and pointers because the C++ syntax is the same for both, so it (probably wrongly) defaults to 'Pointer[ type ]' for 'int32 *' and so on. C++ symbols don't come with usage or variables, so none are provided in the output.

It does unpack the basic C<Bool>, C<Str>, C<long> types as well, but maybe not as consistently as you'd like. See the next section for some possible quirks. Also, the C++ unmangler only covers a limited range of types, so it's possible that this module will come up with type signatures that NativeCall can't understand (yet.)

=head2 GNU quirks

I have to choose between 'CArray' and 'Pointer', I'll just use 'Pointer' for now.

'Pv' is just 'Pointer' type, as it's 'void*' in C.
'Pc' is just 'Str' type
'v' is ... not there.

=head1 AUTHOR

Jeffrey Goff <drforr@pobox.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 Jeffrey Goff

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
