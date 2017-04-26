use strict;
use warnings;
package RT::Extension::RichText::Images;

require RT::RichTextUpload;
require RT::RichTextUploads;

RT->AddStyleSheets('ckeditor-notifications.css');

# this component is read-only, and browser doesn't always send Referer for it
$RT::Interface::Web::IS_WHITELISTED_COMPONENT{'/Helpers/Upload/Render'} = 1;

if (!RT->Config->Get('ShowRemoteImages')) {
    RT->Logger->error('RT::Extension::RichText::Images requires ShowRemoteImages. Please include `Set($ShowRemoteImages, 1);` in your RT_SiteConfig.pm');
}

our $VERSION = '0.01';

=head1 NAME

RT-Extension-RichText-Images - add image drag & drop to rich-text editor

=head1 INSTALLATION

=over

=item C<perl Makefile.PL>

=item C<make>

=item C<make install>

May need root permissions

=item C<make initdb>

Only run this the first time you install this module.

If you run this twice, you may end up with duplicate data
in your database.

If you are upgrading this module, check for upgrading instructions
in case changes need to be made to your database.

=item Edit your F</opt/rt4/etc/RT_SiteConfig.pm>

Add this line:

    Plugin('RT::Extension::RichText::Images');

Please also add this line to enable image display, otherwise the extension
won't work:

    Set($ShowRemoteImages, 1);

=item Clear your mason cache

    rm -rf /opt/rt4/var/mason_data/obj

=item Restart your webserver

=back

=head1 AUTHOR

Best Practical Solutions, LLC E<lt>modules@bestpractical.comE<gt>

=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2016 by Best Practical Solutions, LLC 

This is free software, licensed under:

  The GNU General Public License, Version 2, June 1991

=cut

1;
