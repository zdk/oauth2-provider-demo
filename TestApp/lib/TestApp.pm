package TestApp;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    -Debug
    ConfigLoader
    Static::Simple
    Authentication
    Session
    Session::Store::FastMmap
    Session::State::Cookie
    Session::PerUser
/;

extends 'Catalyst';

our $VERSION = '0.01';
$VERSION = eval $VERSION;

# Configure the application.
#
# Note that settings in testapp.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'TestApp',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
);

__PACKAGE__->config( 'Plugin::Authentication' => {
     default_realm => 'oauth2',
     realms => {
         oauth2 => {
             credential => {
                 class              => 'OAuth2',
                 application_id     => q{36d24a484e8782decbf82a46459220a10518239e},
                 application_secret => q{947da6393f802a7abe4ecf17ff12cc3f10704ee4},
                 callback_uri       => q{http://localhost.client:3333/callback},
                 site               => 'Brukere',
                 authorize_path     => q{/oauth/authorize},
                 authorize_url      => q{http://localhost.provider:3000/oauth/authorize},
                 access_token_path  => q{/oauth/token},
                 access_token_url   => q{http://localhost.provider:3000/oauth/token},
             },
             store => {
                 class => 'Null',
             },
         },
     },
 },
);

# Start the application
__PACKAGE__->setup();




=head1 NAME

TestApp - Catalyst based application

=head1 SYNOPSIS

    script/testapp_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<TestApp::Controller::Root>, L<Catalyst>

=head1 AUTHOR

zdk

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
