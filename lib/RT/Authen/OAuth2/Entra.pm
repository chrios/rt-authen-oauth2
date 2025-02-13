use warnings;
use strict;
package RT::Authen::OAuth2::Entra;

our $VERSION = '0.01';

use Net::OAuth2::Profile::WebServer;
use JSON;

=head1 NAME

RT::Authen::OAuth2::Entra - Handler for Entra OAuth2 logins

=cut

=head2 Example Metadata

=over 4

Entra returns this:

{
    "sub": "qkZXStC1tYk4Q2dJFeIa4vw3b-4sibQA1S6Yhw0vI5M",
    "name": "Megan Bowen",
    "family_name": "Bowen",
    "given_name": "Megan",
    "picture": "https://graph.microsoft.com/v1.0/me/photo/$value",
    "email": "MeganB@M365x214355.onmicrosoft.com"
}

from here: https://graph.microsoft.com/oidc/userinfo

=back

=cut


=head2 Configuring Entra

=over 4

Setup a Entra ID App Registration called RT Authentication. Create a Client ID 
and Secret. Enter your B<Redirect URI> in this form:

    https://www.your-rt-domain.com/NoAuth/OAuthRedirect

The path C</NoAuth/OAuthRedirect> must be exactly as listed here, but you
should change your protocol and domain to match your configuration.

Make a note of the B<Client ID> and B<Client secret>. You will need to put 
these in your F<RT_SiteConfig.pm> - documentation is in the F<etc/OAuth_Config.pm> 
file in this module.

=back

=cut


=head2 C<Metadata()>

=over 4

Takes one scalar string arg, containing the decoded response from the
protected resource server. Returns a hash containing key/value pairs of user
profile metadata items. Entra returns JSON.

=back

=cut


sub Metadata {
    my ($self, $response_content) = @_;
    return (decode_json($response_content));
}

