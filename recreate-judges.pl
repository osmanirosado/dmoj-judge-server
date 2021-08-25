#!/usr/bin/perl -w

use strict;
use warnings;
use v5.10;

my $aliases_file = 'bash_aliases';

open(ALIASES, '<', $aliases_file);
while (<ALIASES>) {
    if (/^\s*alias\s+(.+)=['"](.+)['"]/) {
        my $alias = $1;
        my $command = $2;
        my @command = split /\s+/, $command;

        say("[info] Recreating a judge using the alias: '$alias' ...");
        system(@command, 'up', '--detach', '--force-recreate', '--no-build') == 0
            or die('[error] Non zero exit code');

        say("[info] Waiting for judge connection ...");
        open(LOG, "$command logs -f |")
            or die('[error] Fail executing the command and opening the pipe');

        my $state = 1;
        my $lines_read = 0;
        my $lines_limit = 100;
        while (<LOG>) {
            print();
            if ($state == 1 and m/Running live judge/) {
                $state = 2;
            }
            elsif ($state == 2 and m/INFO .+ Preparing to connect to .+ as:/) {
                $state = 3;
            }
            elsif ($state == 3 and m/INFO .+ Judge ".+" online/) {
                $state = 4;
                close(LOG);
                say('[info] Judge connection success');
                last;
            }
            elsif ($state > 1 and m/ERROR/) {
                close(LOG);
                say('[error] Judge connection failed');
                last;
            }

            if (++$lines_read == $lines_limit) {
                say("[error] The pattern was not found in the first $lines_limit lines");
                last;
            }
        }

        if ($state != 4) {
            say("[warn] Stop recreating the judges");
            last;
        }
    }
}
