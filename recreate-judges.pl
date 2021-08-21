#!/usr/bin/perl -w

use strict;
use warnings;

my $aliases_file = 'bash_aliases';

open ALIASES, '<', $aliases_file;
while (<ALIASES>) {
    if (/alias\s+(.+)=['"](.+)['"]/) {
        my $alias = $1;
        my @command = split /\s+/, $2;

        #system(@command, 'ps');
        print("[info] Recreating a judge using the alias: '$alias' ...\n");
        system(@command, 'up', '--detach', '--force-recreate', '--no-build') == 0
            or die('[error] Non zero exit code');

        print("[info] Sleeping ...\n");
        sleep 300;
    }
}
