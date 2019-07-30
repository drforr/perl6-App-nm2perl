use v6.c;
unit class App::nm2perl6:ver<0.0.1>;

has Bool $.is-verbose;

has Str $.output-filename;
has Str $.compiler-name;
has Str $.output-module-name;

has %.classes;

method verbose( Str $str ) {
	return unless $.is-verbose;
	warn "*** $str";
}

method nm-to-perl6( Str $text ) { ... }

=begin pod

=head1 NAME

App::nm2perl6 - Translate library symbols to valid Perl 6

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
