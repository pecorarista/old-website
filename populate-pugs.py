#!/usr/bin/env python

import json
import os

with open('posts.json', mode='r') as f:
    posts = json.load(f)

langs = ['en', 'ja']

for post in posts:
    for lang in langs:
        path = os.path.join('pug', lang, 'posts', post['id'] + '.pug')
        with open(path, mode='w+') as f:
            s = ('extends ../../_layout\n'
                 '\n'
                 'block content\n'
                 '  article\n'
                 '    include ../../_header.pug\n'
                 '    include ../../../html/{}/posts/{}.html\n')
            f.write(s.format(lang, post['id']))
