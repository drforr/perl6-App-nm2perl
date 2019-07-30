NAME
====

App::nm2perl6 - Unmangle C++ symbols to valid Perl 6

SYNOPSIS
========

```
$ nm /path/to/libgecode.so | nm2perl6 > libgecode.pm6
```

DESCRIPTION
===========

Given a C++ library, use the output from nm(1) to generate one or more valid Perl 6 NativeCall class definitions using the "mangled" symbol names. This is useful when you don't have headers, or even have the header files but can't figure out how they work.

AUTHOR
======

Jeffrey Goff <drforr@pobox.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2019 Jeffrey Goff

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

