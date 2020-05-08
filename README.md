<!--
SPDX-FileCopyrightText: 2020 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>

SPDX-License-Identifier: GPL-3.0-or-later
-->

# translation-action

[![License](https://img.shields.io/badge/license-GPLv3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)

This action does the following tasks:

 1. Regenerate translation source files
 2. Push source files to Transifex in order to rebase the translations
 3. Pull rebased translations from Transifex
 4. Commit and push to git

Your project must have a `sources.json` file, usually located under the `.tx` directory.

This file contains a list of objects with the following keys:

  * `type`: contains `ts`, `desktop` or `metainfo`
  * `directory`: sources directory, only for `ts`
  * `source_file`: template file, only for `desktop` and `metainfo`
  * `file_filter`: filter of the source files, only for `desktop` and `metainfo`
  * `output_path`: output file location

Here's an example of `.tx/sources.json` from [Liri Text](https://github.com/lirios/text/blob/develop/.tx/sources.json):

```json
[
  {
    "type": "ts",
    "directory": "src",
    "output_path": "translations/app/liri-text.ts"
  },
  {
    "type": "desktop",
    "source_file": "data/io.liri.Text.desktop.in",
    "dest_file": "data/io.liri.Text.desktop",
    "file_filter": "translations/data/desktop/<lang>.po",
    "output_path": "translations/data/desktop/desktop.pot"
  },
  {
    "type": "metainfo",
    "source_file": "data/io.liri.Text.appdata.xml.in",
    "dest_file": "data/io.liri.Text.appdata.xml",
    "file_filter": "translations/data/metainfo/<lang>.po",
    "output_path": "translations/data/metainfo/metainfo.pot"
  }
]
```

## Usage

This action is usually called in a `schedule` workflow like this:

```yaml
name: Translations Sync

on:
  schedule:
    - cron: '0 15 * * 0'

jobs:
  update-translations:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Update translations
        uses: liri-infra/translation-action@master
        env:
          TX_TOKEN:  ${{ secrets.TX_TOKEN }}
        with:
          ssh_key: ${{ secrets.CI_SSH_KEY }}
```

The example checks out the project, configures git to push with a ssh key,
then update `.ts` files, push them to Transifex and pull back the
translations refreshed with the new sources.
