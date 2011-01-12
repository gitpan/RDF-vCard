package RDF::vCard;

use 5.008;
use common::sense;
use RDF::vCard::Exporter;

our $VERSION = '0.002';

1;

__END__

=head1 NAME

RDF::vCard - convert between RDF and vCard

=head1 SYNOPSIS

 use RDF::vCard;
 
 my $input    = "http://example.com/contact-data.rdf";
 my $exporter = RDF::vCard::Exporter->new;
 
 print $_ foreach $exporter->export_cards($input);

=head1 DESCRIPTION

This module doesn't do anything itself; it just loads RDF::vCard::Exporter for
you.

=head2 RDF::vCard::Exporter

L<RDF::vCard::Exporter> takes some RDF using the W3C's vCard vocabulary,
and outputs L<RDF::vCard::Entity> objects.

=head2 RDF::vCard::Importer

This hasn't been written yet, but is planned.

=head2 RDF::vCard::Entity

An L<RDF::vCard::Entity> objects is an individual vCard. It overloads
stringification, so just treat it like a string.

=head2 RDF::vCard::Line

L<RDF::vCard::Line> is internal fu that you probably don't want to touch.

=head1 BUGS

If your RDF asserts that Alice is Bob's AGENT and Bob is Alice's AGENT, then
L<RDF::vCard::Export> will eat your face. Don't do it.

Please report any other bugs to
L<https://rt.cpan.org/Public/Dist/Display.html?Name=RDF-vCard>.

=head1 SEE ALSO

L<http://www.w3.org/Submission/vcard-rdf/>.

L<http://perlrdf.org/>.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT

Copyright 2011 Toby Inkster

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

