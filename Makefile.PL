use strict;
use warnings;

use inc::Module::Install;

my $dist = 'RDF-vCard';
my $fn   = "lib/$dist.pm"; $fn =~ s#-#/#g;

name                $dist;
perl_version_from   $fn;
version_from        $fn;
abstract_from       $fn;
readme_from         $fn;
author              'Toby Inkster <tobyink@cpan.org>';
license             'perl';

requires            'common::sense'       => 0;
requires            'Encode'              => 0;
recommends          'XML::LibXML'         => '1.60';
requires            'MIME::Base64'        => 0;
requires            'namespace::clean'    => 0;
requires            'RDF::Trine'          => '0.130';
requires            'RDF::TrineShortcuts' => '0.100';
requires            'Scalar::Util'        => 0;
test_requires       'Test::More'          => '0.61';
requires            'Text::vFile::asData' => '0.07';
requires            'URI'                 => 0;

resources(
	'homepage'   => "http://search.cpan.org/dist/$dist/",
	'repository' => "http://goddamn.co.uk/viewvc/perlmods/$dist/",
	'bugtracker' => "http://rt.cpan.org/Dist/Display.html?Queue=$dist",
	);

keywords(qw(RDF Semantic Web SemWeb vCard Directory Contacts hCard XML));

install_script 'vcard2rdf';
install_script 'vcard2xml';

write_doap_changes;
write_doap_changes_xml;

auto_install;
WriteAll(
	'meta' => 1,
	'sign' => 1,
	);
