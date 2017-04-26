use strict;
use warnings;

package RT::RichTextUploads;
use base 'RT::SearchBuilder';

=head1 NAME

RT::RichTextUploads - a collection of L<RT::RichTextUpload> objects

=cut

sub Table { "RTxRichTextUploads" }

RT::Base->_ImportOverlays();

1;

