@rem = ' vim: set filetype=perl: ';
@rem = ' --*-Perl-*-- ';
@rem = '
@echo off
setlocal
set PATH=%~dp0\..\perl\bin;%~dp0\..\bin;%PATH%
perl -w "%~f0" %*
exit /B %ERRORLEVEL%
';
use strict;
use warnings;
use English;
use File::Basename;

use FindBin;
use lib "$FindBin::Bin\\..";
use lib "$FindBin::Bin\\..\\lib";

use SmartCtlRunner;

my $script_name = basename( $PROGRAM_NAME, ".cmd" );

# Run smartctl every 5 seconds forever.
# Idea is to generate a SMART Read Data command.

my $physical_drive = shift;

unless( defined $physical_drive and $physical_drive =~ /\d+/ )
{
    die "Usage: $script_name <physical drive number>\n";
}

my $smart = SmartCtlRunner->new(
    physical_drive => $physical_drive
);

while( 1 )
{
    $smart->collect();
    sleep( 5 );
}
