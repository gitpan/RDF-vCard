package RDF::vCard::Line;

use 5.008;
use common::sense;

use overload '""' => \&to_string;

our $VERSION = '0.001';

sub new
{
	my ($class, %options) = @_;
	die "Need to provide a property name\n"
		unless defined $options{property};
	$options{value} = [$options{value}]
		unless ref $options{value} eq 'ARRAY';
	delete $options{type_parameters}
		unless $options{type_parameters};
	bless { %options }, $class;
}

sub property
{
	my ($self) = @_;
	return $self->{property};
}

sub value
{
	my ($self) = @_;
	return $self->{value};
}

sub type_parameters
{
	my ($self) = @_;
	return $self->{type_parameters};
}

sub property_order
{
	my ($self) = @_;
	my $p = lc $self->property;
	return 0 if $p eq 'prodid';
	return 1 if $p eq 'source';
	return 2 if $p eq 'kind';
	return 3 if $p eq 'fn';
	return 4 if $p eq 'n';
	return 5 if $p eq 'org';
	return $p;
}

sub to_string
{
	my ($self) = @_;
	
	my $str = uc $self->property;
	if ($self->type_parameters)
	{
		foreach my $parameter (sort keys %{ $self->type_parameters })
		{
			my $values = $self->type_parameters->{$parameter};
			$values = [$values]
				unless ref $values eq 'ARRAY';
			my $values_string = join ",", map { $self->_escape_value($_, comma=>1) } @$values;
			$str .= sprintf(";%s=%s", uc $parameter, $values_string);
		}
	}
	$str .= ":";
	$str .= $self->value_to_string;
	
	if (length $str > 75)
	{
		my $new = '';
		while (length $str > 64)
		{
			$new .= substr($str, 0, 64) . "\r\n ";
			$str  = substr($str, 64);
		}
		$new .= $str;
		$str  = $new;
	}
	
	return $str;
}

sub value_to_string
{
	my ($self) = @_;	
	my $str = join ";", map { $self->_escape_value($_) } @{ $self->value };
	$str =~ s/;+$//;
	return $str;
}

sub _escape_value
{
	my ($self, $value, %options) = @_;
	
	$value =~ s/\r//g;
	$value =~ s/\\/\\\\/g;
	$value =~ s/\n/\\n/g;
	$value =~ s/;/\\;/g;
	$value =~ s/,/\\,/g if $options{comma};
	
	return $value;
}

1;

__END__

=head1 NAME

RDF::vCard::Line - represents a line within a vCard

=head1 DESCRIPTION

Instances of this class correspond to lines within vCards, though
they could potentially be used as basis for other RFC 2425-based formats
such as iCalendar.

=head2 Constructor

=over

=item * C<< new(%options) >>

Returns a new RDF::vCard::Line object.

The only options worth worrying about are: B<property> (case-insensitive
property name), B<value> (arrayref or single string value), B<type_parameters>
(hashref of property-related parameters).

RDF::vCard::Entity overloads stringification, so you can do the following:

  my $line = RDF::vCard::Line->new(
    property        => 'email',
    value           => 'joe@example.net',
    type_parameters => { type=>['PREF','INTERNET'] },
    );
  print "$line\n" if $line =~ /internet/i;

=back

=head2 Methods

=over

=item * C<< to_string() >>

Formats the line according to RFC 2425 and RFC 2426.

=item * C<< value_to_string() >>

Formats just the value according to RFC 2425 and RFC 2426.

=item * C<< property() >>

Returns the entity property - e.g. "EMAIL".

=item * C<< value() >>

Returns an arrayref for the value.

=item * C<< type_parameters() >>

Returns the type_parameters hashref.

=item * C<< property_order() >>

Returns a string which can be used to sort a list of lines into a sensible
order.

=back

=head1 SEE ALSO

L<RDF::vCard::Entity>.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT

Copyright 2011 Toby Inkster

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

