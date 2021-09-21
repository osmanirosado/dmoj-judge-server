#!/usr/bin/perl -w

use strict;
use warnings;
use v5.10;

my $aliases_file = 'bash_aliases';

system("bash", "tag-image-to-use.sh") or die('[error] Image tagging failed');

open(ALIASES, '<', $aliases_file);
while (<ALIASES>) {
    # https://regex101.com/r/OwTi7g/2
    if (/^\s*alias\s+(.+)=(?<quotation_mark>['"])(.+)(?P=quotation_mark)/) {
        my $alias = $1;
        my $command = $3;
        my @command = split /\s+/, $command;

        say("[info] Recreating a judge using the alias: '$alias' ...");
        system(@command, 'up', '--detach', '--force-recreate', '--no-build') == 0
            or die('[error] Non zero exit code');

        say("[info] Waiting for judge connection ...");
        open(LOG, "$command logs -f |")
            or die('[error] Fail executing the command and opening the pipe');

        my $state = 0;
        my $lines_read = 0;
        my $lines_limit = 100;
        while (<LOG>) {
            print();
            if ($state == 0 and m/Self-testing executors/) {
                $state = 1
            }
            # https://regex101.com/r/k6xvjM/1
            elsif ($state == 1 and m/Self-testing .+: (.+) \[.+,.+\] .+/x) {
                if (! $1 =~ /Success/) {
                    close(LOG);
                    say('[error] Tests failed for a language runtime');
                    last;
                }
            }
            elsif ($state == 1 and m/Running live judge/) {
                $state = 2;
            }
            # https://regex101.com/r/GGA92E/1
            elsif ($state == 2 and m/INFO .+ Preparing to connect to .+ as:/) {
                $state = 3;
            }
            # https://regex101.com/r/YHtq5p/1
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
