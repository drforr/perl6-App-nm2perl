use v6.c;
unit class App::nm2perl6:ver<0.0.2>;

has Bool $.is-verbose;

has Str $.output-filename;
has Str $.compiler-name;
has Str $.module-name;

has %.classes;

method verbose( Str $str ) {
	return unless $.is-verbose;
	warn "*** $str";
}

##########################
#
# Conversion to Perl
#

method to-perl6-method( Str $multi, Str $name, @arguments ) {
	my $is-new     = $name eq 'new';
	my $nativeconv = '';
	$nativeconv = "is nativeconv( 'thisgnu' ) " if $is-new;

	"\t{$multi}method {$name}( { join( ", ", @arguments ) } ) {$nativeconv}is native( 'library' ) \{ * \}"
}

method to-perl6-multi-method( Str $name, @info ) {
	my $is-multi = @( @info ).elems > 1;
	my $multi = $is-multi ?? 'multi ' !! '';

	join( "\n",
		map {
			self.to-perl6-method( $multi, $name, @( $_ ) )
		}, @info
	);
}

method to-perl6-class( Str $name, %info ) {
	my $repr   = 'CStruct';
	my $vtable = '';

	if %info<is-class> {
		$repr   = 'CPPStruct';
		$vtable = "\thas Pointer \$.vtable;";
	}

	"class {$name} is repr( '{$repr}' ) \{
{$vtable}
{join( "\n", map {
	self.to-perl6-multi-method( $_, %info.<methods>{$_} )
}, sort keys %info.<methods>
)}
\}\n"
}

method to-perl6 returns Str {
	join( "",
		map {
			self.to-perl6-class( $_, %.classes{$_} )
		}, sort keys %.classes
	)
}

method nm-to-perl6( Str $text ) {
	self.process-lines( $text );

	my $final-text = self.to-perl6;

	if $.output-filename {
		my $fh = $final-text.IO.open( :w );
		say $fh, $final-text;
	}
	else {
		say $final-text;
	}
}

##########################
#
# Reading input

method process-lines( Str $text ) {
	for $text.lines -> $line {
		# Skip line if there's no address.
		next if $line ~~ m{ ^ \s+ };

		my ( $address, $type, $name ) = $line.split( ' ' );

# XXX These probably will move down.
# XXX
		if $name ~~ m{ ^ '_ZTI' | '_ZTS' } {
			self.verbose( "Skipping typeinfo '$name'" );
			next;
		}

		next if $line ~~ m{ ^ '#' };      # XXX Mostly for debugging
		next if $type eq 'U';             # XXX Skip undefined 
		next unless $name ~~ m{ ^ '_Z' }; # XXX Think on this later

		self.add-symbol( $name );
	}
}

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
