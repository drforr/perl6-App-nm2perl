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

App::nm2perl6 - blah blah blah

=head1 SYNOPSIS

=begin code :lang<perl6>

use App::nm2perl6;

=end code

=head1 DESCRIPTION

App::nm2perl6 is ...

=head1 AUTHOR

Jeffrey Goff <drforr@pobox.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 Jeffrey Goff

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
