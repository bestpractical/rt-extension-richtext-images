use strict;
use warnings;
use 5.10.1;

package RT::RichTextUpload;
use base 'RT::Record';

use Digest::SHA ();

=head1 NAME

RT::RichTextUpload - Represents a single rich-text-editor image upload

=head1 METHODS

=head2 Create PARAMHASH

Create takes a hash of values and creates a row in the database.  Available keys are:

=over 4

=item Filename

=item Digest

=item Headers

=item ContentType

=item ContentEncoding

=item Content

=back

Returns a tuple of (status, msg) on failure and (id, msg) on success.

=cut

sub Create {
    my $self = shift;
    my %args = (
        Filename        => '',
        Digest          => '',
        Headers         => '',
        ContentType     => '',
        ContentEncoding => '',
        Content         => '',
        @_
    );

    if (!$args{Digest}) {
        $args{Digest} = Digest::SHA::sha256_hex($args{Content});
    }

    my ( $id, $msg ) = $self->SUPER::Create(%args);

    unless ($id) {
        return (0, $self->loc("RichTextUpload create failed: [_1]", $msg));
    }

    return ($id, $self->loc('RichTextUpload #[_1] created', $self->id));
}

=head2 DecodedContent

Returns the C<Content> after decoding of the C<ContentEncoding>.

=cut

sub DecodedContent {
    my $self = shift;
    return $self->_DecodeLOB(
        $self->ContentType,
        $self->ContentEncoding,
        $self->Content,
    )
}

=head2 Delete

RichTextUpload records may not be deleted.  Always returns failure.

=cut

sub Delete {
    my $self = shift;
    return (0, $self->loc("RichTextUpload records may not be deleted"));
}

=head2 _Set

RichTextUpload records may not be changed.  Always returns failure.

=cut

sub _Set {
    my $self = shift;
    return (0, $self->loc("RichTextUpload records are immutable"));
}

sub Table { "RTxRichTextUploads" }

sub _CoreAccessible {
    {
        id              => { read => 1, type => 'int(11)',      default => '' },
        Filename        => { read => 1, type => 'varchar(255)', default => '' },
        Digest          => { read => 1, type => 'varchar(255)', default => '' },
        ContentType     => { read => 1, type => 'varchar(80)',  default => '' },
        ContentEncoding => { read => 1, type => 'varchar(80)',  default => '' },
        Headers         => { read => 1, type => 'longtext',     default => '', is_blob => 1 },
        Content         => { read => 1, type => 'longblob',     default => '', is_blob => 1 },
    }
}

RT::Base->_ImportOverlays();

1;

