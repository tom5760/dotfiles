#!/usr/bin/env python2

import os
import socket
import sys

FILES = [
    ('.Xresources',           ''),
    ('.config/i3/config',     ''),
    ('.config/dunst/dunstrc', ''),
    ('.config/cower/config',  ''),
    ('.config/autorandr',     ''),
    ('.config/fish',          ''),
    ('.gitconfig',            ''),
    ('.hgrc',                 ''),
    ('.latexmkrc',            ''),
    ('.npmrc',                ''),
    ('.screenrc',             ''),
    ('.ssh/config',           ''),
    ('.vim',                  ''),
    ('.vimrc',                ''),
    ('.zsh',                  ''),
    ('.zshenv',               ''),
    ('',                      '.local/share/vim/swap'),
    ('',                      '.local/share/vim/backup'),
    ('',                      '.local/share/vim/undo'),
]

HOSTNAME = socket.gethostname()

if HOSTNAME == 'helium':
    FILES += [
        ('.xinitrc-laptop',         '.xinitrc'),
        ('.config/i3status/config', ''),
    ]
else:
    FILES += [
        ('.xinitrc-desktop',                '.xinitrc'),
        ('.config/i3status/config-desktop', '.config/i3status/config'),
    ]

def main(argv):
    dry_run = False
    force = False

    for flag in argv:
        if flag == '-d':
            dry_run = True
        elif flag == '-f':
            force = True
        elif flag == '-h':
            print 'Flags:'
            print ' -d     Dry Run (just prints what it would do)'
            print ' -f     Force symlink creation even if one exists already'
            print ' -h     Print this help'
            return 0

    for f in FILES:
        source, target = f

        if not target:
            target = source

        target = os.path.expanduser('~/' + target)

        if not source and not os.path.isdir(target):
            print 'Making:', target, '...'
            if not dry_run:
                os.makedirs(target)

        else:
            source = os.path.abspath(source)

            dirname, basename = os.path.split(target)
            if dirname and not os.path.isdir(dirname):
                print 'Making:', dirname
                if not dry_run:
                    os.makedirs(dirname)

            print 'Linking:', source, '->', target, '...',
            if not dry_run:
                if os.path.islink(target):
                    if force:
                        os.remove(target)
                    else:
                        print 'Exists!'
                        continue
                try:
                    os.symlink(source, target)
                    print 'Done'
                except OSError as e:
                    print 'Failed!'
            else:
                print 'Skipped'

if __name__ == '__main__':
    sys.exit(main(sys.argv))
