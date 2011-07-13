#line 1
package Module::Install::DOAPChangeSets;

use 5.008;
use base qw(Module::Install::Base);
use strict;

our $VERSION = '0.102';

sub write_doap_changes {
	my $self = shift;
	$self->admin->write_doap_changes(@_) if $self->is_admin;
}

sub write_doap_changes_xml {
	my $self = shift;
	$self->admin->write_doap_changes_xml(@_) if $self->is_admin;
}

1;

__END__
#line 76
